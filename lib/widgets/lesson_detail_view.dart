import 'package:flutter/material.dart';

import '../models/course_section.dart';
import '../services/library_controller.dart';
import 'guided_project_panel.dart';
import 'lesson_visual_poster.dart';
import 'section_detail_enriched.dart';
import 'widget_mobile_preview.dart';

/// Compone cada lección Flutter con tres capas:
/// 1. imagen representativa del concepto,
/// 2. preview real de la interfaz móvil,
/// 3. práctica incremental sobre la app "Mi Biblioteca".
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
    final hasVisual = LessonVisualPoster.supports(section);
    final hasPreview = WidgetMobilePreview.supports(section);
    final hasProject = GuidedProjectPanel.supports(section);

    if (!hasVisual && !hasPreview && !hasProject) {
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
                width: 440,
                child: _DesktopLearningRail(section: section),
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
            if (hasVisual)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                child: LessonVisualPoster(section: section),
              ),
            if (hasPreview) _CompactPreview(section: section),
            if (hasProject) _CompactProjectStep(section: section),
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

class _DesktopLearningRail extends StatelessWidget {
  const _DesktopLearningRail({required this.section});

  final CourseSection section;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = Color(section.accentValue);

    return ColoredBox(
      color: scheme.surfaceContainerLowest,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(Icons.school_rounded, color: accent),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'APRENDE VIENDO Y CONSTRUYENDO',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .75,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Imagen · preview móvil · práctica guiada',
                        style: TextStyle(fontSize: 10.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (LessonVisualPoster.supports(section)) ...[
              const SizedBox(height: 16),
              LessonVisualPoster(section: section),
            ],
            if (WidgetMobilePreview.supports(section)) ...[
              const SizedBox(height: 18),
              _SectionLabel(
                icon: Icons.phone_iphone_rounded,
                title: 'Preview real en móvil',
                subtitle: 'Construido con widgets reales de Flutter.',
                accent: accent,
              ),
              const SizedBox(height: 12),
              WidgetMobilePreview(section: section),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accent, size: 20),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 10.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
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
        color: Color.alphaBlend(
          accent.withValues(alpha: .07),
          scheme.surface,
        ),
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
                  child: Icon(
                    Icons.construction_rounded,
                    color: accent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 11),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Continúa construyendo Mi Biblioteca',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Archivos, tareas y resultado esperado de esta etapa.',
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
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preview real en móvil',
                  style: TextStyle(
                    color: accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Mira cómo se comporta ${section.title} dentro de una app.',
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
            width: 70,
            height: 108,
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
            tooltip: 'Ampliar material visual',
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
            constraints: const BoxConstraints(maxWidth: 980, maxHeight: 860),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.image_outlined),
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

                          final preview = Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (LessonVisualPoster.supports(section))
                                LessonVisualPoster(section: section),
                              const SizedBox(height: 18),
                              WidgetMobilePreview(section: section),
                            ],
                          );

                          final project = GuidedProjectPanel.supports(section)
                              ? GuidedProjectPanel(section: section)
                              : const SizedBox.shrink();

                          if (wide) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: preview),
                                const SizedBox(width: 18),
                                Expanded(child: project),
                              ],
                            );
                          }

                          return Column(
                            children: [
                              preview,
                              if (GuidedProjectPanel.supports(section)) ...[
                                const SizedBox(height: 18),
                                project,
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
