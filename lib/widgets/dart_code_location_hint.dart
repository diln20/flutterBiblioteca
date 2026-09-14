import 'package:flutter/material.dart';

import '../data/dart_progressive_plan.dart';
import '../models/course_section.dart';
import '../models/guided_build_step.dart';

/// Indica junto a un bloque de código Dart dónde debe colocarlo el estudiante.
///
/// Complementa la guía práctica completa con una referencia inmediata de
/// archivo, ubicación y comando de ejecución.
class DartCodeLocationHint extends StatelessWidget {
  const DartCodeLocationHint({
    super.key,
    required this.section,
    this.label = 'Dónde poner este código',
    this.compact = false,
  });

  final CourseSection section;
  final String label;
  final bool compact;

  static bool supports(CourseSection section) =>
      dartProgressivePlan.containsKey(section.id);

  @override
  Widget build(BuildContext context) {
    final step = dartProgressivePlan[section.id];
    if (step == null) return const SizedBox.shrink();

    final target = _primaryPlacement(step);
    if (target == null) return const SizedBox.shrink();

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
          if (step.codePlacement.length > 1) ...[
            const SizedBox(height: 7),
            Text(
              '+ ${step.codePlacement.length - 1} archivo(s) relacionado(s) en el bloque práctico de esta lección.',
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

MapEntry<String, String>? _primaryPlacement(GuidedBuildStep step) {
  if (step.codePlacement.isNotEmpty) {
    return step.codePlacement.entries.first;
  }

  final file = step.createFiles.isNotEmpty
      ? step.createFiles.first
      : step.modifyFiles.isNotEmpty
          ? step.modifyFiles.first
          : null;
  if (file == null) return null;

  return MapEntry(
    file,
    'Coloca aquí el código de esta lección y compáralo con el ejemplo mostrado.',
  );
}

String? _runCommand(GuidedBuildStep step) {
  for (final command in step.commands.reversed) {
    if (command == 'dart run' || command.startsWith('dart run ')) {
      return command;
    }
  }
  return step.commands.isEmpty ? null : step.commands.last;
}
