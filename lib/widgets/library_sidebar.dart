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
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      '${(controller.progress * 100).round()}%',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
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
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
                    itemCount: sections.length,
                    itemBuilder: (context, index) {
                      final section = sections[index];
                      final startsGroup =
                          index == 0 || sections[index - 1].group != section.group;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (startsGroup)
                            _GroupHeader(
                              label: section.group,
                              completed: controller.completed.where((id) {
                                return sections.any(
                                  (candidate) =>
                                      candidate.id == id &&
                                      candidate.group == section.group,
                                );
                              }).length,
                              total: sections
                                  .where(
                                    (candidate) =>
                                        candidate.group == section.group,
                                  )
                                  .length,
                            ),
                          SectionCard(
                            section: section,
                            controller: controller,
                            onOpen: () => controller.select(section.id),
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({
    required this.label,
    required this.completed,
    required this.total,
  });

  final String label;
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 14, 4, 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
          Text(
            '$completed/$total',
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
