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
              final horizontal = constraints.maxWidth >= 300;
              final illustration = SizedBox(
                width: horizontal ? 104 : double.infinity,
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

              if (horizontal) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    illustration,
                    const SizedBox(width: 14),
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
          spacing: 6,
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
        const SizedBox(height: 9),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                section.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: scheme.onSurface,
                      fontWeight: FontWeight.w900,
                      height: 1.25,
                    ),
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
              padding: EdgeInsets.zero,
              tooltip: favorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
              onPressed: onFavorite,
              icon: Icon(
                favorite ? Icons.star_rounded : Icons.star_border_rounded,
                size: 20,
                color: favorite ? Colors.amber : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          section.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 11,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            Icon(Icons.arrow_forward_rounded, size: 15, color: accent),
            const SizedBox(width: 5),
            Text(
              'Abrir lección',
              style: TextStyle(
                color: accent,
                fontSize: 11,
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
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: .20)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
