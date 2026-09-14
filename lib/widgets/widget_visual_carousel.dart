import 'package:flutter/material.dart';

import '../models/course_section.dart';
import 'widget_individual_gallery.dart';

/// Carrusel compacto para recorrer las imágenes de widgets una por una.
///
/// Se usa en el panel visual de cada lección para que sea evidente que existen
/// más ejemplos: incluye flechas, contador, indicadores y gesto de swipe.
class WidgetVisualCarousel extends StatefulWidget {
  const WidgetVisualCarousel({
    super.key,
    required this.section,
  });

  final CourseSection section;

  static bool supports(CourseSection section) =>
      WidgetIndividualGallery.supports(section);

  @override
  State<WidgetVisualCarousel> createState() => _WidgetVisualCarouselState();
}

class _WidgetVisualCarouselState extends State<WidgetVisualCarousel> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void didUpdateWidget(covariant WidgetVisualCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.section.id != widget.section.id) {
      _index = 0;
      if (_controller.hasClients) {
        _controller.jumpToPage(0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = WidgetIndividualGallery.visualsFor(widget.section.id);
    if (items.isEmpty) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final accent = Color(widget.section.accentValue);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .11),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(Icons.widgets_rounded, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Imagen de cada widget',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${items.length} widgets · usa las flechas o desliza',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${_index + 1}/${items.length}',
                  style: TextStyle(
                    color: accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 245,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: items.length,
                    onPageChanged: (value) => setState(() => _index = value),
                    itemBuilder: (context, index) => _CarouselCard(
                      item: items[index],
                      accent: accent,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: _ArrowButton(
                    tooltip: 'Widget anterior',
                    icon: Icons.chevron_left_rounded,
                    enabled: _index > 0,
                    onPressed: () => _goTo(_index - 1),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: _ArrowButton(
                    tooltip: 'Widget siguiente',
                    icon: Icons.chevron_right_rounded,
                    enabled: _index < items.length - 1,
                    onPressed: () => _goTo(_index + 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < items.length; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _index ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == _index
                        ? accent
                        : scheme.outlineVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _goTo(int page) {
    final items = WidgetIndividualGallery.visualsFor(widget.section.id);
    if (page < 0 || page >= items.length) return;
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.tooltip,
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      tooltip: tooltip,
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({
    required this.item,
    required this.accent,
  });

  final WidgetVisualItem item;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Color.alphaBlend(
                accent.withValues(alpha: .055),
                scheme.surface,
              ),
              padding: const EdgeInsets.all(16),
              child: _WidgetPreview(kind: item.kind, accent: accent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 11, 14, 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 10.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WidgetPreview extends StatelessWidget {
  const _WidgetPreview({required this.kind, required this.accent});

  final WidgetVisualKind kind;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    switch (kind) {
      case WidgetVisualKind.container:
        return Center(
          child: Container(
            width: 210,
            height: 105,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: .14),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: accent, width: 2),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text('Container'),
            ),
          ),
        );
      case WidgetVisualKind.padding:
        return Center(
          child: Container(
            width: 210,
            height: 105,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: accent, width: 2),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: .18),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Text('Padding'),
            ),
          ),
        );
      case WidgetVisualKind.center:
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(width: 2, height: 120, color: accent.withValues(alpha: .3)),
            Container(width: 220, height: 2, color: accent.withValues(alpha: .3)),
            Container(
              width: 96,
              height: 62,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('Center', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      case WidgetVisualKind.row:
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 3; i++) ...[
                Container(
                  width: 56,
                  height: 74,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: .16 + (i * .08)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                if (i < 2) const SizedBox(width: 10),
              ],
            ],
          ),
        );
      case WidgetVisualKind.column:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 3; i++) ...[
                Container(
                  width: 190,
                  height: 34,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: .16 + (i * .08)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                if (i < 2) const SizedBox(height: 9),
              ],
            ],
          ),
        );
      case WidgetVisualKind.expanded:
        return Center(
          child: SizedBox(
            width: 230,
            height: 86,
            child: Row(
              children: [
                Container(
                  width: 55,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      'Expanded',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case WidgetVisualKind.scaffold:
      case WidgetVisualKind.appBar:
      case WidgetVisualKind.body:
      case WidgetVisualKind.fab:
        return _MiniPhone(kind: kind, accent: accent);
      case WidgetVisualKind.form:
      case WidgetVisualKind.textField:
      case WidgetVisualKind.dropdown:
      case WidgetVisualKind.filledButton:
      case WidgetVisualKind.outlinedButton:
        return _MiniForm(kind: kind, accent: accent);
      case WidgetVisualKind.list:
      case WidgetVisualKind.listTile:
      case WidgetVisualKind.scrollbar:
        return _MiniList(accent: accent);
      case WidgetVisualKind.grid:
        return _MiniGrid(accent: accent);
      case WidgetVisualKind.navigator:
      case WidgetVisualKind.drawer:
      case WidgetVisualKind.navigationBar:
      case WidgetVisualKind.tabBar:
        return _MiniNavigation(kind: kind, accent: accent);
      case WidgetVisualKind.snackBar:
      case WidgetVisualKind.dialog:
      case WidgetVisualKind.bottomSheet:
        return _MiniFeedback(kind: kind, accent: accent);
      case WidgetVisualKind.theme:
      case WidgetVisualKind.colorScheme:
      case WidgetVisualKind.chip:
        return _ThemePreview(accent: accent);
      case WidgetVisualKind.future:
      case WidgetVisualKind.progress:
      case WidgetVisualKind.refresh:
        return Center(
          child: SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(
              strokeWidth: 8,
              color: accent,
              backgroundColor: accent.withValues(alpha: .16),
            ),
          ),
        );
      default:
        return Center(
          child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: accent.withValues(alpha: .35)),
            ),
            child: Icon(Icons.widgets_rounded, size: 54, color: accent),
          ),
        );
    }
  }
}

