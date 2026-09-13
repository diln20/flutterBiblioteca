import 'package:flutter/material.dart';

import '../services/library_controller.dart';
import 'filter_label.dart';

class LibraryFilters extends StatelessWidget {
  const LibraryFilters({
    super.key,
    required this.controller,
  });

  final LibraryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            onChanged: controller.setQuery,
            decoration: InputDecoration(
              hintText: 'Buscar tema, categoria o concepto',
              prefixIcon: const Icon(Icons.search),
              helperText: '${controller.filtered.length} resultados visibles',
            ),
          ),
          const SizedBox(height: 10),
          const FilterLabel(text: 'Categoria'),
          const SizedBox(height: 6),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.groups.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final group = controller.groups[index];
                return ChoiceChip(
                  label: Text(group),
                  selected: controller.group == group,
                  onSelected: (_) => controller.setGroup(group),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const FilterLabel(text: 'Nivel'),
          const SizedBox(height: 6),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.levels.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final itemLevel = controller.levels[index];
                return ChoiceChip(
                  label: Text(itemLevel),
                  selected: controller.level == itemLevel,
                  onSelected: (_) => controller.setLevel(itemLevel),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FilterChip(
              avatar: const Icon(Icons.star_outline, size: 18),
              label: const Text('Solo favoritos'),
              selected: controller.favoritesOnly,
              onSelected: (_) => controller.toggleFavoritesOnly(),
            ),
          ),
        ],
      ),
    );
  }
}
