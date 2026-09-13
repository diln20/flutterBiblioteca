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
    final accent = Color(section.accentValue);
    final selected = section.id == controller.selectedId;
    final done = controller.completed.contains(section.id);
    final favorite = controller.favorites.contains(section.id);

    return Material(
      color: selected ? accent.withValues(alpha: .12) : const Color(0xFF0D1B2A),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onOpen,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? accent.withValues(alpha: .6) : Colors.white10,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 48,
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
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      section.title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: favorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
                onPressed: () => controller.toggleFavorite(section.id),
                icon: Icon(
                  favorite ? Icons.star : Icons.star_border,
                  color: favorite ? Colors.amber : Colors.white38,
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
