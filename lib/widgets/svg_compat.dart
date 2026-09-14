import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renderiza assets SVG que contienen reglas CSS internas de forma compatible
/// con flutter_svg.
///
/// Algunos navegadores renderizan sin problema `<style>` + `class`, pero
/// flutter_svg puede ignorar parte de esas reglas. Esta utilidad convierte las
/// clases CSS simples en atributos SVG inline antes de pintar la imagen.
class CompatibleSvgAsset extends StatefulWidget {
  const CompatibleSvgAsset({
    super.key,
    required this.asset,
    this.fit = BoxFit.contain,
    this.semanticsLabel,
    this.placeholder,
  });

  final String asset;
  final BoxFit fit;
  final String? semanticsLabel;
  final Widget? placeholder;

  @override
  State<CompatibleSvgAsset> createState() => _CompatibleSvgAssetState();
}

class _CompatibleSvgAssetState extends State<CompatibleSvgAsset> {
  late Future<String> _svg;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant CompatibleSvgAsset oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asset != widget.asset) {
      _load();
    }
  }

  void _load() {
    _svg = rootBundle
        .loadString(widget.asset)
        .then(normalizeSvgCssForFlutter);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _svg,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SvgPicture.string(
            snapshot.data!,
            width: double.infinity,
            height: double.infinity,
            fit: widget.fit,
            semanticsLabel: widget.semanticsLabel,
          );
        }

        if (snapshot.hasError) {
          final scheme = Theme.of(context).colorScheme;
          return ColoredBox(
            color: scheme.surfaceContainerLow,
            child: Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: scheme.onSurfaceVariant,
                size: 34,
              ),
            ),
          );
        }

        return widget.placeholder ??
            const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
    );
  }
}

/// Convierte reglas CSS basadas en clases a atributos inline.
///
/// Soporta reglas como `.title{fill:#fff;font:700 22px Arial}` y selectores
/// combinados como `.white.big{font-size:30px}`. Los atributos definidos
/// directamente en el elemento tienen prioridad sobre la clase.
String normalizeSvgCssForFlutter(String source) {
  final styleBlock = RegExp(
    r'<style[^>]*>([\s\S]*?)</style>',
    caseSensitive: false,
  );

  final rules = <_SvgCssRule>[];
  for (final block in styleBlock.allMatches(source)) {
    final css = block.group(1) ?? '';
    final rulePattern = RegExp(r'([^{}]+)\{([^}]*)\}');

    for (final ruleMatch in rulePattern.allMatches(css)) {
      final declarations = ruleMatch.group(2) ?? '';
      for (final rawSelector in (ruleMatch.group(1) ?? '').split(',')) {
        final selector = rawSelector.trim();
        if (!selector.startsWith('.')) continue;

        final classes = RegExp(r'\.([A-Za-z0-9_-]+)')
            .allMatches(selector)
            .map((match) => match.group(1)!)
            .toSet();
        if (classes.isEmpty) continue;

        rules.add(
          _SvgCssRule(
            classes: classes,
            attributes: _cssDeclarationsToAttributes(declarations),
          ),
        );
      }
    }
  }

  if (rules.isEmpty) {
    return source.replaceAll(styleBlock, '');
  }

  var svg = source.replaceAll(styleBlock, '');
  final tagPattern = RegExp(r'<([A-Za-z][A-Za-z0-9:_-]*)([^<>]*?)>');
  final classPattern = RegExp(r'\sclass="([^"]+)"');
  final inlineStylePattern = RegExp(r'\sstyle="([^"]*)"');

  svg = svg.replaceAllMapped(tagPattern, (match) {
    final tag = match.group(1)!;
    var attrs = match.group(2) ?? '';
    final classMatch = classPattern.firstMatch(attrs);
    if (classMatch == null) return match.group(0)!;

    final classes = (classMatch.group(1) ?? '')
        .split(RegExp(r'\s+'))
        .where((value) => value.isNotEmpty)
        .toSet();

    final computed = <String, String>{};
    for (final rule in rules) {
      if (rule.classes.every(classes.contains)) {
        computed.addAll(rule.attributes);
      }
    }

    final inlineStyle = inlineStylePattern.firstMatch(attrs)?.group(1);
    if (inlineStyle != null && inlineStyle.isNotEmpty) {
      computed.addAll(_cssDeclarationsToAttributes(inlineStyle));
    }

    attrs = attrs.replaceAll(classPattern, '');
    attrs = attrs.replaceAll(inlineStylePattern, '');

    final trimmedRight = attrs.trimRight();
    final selfClosing = trimmedRight.endsWith('/');
    if (selfClosing) {
      attrs = trimmedRight.substring(0, trimmedRight.length - 1);
    }

    final additions = StringBuffer();
    for (final entry in computed.entries) {
      final propertyPattern = RegExp(
        '\\s${RegExp.escape(entry.key)}\\s*=',
        caseSensitive: false,
      );
      if (!propertyPattern.hasMatch(attrs)) {
        additions.write(' ${entry.key}="${entry.value}"');
      }
    }

    return '<$tag$attrs${additions.toString()}${selfClosing ? '/' : ''}>';
  });

  return svg;
}

Map<String, String> _cssDeclarationsToAttributes(String declarations) {
  final result = <String, String>{};

  for (final rawDeclaration in declarations.split(';')) {
    final declaration = rawDeclaration.trim();
    if (declaration.isEmpty) continue;

    final colon = declaration.indexOf(':');
    if (colon <= 0) continue;

    final property = declaration.substring(0, colon).trim();
    final value = declaration.substring(colon + 1).trim();
    if (property.isEmpty || value.isEmpty) continue;

    if (property == 'font') {
      final font = RegExp(
        r'(?:(\d+)\s+)?([0-9.]+)px\s+(.+)',
        caseSensitive: false,
      ).firstMatch(value);
      if (font != null) {
        final weight = font.group(1);
        if (weight != null) result['font-weight'] = weight;
        result['font-size'] = font.group(2)!;
        result['font-family'] = font.group(3)!.trim();
      }
      continue;
    }

    const supported = {
      'fill',
      'fill-opacity',
      'stroke',
      'stroke-width',
      'stroke-dasharray',
      'stroke-linecap',
      'stroke-linejoin',
      'font-family',
      'font-size',
      'font-weight',
      'text-anchor',
      'opacity',
    };

    if (supported.contains(property)) {
      result[property] = value.endsWith('px')
          ? value.substring(0, value.length - 2)
          : value;
    }
  }

  return result;
}

class _SvgCssRule {
  const _SvgCssRule({
    required this.classes,
    required this.attributes,
  });

  final Set<String> classes;
  final Map<String, String> attributes;
}
