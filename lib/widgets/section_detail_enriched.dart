import 'package:flutter/material.dart';

import '../data/catalog/dart_lesson_content.dart';
import '../data/catalog/flutter_extended_lesson_content.dart';
import '../data/catalog/flutter_lesson_content.dart';
import '../models/course_section.dart';
import '../models/lesson_content.dart';
import '../services/library_controller.dart';
import 'dart_code_location_hint.dart';
import 'lesson_illustration.dart';
import 'widget_mobile_preview.dart';

class SectionDetail extends StatelessWidget {
  const SectionDetail({
    super.key,
    required this.section,
    required this.controller,
    this.onNavigate,
  });

  final CourseSection section;
  final LibraryController controller;
  final ValueChanged<CourseSection>? onNavigate;

  LessonContent? get lesson =>
      dartLessonContent[section.id] ??
      flutterLessonContent[section.id] ??
      flutterExtendedLessonContent[section.id];

  @override
  Widget build(BuildContext context) {
    final accent = Color(section.accentValue);
    final content = lesson;
    final completed = controller.completed.contains(section.id);
    final favorite = controller.favorites.contains(section.id);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Hero(section: section, accent: accent, completed: completed),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () => controller.toggleCompleted(section.id),
                    icon: Icon(
                      completed
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                    ),
                    label: Text(
                      completed ? 'Completada' : 'Marcar como completada',
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => controller.toggleFavorite(section.id),
                    icon: Icon(favorite ? Icons.star : Icons.star_border),
                    label: Text(
                      favorite ? 'En favoritos' : 'Agregar a favoritos',
                    ),
                  ),
                ],
              ),
              if (WidgetMobilePreview.supports(section)) ...[
                const SizedBox(height: 24),
                _Panel(
                  icon: Icons.phone_iphone_rounded,
                  title: 'Así se ve en un móvil',
                  subtitle:
                      'Vista construida con widgets reales de Flutter para relacionar el concepto con una interfaz de aplicación.',
                  child: WidgetMobilePreview(section: section),
                ),
              ],
              const SizedBox(height: 28),
              _Panel(
                icon: Icons.lightbulb_outline,
                title: 'Por qué importa',
                child: Text(
                  section.whyItMatters,
                  style: const TextStyle(height: 1.6),
                ),
              ),
              const SizedBox(height: 18),
              _Panel(
                icon: Icons.checklist_rounded,
                title: content == null ? 'Ruta guiada' : 'Qué aprenderás',
                child: _Points(
                  points: content?.concepts.isNotEmpty == true
                      ? content!.concepts
                      : section.steps,
                  accent: accent,
                ),
              ),
              if (content?.syntax.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                _Panel(
                  icon: Icons.code_rounded,
                  title: 'Sintaxis esencial',
                  subtitle:
                      'La forma mínima que debes reconocer antes de pasar a los ejemplos.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (DartCodeLocationHint.supports(section)) ...[
                        DartCodeLocationHint(
                          section: section,
                          label: 'Pon esta sintaxis en',
                        ),
                        const SizedBox(height: 12),
                      ],
                      _CodeBlock(code: content!.syntax),
                    ],
                  ),
                ),
              ],
              if (content?.examples.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                _Panel(
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Ejemplos prácticos',
                  subtitle:
                      'Lee el objetivo, revisa el código y compara con la salida esperada.',
                  child: Column(
                    children: [
                      for (var index = 0;
                          index < content!.examples.length;
                          index++) ...[
                        _ExampleCard(
                          number: index + 1,
                          example: content.examples[index],
                          accent: accent,
                          section: section,
                        ),
                        if (index != content.examples.length - 1)
                          const SizedBox(height: 14),
                      ],
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 18),
              _Panel(
                icon: Icons.integration_instructions_outlined,
                title: content == null
                    ? 'Código de referencia'
                    : 'Ejemplo integrador de la lección',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (DartCodeLocationHint.supports(section)) ...[
                      DartCodeLocationHint(
                        section: section,
                        label: 'Integra este código en',
                      ),
                      const SizedBox(height: 12),
                    ],
                    _CodeBlock(code: section.code),
                  ],
                ),
              ),
              if (content?.commonMistakes.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                _Panel(
                  icon: Icons.warning_amber_rounded,
                  title: 'Errores comunes',
                  child: Column(
                    children: [
                      for (final mistake in content!.commonMistakes)
                        _Callout(text: mistake),
                    ],
                  ),
                ),
              ],
              if (content?.exercises.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                _Panel(
                  icon: Icons.fitness_center_rounded,
                  title: 'Ejercicios',
                  subtitle:
                      'Intenta resolverlos sin copiar los ejemplos. Usa la pista solo si te bloqueas.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (DartCodeLocationHint.supports(section)) ...[
                        DartCodeLocationHint(
                          section: section,
                          label: 'Resuelve estos ejercicios en',
                          compact: true,
                        ),
                        const SizedBox(height: 12),
                      ],
                      for (var index = 0;
                          index < content!.exercises.length;
                          index++) ...[
                        _ExerciseCard(
                          number: index + 1,
                          exercise: content.exercises[index],
                          accent: accent,
                        ),
                        if (index != content.exercises.length - 1)
                          const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 18),
              _Panel(
                icon: Icons.bolt_rounded,
                title: 'Reto final',
                child: Text(
                  section.challenge,
                  style: const TextStyle(height: 1.6),
                ),
              ),
              const SizedBox(height: 28),
              _Navigation(
                previous: controller.previousOf(section),
                next: controller.nextOf(section),
                onNavigate: (target) {
                  controller.select(target.id);
                  onNavigate?.call(target);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({
    required this.section,
    required this.accent,
    required this.completed,
  });

  final CourseSection section;
  final Color accent;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.alphaBlend(
              accent.withValues(alpha: .13),
              scheme.surface,
            ),
            scheme.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent.withValues(alpha: .3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Tag(label: section.group, accent: accent),
              _Tag(label: section.level),
              if (completed)
                const _Tag(
                  label: 'Completada',
                  accent: Color(0xFF10B981),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            section.title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            section.description,
            style: TextStyle(
              fontSize: 17,
              height: 1.6,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 22),
          LessonIllustration(section: section),
        ],
      ),
    );
  }
}

class _Points extends StatelessWidget {
  const _Points({required this.points, required this.accent});

  final List<String> points;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < points.length; index++)
          Padding(
            padding: EdgeInsets.only(
              bottom: index == points.length - 1 ? 0 : 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: accent.withValues(alpha: .14),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    points[index],
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.number,
    required this.example,
    required this.accent,
    required this.section,
  });

  final int number;
  final LessonExample example;
  final Color accent;
  final CourseSection section;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: accent.withValues(alpha: .14),
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  example.title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            example.explanation,
            style: const TextStyle(height: 1.5),
          ),
          if (DartCodeLocationHint.supports(section)) ...[
            const SizedBox(height: 10),
            DartCodeLocationHint(
              section: section,
              label: 'Prueba este ejemplo en',
              compact: true,
            ),
          ],
          const SizedBox(height: 12),
          _CodeBlock(code: example.code),
          if (example.output.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Text(
              'Salida esperada',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            _OutputBlock(output: example.output),
          ],
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({
    required this.number,
    required this.exercise,
    required this.accent,
  });

  final int number;
  final PracticeExercise exercise;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: _cardDecoration(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number.',
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 5),
                Text(
                  exercise.prompt,
                  style: const TextStyle(height: 1.45),
                ),
                if (exercise.hint.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Pista: ${exercise.hint}',
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Callout extends StatelessWidget {
  const _Callout({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.close_rounded,
            size: 18,
            color: Color(0xFFEF4444),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(text, style: const TextStyle(height: 1.45)),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF050A12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF263244)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableText(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            height: 1.55,
            color: Color(0xFFD7E3F4),
          ),
        ),
      ),
    );
  }
}

