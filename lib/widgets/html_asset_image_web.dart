import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Renderiza el asset con un `<img>` HTML real cuando la app corre en web.
///
/// El navegador interpreta directamente los SVG (incluyendo CSS interno),
/// evitando las diferencias de compatibilidad de flutter_svg.
class HtmlAssetImage extends StatelessWidget {
  const HtmlAssetImage({
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
  Widget build(BuildContext context) {
    final assetUrl = 'assets/$asset';
    final objectFit = _objectFit(fit);
    final label = semanticsLabel ?? '';

    return HtmlElementView.fromTagName(
      tagName: 'img',
      onElementCreated: (Object element) {
        final image = element as web.HTMLImageElement;
        image
          ..src = assetUrl
          ..alt = label;

        image.style
          ..width = '100%'
          ..height = '100%'
          ..display = 'block'
          ..objectFit = objectFit
          ..objectPosition = 'center'
          ..pointerEvents = 'none';

        image.setAttribute('role', 'img');
        if (label.isNotEmpty) {
          image.setAttribute('aria-label', label);
        }
      },
    );
  }
}

String _objectFit(BoxFit fit) {
  return switch (fit) {
    BoxFit.fill => 'fill',
    BoxFit.contain => 'contain',
    BoxFit.cover => 'cover',
    BoxFit.fitWidth => 'cover',
    BoxFit.fitHeight => 'cover',
    BoxFit.none => 'none',
    BoxFit.scaleDown => 'scale-down',
  };
}
