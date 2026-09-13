import 'package:flutter/material.dart';

import '../models/course_section.dart';
import '../services/library_controller.dart';
import '../widgets/library_filters.dart';
import '../widgets/library_sidebar.dart';
import '../widgets/progress_dashboard.dart';
import '../widgets/section_card.dart';
import '../widgets/section_detail_enriched.dart';

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

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
    final scheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Biblioteca Dart + Flutter',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                Text(
                  'Dart desde cero · Flutter paso a paso · Proyectos',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            actions: [
              if (MediaQuery.sizeOf(context).width >= 720)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Center(
                    child: Text(
                      '${_controller.completed.length}/${_controller.total} completadas',
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
              PopupMenuButton<ThemeMode>(
                tooltip: 'Cambiar tema',
                initialValue: widget.themeMode,
                onSelected: widget.onThemeModeChanged,
                icon: Icon(
                  widget.themeMode == ThemeMode.light
                      ? Icons.light_mode_rounded
                      : widget.themeMode == ThemeMode.dark
                          ? Icons.dark_mode_rounded
                          : Icons.brightness_auto_rounded,
                ),
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: ThemeMode.system,
                    child: Text('Tema del sistema'),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.light,
                    child: Text('Tema claro'),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Tema oscuro'),
                  ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 980) {
                return Row(
                  children: [
                    SizedBox(
                      width: 380,
                      child: LibrarySidebar(controller: _controller),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: Column(
                        children: [
                          ProgressDashboard(controller: _controller),
                          const Divider(height: 1),
                          Expanded(
                            child: SectionDetail(
                              section: _controller.selected,
                              controller: _controller,
                            ),
                          ),
                        ],
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
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        ProgressDashboard(controller: controller),
        LibraryFilters(controller: controller),
        Expanded(
          child: sections.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No hay temas que coincidan con los filtros.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    final startsGroup =
                        index == 0 || sections[index - 1].group != section.group;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (startsGroup)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 14, 4, 8),
                            child: Text(
                              section.group.toUpperCase(),
                              style: TextStyle(
                                color: scheme.onSurfaceVariant,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        SectionCard(
                          section: section,
                          controller: controller,
                          onOpen: () => _openDetail(context, section),
                        ),
                        const SizedBox(height: 10),
                      ],
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
          builder: (context, _) {
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
