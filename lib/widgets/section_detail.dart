import 'package:flutter/material.dart';

import '../data/catalog/dart_lesson_content.dart';
import '../models/course_section.dart';
import '../models/lesson_content.dart';
import '../services/library_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    final accent = Color(section.accentValue);
    final completed = controller.completed.contains(section.id);
    final favorite = controller.favorites.contains(section.id);
    final previous = controller.previousOf(section);
    final next = controller.nextOf(section);
    final lesson = dartLessonContent[section.id];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LessonHero(
                section: section,
                accent: accent,
                completed: completed,
              ),
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
              const SizedBox(height: 28),
              _Panel(
                icon: Icons.lightbulb_outline,
                title: 'Por qué importa',
                child: Text(
                  section.whyItMatters,
                  style: const TextStyle(
                    height: 1.6,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _Panel(
                icon: Icons.checklist_rounded,
                title: lesson == null ? 'Ruta guiada' : 'Qué aprenderás',
                child: _LearningPoints(
                  points: lesson?.concepts.isNotEmpty == true
                      ? lesson!.concepts
                      : section.steps,
                  accent: accent,
                ),
              ),
              if (lesson?.syntax.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                _Panel(
                  icon: Icons.code_rounded,
                  title: 'Sintaxis esencial',
                  subtitle:
                      'La forma mínima que debes reconocer antes de pasar a los ejemplos.',
                  child: _CodeBlock(code: lesson!.syntax),
                ),
              ],
              if (lesson?.examples.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                _Panel(
                  icon: Icons.play_circle_outline_rounded,
                  title: 'Ejemplos prácticos',
                  subtitle:
                      'Lee el objetivo, revisa el código y compara con la salida esperada.',
                  child: Column(
                    children: [
                      for (var index = 0;
                          index < lesson!.examples.length;
                          index++) ...[
                        _ExampleCard(
                          number: index + 1,
                          example: lesson.examples[index],
                          accent: accent,
                        ),
                        if (index != lesson.examples.length - 1)
                          const SizedBox(height: 14),
                      ],
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 18),
              _Panel(
                icon: Icons.integration_instructions_outlined,
                title: lesson == null
                    ? 'Código de referencia'
                    : 'Ejemplo integrador de la lección',
                child: _CodeBlock(code: section.code),
              ),
              if (lesson?.commonMistakes.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                _Panel(
                  icon: Icons.warning_amber_rounded,
                  title: 'Errores comunes',
                  subtitle: 'Problemas típicos que conviene reconocer desde ahora.',
                  child: Column(
                    children: [
                      for (final mistake in lesson!.commonMistakes)
                        _CalloutLine(
                          icon: Icons.close_rounded,
                          text: mistake,
                          color: const Color(0xFFFCA5A5),
                        ),
                    ],
                  ),
                ),
              ],
              if (lesson?.exercises.isNotEmpty == true) ...[
                const SizedBox(height: 18),
                _Panel(
                  icon: Icons.fitness_center_rounded,
                  title: 'Ejercicios',
                  subtitle:
                      'Intenta resolverlos sin copiar los ejemplos. Usa la pista solo si te bloqueas.',
                  child: Column(
                    children: [
                      for (var index = 0;
                          index < lesson!.exercises.length;
                          index++) ...[
                        _ExerciseCard(
                          number: index + 1,
                          exercise: lesson.exercises[index],
                          accent: accent,
                        ),
                        if (index != lesson.exercises.length - 1)
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.bolt_rounded, color: accent),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        section.challenge,
                        style: const TextStyle(
                          height: 1.6,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _RouteNavigation(
                previous: previous,
                next: next,
                onNavigate: _navigate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(CourseSection target) {
    controller.select(target.id);
    onNavigate?.call(target);
  }
}

class _LessonHero extends StatelessWidget {
  const _LessonHero({
    required this.section,
    required this.accent,
    required this.completed,
  });

  final CourseSection section;
  final Color accent;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: .16),
            const Color(0xFF0D1B2A),
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
                  accent: Color(0xFF34D399),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            section.title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -.7,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            section.description,
            style: const TextStyle(
              fontSize: 17,
              height: 1.6,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningPoints extends StatelessWidget {
  const _LearningPoints({required this.points, required this.accent});

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
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: .14),
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(
                      color: accent.withValues(alpha: .4),
                    ),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      points[index],
                      style: const TextStyle(height: 1.5),
                    ),
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
  });

  final int number;
  final LessonExample example;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF091522),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(9),
                ),
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
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            example.explanation,
            style: const TextStyle(height: 1.5, color: Colors.white60),
          ),
          const SizedBox(height: 12),
          _CodeBlock(code: example.code),
          if (example.output.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Text(
              'Salida esperada',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: .6,
              ),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF091522),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number.',
            style: TextStyle(color: accent, fontWeight: FontWeight.w900),
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
                  style: const TextStyle(height: 1.45, color: Colors.white70),
                ),
                if (exercise.hint.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.tips_and_updates_outlined,
                        size: 16,
                        color: Color(0xFFFACC15),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Pista: ${exercise.hint}',
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ],
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

class _CalloutLine extends StatelessWidget {
  const _CalloutLine({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.45, color: Colors.white70),
            ),
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
        border: Border.all(color: Colors.white10),
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
        border: Border.all(color: const Color(0xFF34D399).withValues(alpha: .22)),
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

class _RouteNavigation extends StatelessWidget {
  const _RouteNavigation({
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
        final compact = constraints.maxWidth < 680;
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

        if (compact) {
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
    final color = accent ?? Colors.white;
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
          color: accent ?? Colors.white70,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 19, color: Colors.white70),
                const SizedBox(width: 9),
              ],
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: const TextStyle(
                color: Colors.white54,
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
