import 'package:flutter/material.dart';

import '../models/course_section.dart';
import '../services/library_controller.dart';
import 'lesson_illustration.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.section,
    required this.controller,
    required this.onOpen,
  });

  final CourseSection section;
  final LibraryController controller;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = Color(section.accentValue);
    final selected = section.id == controller.selectedId;
    final done = controller.completed.contains(section.id);
    final favorite = controller.favorites.contains(section.id);
    final searchActive = controller.query.trim().isNotEmpty;

    return Material(
      color: selected || searchActive
          ? Color.alphaBlend(accent.withValues(alpha: .09), scheme.surface)
          : scheme.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onOpen,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected || searchActive
                  ? accent.withValues(alpha: .55)
                  : scheme.outlineVariant,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 560;
              final illustration = SizedBox(
                width: wide ? 150 : double.infinity,
                child: LessonIllustration(section: section, compact: true),
              );
              final content = _CardContent(
                section: section,
                accent: accent,
                favorite: favorite,
                done: done,
                searchActive: searchActive,
                onFavorite: () => controller.toggleFavorite(section.id),
              );

              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    illustration,
                    const SizedBox(width: 16),
                    Expanded(child: content),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  illustration,
                  const SizedBox(height: 14),
                  content,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.section,
    required this.accent,
    required this.favorite,
    required this.done,
    required this.searchActive,
    required this.onFavorite,
  });

  final CourseSection section;
  final Color accent;
  final bool favorite;
  final bool done;
  final bool searchActive;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _Pill(label: section.group, foreground: accent),
            _Pill(label: section.level),
            if (searchActive)
              _Pill(label: 'Coincidencia', foreground: accent),
            if (done)
              const _Pill(
                label: 'Completada',
                foreground: Color(0xFF10B981),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                section.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              tooltip: favorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
              onPressed: onFavorite,
              icon: Icon(
                favorite ? Icons.star_rounded : Icons.star_border_rounded,
                color: favorite ? Colors.amber : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          section.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 12,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.arrow_forward_rounded, size: 17, color: accent),
            const SizedBox(width: 6),
            Text(
              'Abrir lección',
              style: TextStyle(
                color: accent,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, this.foreground});

  final String label;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = foreground ?? scheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: .20)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
