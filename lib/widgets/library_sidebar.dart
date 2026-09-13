import 'package:flutter/material.dart';

import '../services/library_controller.dart';
import 'library_filters.dart';
import 'section_card.dart';

class LibrarySidebar extends StatelessWidget {
  const LibrarySidebar({
    super.key,
    required this.controller,
  });

  final LibraryController controller;

  @override
  Widget build(BuildContext context) {
    final sections = controller.filtered;
    return Container(
      color: const Color(0xFF081321),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'RUTA DE APRENDIZAJE',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
          LibraryFilters(controller: controller),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${controller.completed.length} de ${controller.total} completadas',
                      style: const TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                    Text(
                      '${(controller.progress * 100).round()}%',
                      style: const TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                LinearProgressIndicator(
                  value: controller.progress,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(99),
                ),
              ],
            ),
          ),
          Expanded(
            child: sections.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No hay temas que coincidan con los filtros.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
                    itemCount: sections.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, index) {
                      final section = sections[index];
                      return SectionCard(
                        section: section,
                        controller: controller,
                        onOpen: () => controller.select(section.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