class _OutputBlock extends StatelessWidget {
  const _OutputBlock({required this.output});

  final String output;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF071A15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF34D399).withValues(alpha: .35),
        ),
      ),
      child: SelectableText(
        output,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
          color: Color(0xFF6EE7B7),
        ),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    required this.previous,
    required this.next,
    required this.onNavigate,
  });

  final CourseSection? previous;
  final CourseSection? next;
  final ValueChanged<CourseSection> onNavigate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final previousButton = OutlinedButton.icon(
          onPressed: previous == null ? null : () => onNavigate(previous!),
          icon: const Icon(Icons.arrow_back),
          label: Text(previous?.title ?? 'Anterior'),
        );
        final nextButton = FilledButton.icon(
          onPressed: next == null ? null : () => onNavigate(next!),
          iconAlignment: IconAlignment.end,
          icon: const Icon(Icons.arrow_forward),
          label: Text(next?.title ?? 'Fin de la ruta'),
        );

        if (constraints.maxWidth < 680) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              previousButton,
              const SizedBox(height: 10),
              nextButton,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: previousButton),
            const SizedBox(width: 12),
            Expanded(child: nextButton),
          ],
        );
      },
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, this.accent});

  final String label;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = accent ?? scheme.onSurface;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: .22)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    required this.title,
    required this.child,
    this.icon,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
              if (icon != null) ...[
                Icon(icon, size: 19, color: scheme.primary),
                const SizedBox(width: 9),
              ],
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return BoxDecoration(
    color: scheme.surfaceContainerHighest.withValues(alpha: .45),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: scheme.outlineVariant),
  );
}
