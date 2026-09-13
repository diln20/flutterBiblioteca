import 'package:flutter/material.dart';

import '../models/course_section.dart';
import '../services/library_controller.dart';

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
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onOpen,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected || searchActive
                  ? accent.withValues(alpha: .55)
                  : scheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 58,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          section.group,
                          style: TextStyle(
                            color: accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          section.level,
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontSize: 11,
                          ),
                        ),
                        if (searchActive)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: .12),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              'Coincidencia',
                              style: TextStyle(
                                color: accent,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      section.title,
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      section.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: favorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
                onPressed: () => controller.toggleFavorite(section.id),
                icon: Icon(
                  favorite ? Icons.star : Icons.star_border,
                  color: favorite ? Colors.amber : scheme.onSurfaceVariant,
                ),
              ),
              if (done)
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF34D399),
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
