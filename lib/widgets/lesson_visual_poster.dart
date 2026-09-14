import 'package:flutter/material.dart';

import '../models/course_section.dart';
import 'html_asset_image.dart';
import 'widget_visual_carousel.dart';

/// Imagen principal de cada lección Flutter.
///
/// En Flutter Web el poster se pinta como un `<img>` HTML real para que el
/// navegador interprete el SVG completo sin perder estilos. En otras
/// plataformas usa el fallback compatible de Flutter.
class LessonVisualPoster extends StatelessWidget {
  const LessonVisualPoster({
    super.key,
    required this.section,
  });

  final CourseSection section;

  static const _root = 'assets/illustrations/widget-previews';

  static bool supports(CourseSection section) =>
      assetFor(section.id) != null;

  static String? assetFor(String id) {
    return switch (id) {
      'flutter-intro' => '$_root/scaffold-appbar-fab.svg',
      'widgets-layout' => '$_root/container-padding-center.svg',
      'estado-reactividad' => '$_root/state-data.svg',
      'navegacion' => '$_root/navigation-tabs-drawer.svg',
      'formularios' => '$_root/form-textfield.svg',
      'async-api' => '$_root/state-data.svg',
      'persistencia' => '$_root/state-data.svg',
      'arquitectura' => '$_root/state-data.svg',
      'testing' => '$_root/card-listtile-buttons.svg',
      'rendimiento' => '$_root/list-grid.svg',
      'accesibilidad' => '$_root/form-textfield.svg',
      'flutter-widget-lifecycle' => '$_root/scaffold-appbar-fab.svg',
      'flutter-lists-grids' => '$_root/list-grid.svg',
      'flutter-material3-theme' => '$_root/theme-animation-interaction.svg',
      'flutter-animations' => '$_root/theme-animation-interaction.svg',
      'flutter-gestures-focus' => '$_root/theme-animation-interaction.svg',
      'flutter-feedback-overlays' => '$_root/feedback-overlays.svg',
      'flutter-state-architecture' => '$_root/state-data.svg',
      'flutter-offline-cache' => '$_root/state-data.svg',
      _ => null,
    };
  }

  static String captionFor(String id) {
    return switch (id) {
      'flutter-intro' => 'Scaffold · AppBar · Body · FloatingActionButton',
      'widgets-layout' => 'Container · Padding · Center · Row · Column',
      'estado-reactividad' => 'Estado reactivo · UI · datos',
      'navegacion' => 'Navigator · Drawer · tabs · pantalla detalle',
      'formularios' => 'Form · TextField · validación · guardar',
      'async-api' => 'Future · async/await · API · loading',
      'persistencia' => 'Datos locales · favoritos · persistencia',
      'arquitectura' => 'UI · Controller · Repository · datos',
      'testing' => 'Componentes comprobables y estados previsibles',
      'rendimiento' => 'ListView · GridView · contenido eficiente',
      'accesibilidad' => 'Campos, botones, foco y navegación accesible',
      'flutter-widget-lifecycle' => 'Widget · State · build · dispose',
      'flutter-lists-grids' => 'ListView · GridView · items · scroll',
      'flutter-material3-theme' => 'ThemeData · Material 3 · sistema visual',
      'flutter-animations' => 'Animaciones y transiciones de la interfaz',
      'flutter-gestures-focus' => 'InkWell · Focus · teclado · interacción',
      'flutter-feedback-overlays' => 'SnackBar · Dialog · BottomSheet',
      'flutter-state-architecture' => 'Controller · Repository · estado por feature',
      'flutter-offline-cache' => 'API · caché · almacenamiento local · sincronización',
      _ => '',
    };
  }

  @override
  Widget build(BuildContext context) {
    final asset = assetFor(section.id);
    if (asset == null) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final accent = Color(section.accentValue);

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withValues(alpha: .24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 900 / 560,
            child: HtmlAssetImage(
              asset: asset,
              fit: BoxFit.cover,
              semanticsLabel: 'Imagen visual de ${section.title}',
              placeholder: ColoredBox(
                color: scheme.surfaceContainerLow,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: accent,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: .11),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(Icons.image_outlined, color: accent),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Imagen representativa de la lección',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        captionFor(section.id),
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: 11.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (WidgetVisualCarousel.supports(section)) ...[
            Divider(height: 1, color: scheme.outlineVariant),
            Padding(
              padding: const EdgeInsets.all(14),
              child: WidgetVisualCarousel(section: section),
            ),
          ],
        ],
      ),
    );
  }
}
