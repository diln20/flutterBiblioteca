import 'package:flutter/material.dart';

import '../models/course_section.dart';
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
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
              const SizedBox(height: 16),
              Text(
                section.title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                section.description,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.55,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () => controller.toggleCompleted(section.id),
                    icon: Icon(
                      completed ? Icons.check_circle : Icons.radio_button_unchecked,
                    ),
                    label: Text(
                      completed ? 'Completada' : 'Marcar como completada',
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => controller.toggleFavorite(section.id),
                    icon: Icon(favorite ? Icons.star : Icons.star_border),
                    label: Text(favorite ? 'En favoritos' : 'Agregar a favoritos'),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _Panel(
                title: 'Por qué importa',
                child: Text(
                  section.whyItMatters,
                  style: const TextStyle(height: 1.55, color: Colors.white70),
                ),
              ),
              const SizedBox(height: 18),
              _Panel(
                title: 'Ruta guiada',
                child: Column(
                  children: [
                    for (var index = 0; index < section.steps.length; index++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
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
                                  color: accent.withValues(alpha: .45),
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
                                  section.steps[index],
                                  style: const TextStyle(height: 1.45),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _Panel(
                title: 'Código de referencia',
                child: Container(
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
                      section.code,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        height: 1.55,
                        color: Color(0xFFD7E3F4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _Panel(
                title: 'Reto',
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.bolt, color: accent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        section.challenge,
                        style: const TextStyle(height: 1.55, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: previous == null ? null : () => _navigate(previous),
                      icon: const Icon(Icons.arrow_back),
                      label: Text(previous?.title ?? 'Anterior'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: next == null ? null : () => _navigate(next),
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(next?.title ?? 'Fin de la ruta'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
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

class _Tag extends StatelessWidget {
  const _Tag({required this.label, this.accent});

  final String label;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: (accent ?? Colors.white).withValues(alpha: .08),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: (accent ?? Colors.white).withValues(alpha: .22),
        ),
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
  const _Panel({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
