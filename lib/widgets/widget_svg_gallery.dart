import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/course_section.dart';

class WidgetSvgGallery extends StatelessWidget {
  const WidgetSvgGallery({
    super.key,
    required this.section,
    this.compact = false,
  });

  final CourseSection section;
  final bool compact;

  static const _root = 'assets/illustrations/widget-previews';

  static bool supports(CourseSection section) => _visualsFor(section.id).isNotEmpty;

  static List<_WidgetVisual> _visualsFor(String id) {
    const scaffold = _WidgetVisual(
      asset: '$_root/scaffold-appbar-fab.svg',
      title: 'Estructura de pantalla',
      subtitle: 'Scaffold · AppBar · Body · FloatingActionButton',
    );
    const layout = _WidgetVisual(
      asset: '$_root/layout-row-column.svg',
      title: 'Distribución',
      subtitle: 'Row · Column',
    );
    const boxes = _WidgetVisual(
      asset: '$_root/container-padding-center.svg',
      title: 'Composición y espacio',
      subtitle: 'Container · Padding · Center',
    );
    const content = _WidgetVisual(
      asset: '$_root/text-icon-image.svg',
      title: 'Contenido visual',
      subtitle: 'Text · Icon · Image',
    );
    const cards = _WidgetVisual(
      asset: '$_root/card-listtile-buttons.svg',
      title: 'Componentes Material',
      subtitle: 'Card · ListTile · FilledButton · OutlinedButton',
    );
    const form = _WidgetVisual(
      asset: '$_root/form-textfield.svg',
      title: 'Entrada de datos',
      subtitle: 'Form · TextField · validación',
    );
    const lists = _WidgetVisual(
      asset: '$_root/list-grid.svg',
      title: 'Contenido desplazable',
      subtitle: 'ListView · GridView',
    );
    const navigation = _WidgetVisual(
      asset: '$_root/navigation-tabs-drawer.svg',
      title: 'Navegación móvil',
      subtitle: 'Navigator · TabBar · Drawer',
    );
    const feedback = _WidgetVisual(
      asset: '$_root/feedback-overlays.svg',
      title: 'Feedback y overlays',
      subtitle: 'SnackBar · Dialog · BottomSheet',
    );
    const state = _WidgetVisual(
      asset: '$_root/state-data.svg',
      title: 'Estado y datos',
      subtitle: 'Estado · Future/async · persistencia',
    );
    const theme = _WidgetVisual(
      asset: '$_root/theme-animation-interaction.svg',
      title: 'Experiencia visual',
      subtitle: 'ThemeData · animación · InkWell/Focus',
    );

    return switch (id) {
      'flutter-intro' => const [scaffold, content, cards],
      'widgets-layout' => const [layout, boxes, content],
      'estado-reactividad' => const [state, cards],
      'navegacion' => const [navigation, scaffold],
      'formularios' => const [form, cards],
      'async-api' => const [state, lists],
      'persistencia' => const [state, cards],
      'arquitectura' => const [state, scaffold],
      'testing' => const [cards, form],
      'rendimiento' => const [lists, state],
      'accesibilidad' => const [form, cards, navigation],
      'flutter-widget-lifecycle' => const [state, scaffold],
      'flutter-lists-grids' => const [lists, cards],
      'flutter-material3-theme' => const [theme, cards],
      'flutter-animations' => const [theme, cards],
      'flutter-gestures-focus' => const [theme, form],
      'flutter-feedback-overlays' => const [feedback, scaffold],
      'flutter-state-architecture' => const [state, lists],
      'flutter-offline-cache' => const [state, lists],
      _ => const <_WidgetVisual>[],
    };
  }

  @override
  Widget build(BuildContext context) {
    final visuals = _visualsFor(section.id);
    if (visuals.isEmpty) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final accent = Color(section.accentValue);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 14 : 20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: compact ? 34 : 38,
                height: compact ? 34 : 38,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  Icons.phone_iphone_rounded,
                  color: accent,
                  size: compact ? 19 : 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Widgets en acción',
                      style: TextStyle(
                        fontSize: compact ? 14 : 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Mira cómo se ven los widgets de esta lección dentro de una app móvil.',
                      maxLines: compact ? 2 : null,
                      overflow: compact ? TextOverflow.ellipsis : null,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: compact ? 10.5 : 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: compact ? 12 : 18),
          if (compact)
            SizedBox(
              height: 252,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: visuals.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 320,
                    child: _VisualCard(
                      visual: visuals[index],
                      accent: accent,
                      compact: true,
                    ),
                  );
                },
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final twoColumns = constraints.maxWidth >= 760;
                final cardWidth = twoColumns
                    ? (constraints.maxWidth - 14) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    for (final visual in visuals)
                      SizedBox(
                        width: cardWidth,
                        child: _VisualCard(
                          visual: visual,
                          accent: accent,
                        ),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

class _VisualCard extends StatelessWidget {
  const _VisualCard({
    required this.visual,
    required this.accent,
    this.compact = false,
  });

  final _WidgetVisual visual;
  final Color accent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 900 / 560,
            child: SvgPicture.asset(
              visual.asset,
              fit: BoxFit.cover,
              placeholderBuilder: (_) => ColoredBox(
                color: accent.withValues(alpha: .05),
                child: Center(
                  child: CircularProgressIndicator(color: accent),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              compact ? 12 : 14,
              compact ? 9 : 12,
              compact ? 12 : 14,
              compact ? 10 : 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visual.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: compact ? 12 : 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  visual.subtitle,
                  maxLines: compact ? 2 : null,
                  overflow: compact ? TextOverflow.ellipsis : null,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: compact ? 10 : 11,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WidgetVisual {
  const _WidgetVisual({
    required this.asset,
    required this.title,
    required this.subtitle,
  });

  final String asset;
  final String title;
  final String subtitle;
}
