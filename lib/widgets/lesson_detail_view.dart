import 'package:flutter/material.dart';

import '../models/course_section.dart';
import '../services/library_controller.dart';
import 'guided_project_panel.dart';
import 'section_detail_enriched.dart';
import 'widget_mobile_preview.dart';
import 'widget_svg_gallery.dart';

/// Compone la lección escrita con representaciones visuales y una práctica
/// incremental sobre la misma aplicación: "Mi Biblioteca".
class LessonDetailView extends StatelessWidget {
  const LessonDetailView({
    super.key,
    required this.section,
    required this.controller,
    this.onNavigate,
  });

  final CourseSection section;
  final LibraryController controller;
  final ValueChanged<CourseSection>? onNavigate;

  @override
  Widget build(BuildContext context) {
    if (!WidgetMobilePreview.supports(section)) {
      return SectionDetail(
        section: section,
        controller: controller,
        onNavigate: onNavigate,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1120) {
          return Row(
            children: [
              SizedBox(
                width: 420,
                child: _DesktopPreview(section: section),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: SectionDetail(
                  section: section,
                  controller: controller,
                  onNavigate: onNavigate,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            _CompactPreview(section: section),
            if (WidgetSvgGallery.supports(section))
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: WidgetSvgGallery(section: section, compact: true),
              ),
            if (GuidedProjectPanel.supports(section))
              _CompactProjectStep(section: section),
            const Divider(height: 1),
            Expanded(
              child: SectionDetail(
                section: section,
                controller: controller,
                onNavigate: onNavigate,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DesktopPreview extends StatelessWidget {
  const _DesktopPreview({required this.section});

  final CourseSection section;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = Color(section.accentValue);

    return ColoredBox(
      color: scheme.surfaceContainerLowest,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(Icons.phone_iphone_rounded, color: accent),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ASÍ SE VE EN UN MÓVIL',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .9,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Interfaz construida con widgets reales de Flutter',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            WidgetMobilePreview(section: section),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: .07),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: accent.withValues(alpha: .18)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.code_rounded, size: 17, color: accent),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'La preview superior es interactiva. Debajo tienes diagramas SVG que señalan cada widget y el paso práctico para continuar la misma aplicación.',
                      style: TextStyle(fontSize: 10.5, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            if (WidgetSvgGallery.supports(section)) ...[
              const SizedBox(height: 18),
              WidgetSvgGallery(section: section),
            ],
            if (GuidedProjectPanel.supports(section)) ...[
              const SizedBox(height: 18),
              GuidedProjectPanel(section: section),
            ],
          ],
        ),
      ),
    );
  }
}

class _CompactProjectStep extends StatelessWidget {
  const _CompactProjectStep({required this.section});

  final CourseSection section;

  @override
  Widget build(BuildContext context) {
    final accent = Color(section.accentValue);
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Material(
        color: Color.alphaBlend(accent.withValues(alpha: .07), scheme.surface),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showProjectStep(context),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: accent.withValues(alpha: .24)),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(Icons.construction_rounded, color: accent, size: 20),
                ),
                const SizedBox(width: 11),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Continúa construyendo Mi Biblioteca',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Archivos a crear/modificar, tareas y resultado esperado de esta lección.',
                        style: TextStyle(fontSize: 10.5, height: 1.35),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, color: accent),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showProjectStep(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: .9,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
            child: GuidedProjectPanel(section: section),
          ),
        );
      },
    );
  }
}

class _CompactPreview extends StatelessWidget {
  const _CompactPreview({required this.section});

  final CourseSection section;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = Color(section.accentValue);

    return Container(
      color: scheme.surface,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vista en móvil',
                  style: TextStyle(
                    color: accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Ejemplo real de ${section.title}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 10,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 76,
            height: 118,
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 350,
                height: 602,
                child: WidgetMobilePreview(section: section),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filledTonal(
            tooltip: 'Ampliar vista móvil',
            onPressed: () => _showLargePreview(context),
            icon: const Icon(Icons.open_in_full_rounded),
          ),
        ],
      ),
    );
  }

  void _showLargePreview(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(18),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920, maxHeight: 860),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.phone_iphone_rounded),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          section.title,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Cerrar',
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                  Divider(color: scheme.outlineVariant),
                  Flexible(
                    child: SingleChildScrollView(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final wide = constraints.maxWidth >= 760;
                          if (wide) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 350,
                                  child: WidgetMobilePreview(section: section),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Column(
                                    children: [
                                      WidgetSvgGallery(section: section),
                                      if (GuidedProjectPanel.supports(section)) ...[
                                        const SizedBox(height: 18),
                                        GuidedProjectPanel(section: section),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Column(
                            children: [
                              WidgetMobilePreview(section: section),
                              const SizedBox(height: 18),
                              WidgetSvgGallery(section: section),
                              if (GuidedProjectPanel.supports(section)) ...[
                                const SizedBox(height: 18),
                                GuidedProjectPanel(section: section),
                              ],
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
