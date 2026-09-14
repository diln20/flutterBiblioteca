import 'package:flutter/material.dart';

import '../models/course_section.dart';
import '../models/guided_build_step.dart';
import 'guided_project_panel.dart';

/// Indica junto a cada bloque dónde debe colocarse y cómo ejecutarse.
///
/// Aunque el archivo conserva su nombre histórico, esta guía ya funciona para
/// Dart, Flutter y los proyectos finales.
class LessonCodeLocationHint extends StatelessWidget {
  const LessonCodeLocationHint({
    super.key,
    required this.section,
    this.label = 'Dónde poner este código',
    this.compact = false,
  });

  final CourseSection section;
  final String label;
  final bool compact;

  static bool supports(CourseSection section) =>
      GuidedProjectPanel.supports(section) &&
      GuidedProjectPanel.codePlacementFor(section).isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final step = GuidedProjectPanel.stepFor(section);
    final placements = GuidedProjectPanel.codePlacementFor(section);
    if (step == null || placements.isEmpty) return const SizedBox.shrink();

    final target = placements.entries.first;
    final accent = Color(section.accentValue);
    final scheme = Theme.of(context).colorScheme;
    final command = _runCommand(step);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 11 : 13),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          accent.withValues(alpha: .07),
          scheme.surface,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: .24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.description_outlined, size: 17, color: accent),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SelectableText(
                      target.key,
                      style: TextStyle(
                        color: accent,
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            target.value,
            maxLines: compact ? 3 : null,
            overflow: compact ? TextOverflow.ellipsis : null,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 11,
              height: 1.4,
            ),
          ),
          if (placements.length > 1) ...[
            const SizedBox(height: 7),
            Text(
              '+ ${placements.length - 1} archivo(s) relacionado(s) detallados en la práctica guiada.',
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (command != null) ...[
            const SizedBox(height: 9),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 7,
              runSpacing: 5,
              children: [
                Icon(Icons.terminal_rounded, size: 15, color: accent),
                const Text(
                  'Ejecuta desde la raíz:',
                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700),
                ),
                SelectableText(
                  command,
                  style: TextStyle(
                    color: accent,
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

String? _runCommand(GuidedBuildStep step) {
  for (final wanted in const <String>['flutter run', 'dart run']) {
    for (final command in step.commands.reversed) {
      if (command == wanted || command.startsWith('$wanted ')) {
        return command;
      }
    }
  }
  return step.commands.isEmpty ? null : step.commands.last;
}
