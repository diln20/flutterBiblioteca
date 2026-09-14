// ignore_for_file: deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

/// Renderiza el asset con un `<img>` HTML real cuando la app corre en web.
///
/// El navegador interpreta directamente los SVG (incluyendo CSS interno),
/// evitando las diferencias de compatibilidad de flutter_svg.
class HtmlAssetImage extends StatefulWidget {
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
  State<HtmlAssetImage> createState() => _HtmlAssetImageState();
}

class _HtmlAssetImageState extends State<HtmlAssetImage> {
  late String _viewType;

  @override
  void initState() {
    super.initState();
    _registerView();
  }

  @override
  void didUpdateWidget(covariant HtmlAssetImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asset != widget.asset || oldWidget.fit != widget.fit) {
      _registerView();
    }
  }

  void _registerView() {
    _viewType = 'lesson-html-image-${identityHashCode(this)}-${DateTime.now().microsecondsSinceEpoch}';
    final assetUrl = 'assets/${widget.asset}';
    final objectFit = _objectFit(widget.fit);
    final label = widget.semanticsLabel ?? '';

    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) {
        final image = html.ImageElement()
          ..src = assetUrl
          ..alt = label;

        image.style
          ..width = '100%'
          ..height = '100%'
          ..display = 'block'
          ..objectFit = objectFit
          ..objectPosition = 'center'
          ..pointerEvents = 'none';

        final wrapper = html.DivElement();
        wrapper.style
          ..width = '100%'
          ..height = '100%'
          ..overflow = 'hidden'
          ..backgroundColor = 'transparent';
        wrapper.attributes['role'] = 'img';
        if (label.isNotEmpty) {
          wrapper.attributes['aria-label'] = label;
        }
        wrapper.append(image);
        return wrapper;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(
      key: ValueKey(_viewType),
      viewType: _viewType,
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
