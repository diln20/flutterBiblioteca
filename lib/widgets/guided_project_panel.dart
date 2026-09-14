import 'package:flutter/material.dart';

import '../data/dart_progressive_plan.dart';
import '../data/progressive_app_plan.dart';
import '../models/course_section.dart';
import '../models/guided_build_step.dart';

class GuidedProjectPanel extends StatelessWidget {
  const GuidedProjectPanel({
    super.key,
    required this.section,
  });

  final CourseSection section;

  static bool supports(CourseSection section) =>
      progressiveAppPlan.containsKey(section.id) ||
      dartProgressivePlan.containsKey(section.id);

  static GuidedBuildStep? stepFor(CourseSection section) =>
      progressiveAppPlan[section.id] ?? dartProgressivePlan[section.id];

  @override
  Widget build(BuildContext context) {
    final step = stepFor(section);
    if (step == null) return const SizedBox.shrink();

    final isDart = dartProgressivePlan.containsKey(section.id);
    final accent = Color(section.accentValue);
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          accent.withValues(alpha: .045),
          scheme.surface,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: .28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(
            step: step,
            accent: accent,
            isDart: isDart,
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: step.number / step.total,
            minHeight: 7,
            borderRadius: BorderRadius.circular(99),
          ),
          const SizedBox(height: 18),
          Text(
            step.goal,
            style: const TextStyle(fontSize: 14, height: 1.55),
          ),
          if (step.commands.isNotEmpty) ...[
            const SizedBox(height: 18),
            const _SectionLabel(
              icon: Icons.terminal_rounded,
              label: 'Comandos',
            ),
            const SizedBox(height: 8),
            _CodeList(items: step.commands),
          ],
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 720;
              final create = _FilesCard(
                title: 'Archivos a crear',
                icon: Icons.note_add_outlined,
                files: step.createFiles,
                accent: accent,
                emptyText: 'No necesitas crear archivos nuevos en este paso.',
              );
              final modify = _FilesCard(
                title: 'Archivos a modificar',
                icon: Icons.edit_note_rounded,
                files: step.modifyFiles,
                accent: accent,
                emptyText: 'Este paso no requiere modificar archivos existentes.',
              );

              if (!wide) {
                return Column(
                  children: [
                    create,
                    const SizedBox(height: 12),
                    modify,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: create),
                  const SizedBox(width: 12),
                  Expanded(child: modify),
                ],
              );
            },
          ),
          if (step.codePlacement.isNotEmpty) ...[
            const SizedBox(height: 18),
            const _SectionLabel(
              icon: Icons.account_tree_outlined,
              label: 'Dónde poner el código',
            ),
            const SizedBox(height: 10),
            _CodePlacementList(
              entries: step.codePlacement,
              accent: accent,
            ),
          ],
          const SizedBox(height: 18),
          _SectionLabel(
            icon: Icons.construction_rounded,
            label: isDart
                ? 'Programa esta parte ahora'
                : 'Construye esta parte ahora',
          ),
          const SizedBox(height: 10),
          _TaskList(tasks: step.tasks, accent: accent),
          const SizedBox(height: 18),
          _ResultCard(
            title: 'Resultado esperado',
            icon: isDart
                ? Icons.terminal_rounded
                : Icons.phone_android_rounded,
            text: step.expectedResult,
            accent: accent,
          ),
          const SizedBox(height: 10),
          _ResultCard(
            title: 'Checkpoint antes de continuar',
            icon: Icons.verified_rounded,
            text: step.checkpoint,
            accent: const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.step,
    required this.accent,
    required this.isDart,
  });

  final GuidedBuildStep step;
  final Color accent;
  final bool isDart;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            isDart ? Icons.code_rounded : Icons.build_circle_outlined,
            color: accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isDart
                    ? 'PROYECTO DART · BIBLIOTECA DE CONSOLA'
                    : 'PROYECTO CONTINUO · MI BIBLIOTECA',
                style: TextStyle(
                  color: accent,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .75,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                isDart
                    ? 'Paso ${step.number} de ${step.total} · Continúa sobre el mismo proyecto de consola.'
                    : 'Paso ${step.number} de ${step.total} · Continúa sobre lo construido en la lección anterior.',
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}

class _FilesCard extends StatelessWidget {
  const _FilesCard({
    required this.title,
    required this.icon,
    required this.files,
    required this.accent,
    required this.emptyText,
  });

  final String title;
  final IconData icon;
  final List<String> files;
  final Color accent;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 17, color: accent),
              const SizedBox(width: 7),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (files.isEmpty)
            Text(
              emptyText,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 11,
                height: 1.4,
              ),
            )
          else
            for (final file in files)
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 14,
                      color: accent,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: SelectableText(
                        file,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.5,
                          height: 1.35,
                        ),
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

class _CodePlacementList extends StatelessWidget {
  const _CodePlacementList({
    required this.entries,
    required this.accent,
  });

  final Map<String, String> entries;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        for (final entry in entries.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: .11),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(
                      Icons.code_rounded,
                      size: 16,
                      color: accent,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          entry.key,
                          style: TextStyle(
                            color: accent,
                            fontFamily: 'monospace',
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          entry.value,
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontSize: 11,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({required this.tasks, required this.accent});

  final List<String> tasks;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < tasks.length; index++)
          Padding(
            padding: EdgeInsets.only(
              bottom: index == tasks.length - 1 ? 0 : 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: .12),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: accent,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    tasks[index],
                    style: const TextStyle(height: 1.45),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CodeList extends StatelessWidget {
  const _CodeList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFF050A12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in items)
            SelectableText(
              r'$ ' + item,
              style: const TextStyle(
                color: Color(0xFFB7F7D1),
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.6,
              ),
            ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.title,
    required this.icon,
    required this.text,
    required this.accent,
  });

  final String title;
  final IconData icon;
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: .07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: .2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: accent),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(fontSize: 11.5, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
