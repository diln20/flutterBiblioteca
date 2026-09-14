import 'package:flutter/material.dart';

import 'svg_compat.dart';

/// Fallback para plataformas no web.
///
/// En Android/iOS/Desktop seguimos usando el renderizador SVG compatible.
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
    return CompatibleSvgAsset(
      asset: asset,
      fit: fit,
      semanticsLabel: semanticsLabel,
      placeholder: placeholder,
    );
  }
}
