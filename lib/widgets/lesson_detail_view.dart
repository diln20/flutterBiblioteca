import 'package:flutter/material.dart';

import '../models/course_section.dart';
import '../services/library_controller.dart';
import 'section_detail_enriched.dart';
import 'widget_mobile_preview.dart';

/// Compone la lección escrita con una representación real de la interfaz móvil.
///
/// En escritorio mantiene el teléfono visible al lado del contenido. En móvil
/// muestra una vista compacta arriba y permite ampliarla en un diálogo.
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
                width: 400,
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
                      'No es una captura: esta pantalla está hecha con los mismos componentes que estudias en la lección.',
                      style: TextStyle(fontSize: 10.5, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
            constraints: const BoxConstraints(maxWidth: 470, maxHeight: 820),
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
                      child: WidgetMobilePreview(section: section),
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