class _MiniPhone extends StatelessWidget {
  const _MiniPhone({required this.kind, required this.accent});

  final WidgetVisualKind kind;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        width: 126,
        height: 164,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: scheme.onSurface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            if (kind == WidgetVisualKind.scaffold ||
                kind == WidgetVisualKind.appBar)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Mi Biblioteca',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            if (kind == WidgetVisualKind.body ||
                kind == WidgetVisualKind.scaffold)
              Positioned(
                top: 50,
                left: 12,
                right: 12,
                child: Column(
                  children: [
                    Container(height: 30, color: accent.withValues(alpha: .12)),
                    const SizedBox(height: 8),
                    Container(height: 30, color: accent.withValues(alpha: .08)),
                  ],
                ),
              ),
            if (kind == WidgetVisualKind.fab ||
                kind == WidgetVisualKind.scaffold)
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniForm extends StatelessWidget {
  const _MiniForm({required this.kind, required this.accent});

  final WidgetVisualKind kind;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              enabled: false,
              decoration: InputDecoration(
                isDense: true,
                labelText: kind == WidgetVisualKind.dropdown ? 'Categoría' : 'Título',
                suffixIcon: kind == WidgetVisualKind.dropdown
                    ? const Icon(Icons.keyboard_arrow_down_rounded)
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: null,
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: null,
                    style: FilledButton.styleFrom(disabledBackgroundColor: accent),
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniList extends StatelessWidget {
  const _MiniList({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 3; i++)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 36,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: .22),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: .34),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniGrid extends StatelessWidget {
  const _MiniGrid({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 205,
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (var i = 0; i < 4; i++)
              Container(
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: .12 + (i * .04)),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniNavigation extends StatelessWidget {
  const _MiniNavigation({required this.kind, required this.accent});
  final WidgetVisualKind kind;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 230,
        height: 135,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accent.withValues(alpha: .25)),
        ),
        child: Stack(
          children: [
            if (kind == WidgetVisualKind.drawer)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 105,
                  padding: const EdgeInsets.all(12),
                  color: accent.withValues(alpha: .10),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home_rounded),
                      SizedBox(height: 8),
                      Icon(Icons.favorite_outline_rounded),
                    ],
                  ),
                ),
              )
            else if (kind == WidgetVisualKind.tabBar)
              Align(
                alignment: Alignment.topCenter,
                child: TabBar(
                  controller: DefaultTabController.of(context),
                  tabs: const [Tab(text: 'Lista'), Tab(text: 'Grid')],
                ),
              )
            else
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.home_rounded, color: accent),
                      const Icon(Icons.search_rounded),
                      const Icon(Icons.favorite_border_rounded),
                      const Icon(Icons.person_outline_rounded),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniFeedback extends StatelessWidget {
  const _MiniFeedback({required this.kind, required this.accent});
  final WidgetVisualKind kind;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 225,
        height: 135,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accent.withValues(alpha: .25)),
        ),
        child: kind == WidgetVisualKind.snackBar
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Guardado correctamente',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
            : kind == WidgetVisualKind.bottomSheet
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 78,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: .12),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      width: 165,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('¿Eliminar libro?', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 10),
                          Text('Cancelar     Eliminar', style: TextStyle(fontSize: 9)),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}

class _ThemePreview extends StatelessWidget {
  const _ThemePreview({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          for (final opacity in [.95, .75, .55, .35])
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: opacity),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
        ],
      ),
    );
  }
}
