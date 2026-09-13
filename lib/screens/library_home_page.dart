import 'package:flutter/material.dart';

import '../models/course_section.dart';
import '../services/library_controller.dart';
import '../widgets/library_filters.dart';
import '../widgets/library_sidebar.dart';
import '../widgets/section_card.dart';
import '../widgets/section_detail.dart';

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  late final LibraryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LibraryController()..initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Biblioteca Flutter',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                Text(
                  'Ruta interactiva de Dart y Flutter',
                  style: TextStyle(fontSize: 12, color: Colors.white60),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Center(
                  child: Text(
                    '${_controller.completed.length}/${_controller.total} completadas',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 980) {
                return Row(
                  children: [
                    SizedBox(
                      width: 360,
                      child: LibrarySidebar(controller: _controller),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: SectionDetail(
                        section: _controller.selected,
                        controller: _controller,
                      ),
                    ),
                  ],
                );
              }
              return _MobileLibrary(controller: _controller);
            },
          ),
        );
      },
    );
  }
}

class _MobileLibrary extends StatelessWidget {
  const _MobileLibrary({required this.controller});

  final LibraryController controller;

  @override
  Widget build(BuildContext context) {
    final sections = controller.filtered;
    return Column(
      children: [
        LibraryFilters(controller: controller),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: controller.progress,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(controller.progress * 100).round()}%',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
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
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: sections.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, index) {
                    final section = sections[index];
                    return SectionCard(
                      section: section,
                      controller: controller,
                      onOpen: () => _openDetail(context, section),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _openDetail(BuildContext context, CourseSection section) {
    controller.select(section.id);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => AnimatedBuilder(
          animation: controller,
          builder: (context, __) {
            return Scaffold(
              appBar: AppBar(title: Text(controller.selected.title)),
              body: SectionDetail(
                section: controller.selected,
                controller: controller,
                onNavigate: (_) {},
              ),
            );
          },
        ),
      ),
    );
  }
}
