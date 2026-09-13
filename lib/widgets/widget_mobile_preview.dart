import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/course_section.dart';

/// Vista visual construida con widgets reales de Flutter.
///
/// Sirve para que cada lección muestre cómo se traduce el concepto a una
/// interfaz de móvil sin depender únicamente de una captura o imagen estática.
class WidgetMobilePreview extends StatelessWidget {
  const WidgetMobilePreview({
    super.key,
    required this.section,
  });

  final CourseSection section;

  static const supportedIds = <String>{
    'flutter-intro',
    'widgets-layout',
    'estado-reactividad',
    'navegacion',
    'formularios',
    'async-api',
    'persistencia',
    'arquitectura',
    'testing',
    'rendimiento',
    'accesibilidad',
    'flutter-widget-lifecycle',
    'flutter-lists-grids',
    'flutter-material3-theme',
    'flutter-animations',
    'flutter-gestures-focus',
    'flutter-feedback-overlays',
    'flutter-state-architecture',
    'flutter-offline-cache',
  };

  static bool supports(CourseSection section) => supportedIds.contains(section.id);

  @override
  Widget build(BuildContext context) {
    final accent = Color(section.accentValue);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = math.min(constraints.maxWidth, 350.0);
        return Center(
          child: SizedBox(
            width: width,
            height: width * 1.72,
            child: _PhoneFrame(
              accent: accent,
              child: _screenFor(section.id, accent),
            ),
          ),
        );
      },
    );
  }

  Widget _screenFor(String id, Color accent) {
    return switch (id) {
      'flutter-intro' => _IntroScreen(accent: accent),
      'widgets-layout' => _LayoutScreen(accent: accent),
      'estado-reactividad' => _StateScreen(accent: accent),
      'navegacion' => _NavigationScreen(accent: accent),
      'formularios' => _FormScreen(accent: accent),
      'async-api' => _ApiScreen(accent: accent),
      'persistencia' => _PersistenceScreen(accent: accent),
      'arquitectura' => _ArchitectureScreen(accent: accent),
      'testing' => _TestingScreen(accent: accent),
      'rendimiento' => _PerformanceScreen(accent: accent),
      'accesibilidad' => _AccessibilityScreen(accent: accent),
      'flutter-widget-lifecycle' => _LifecycleScreen(accent: accent),
      'flutter-lists-grids' => _ListsGridScreen(accent: accent),
      'flutter-material3-theme' => _ThemeScreen(accent: accent),
      'flutter-animations' => _AnimationScreen(accent: accent),
      'flutter-gestures-focus' => _GesturesScreen(accent: accent),
      'flutter-feedback-overlays' => _FeedbackScreen(accent: accent),
      'flutter-state-architecture' => _StateArchitectureScreen(accent: accent),
      'flutter-offline-cache' => _OfflineScreen(accent: accent),
      _ => _IntroScreen(accent: accent),
    };
  }
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.accent, required this.child});

  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final phoneTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: accent),
      scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      textTheme: ThemeData.light().textTheme.apply(
            fontFamily: 'sans-serif',
            bodyColor: const Color(0xFF0F172A),
            displayColor: const Color(0xFF0F172A),
          ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(42),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: .20),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: Theme(
            data: phoneTheme,
            child: Material(
              color: const Color(0xFFF7F9FC),
              child: Column(
                children: [
                  const _StatusBar(),
                  Expanded(child: child),
                  const _HomeIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      color: Colors.white,
      child: const Row(
        children: [
          Text('9:41', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)),
          Spacer(),
          Icon(Icons.signal_cellular_alt_rounded, size: 12),
          SizedBox(width: 4),
          Icon(Icons.wifi_rounded, size: 12),
          SizedBox(width: 4),
          Icon(Icons.battery_full_rounded, size: 13),
        ],
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      alignment: Alignment.topCenter,
      color: Colors.white,
      child: Container(
        width: 92,
        height: 4,
        margin: const EdgeInsets.only(top: 7),
        decoration: BoxDecoration(
          color: const Color(0xFF94A3B8),
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }
}

class _PhoneAppBar extends StatelessWidget {
  const _PhoneAppBar({
    required this.title,
    required this.accent,
    this.leading = Icons.menu_rounded,
    this.trailing = Icons.search_rounded,
  });

  final String title;
  final Color accent;
  final IconData leading;
  final IconData trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      color: accent,
      child: Row(
        children: [
          Icon(leading, color: Colors.white, size: 19),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Icon(trailing, color: Colors.white, size: 19),
        ],
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color? color;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 20, color: accent),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 8.5, color: Color(0xFF64748B), height: 1.25),
                ),
              ],
            ),
          ),
          trailing ?? const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}

class _IntroScreen extends StatelessWidget {
  const _IntroScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _PhoneAppBar(title: 'Mi primera app', accent: accent),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(13),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _MiniCard(title: 'Aprender', subtitle: 'Lecciones paso a paso', icon: Icons.menu_book_rounded, color: accent),
                  const SizedBox(height: 9),
                  _MiniCard(title: 'Practicar', subtitle: 'Ejemplos simples con widgets', icon: Icons.code_rounded, color: accent),
                  const SizedBox(height: 9),
                  _MiniCard(title: 'Progreso', subtitle: 'Mide cuánto has avanzado', icon: Icons.bar_chart_rounded, color: accent),
                  const SizedBox(height: 14),
                  const Text('Scaffold = estructura base', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 5),
                  const Text('AppBar arriba · body al centro · FAB para la acción principal.', style: TextStyle(fontSize: 9, color: Color(0xFF64748B), height: 1.35)),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 18,
          child: CircleAvatar(
            radius: 23,
            backgroundColor: accent,
            child: const Icon(Icons.add_rounded, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _LayoutScreen extends StatelessWidget {
  const _LayoutScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Row + Column', accent: accent, leading: Icons.arrow_back_rounded, trailing: Icons.view_quilt_rounded),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionLabel('Row · horizontal', accent),
                const SizedBox(height: 7),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: _box(),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 18, backgroundColor: accent.withValues(alpha: .16), child: Icon(Icons.person_rounded, color: accent, size: 20)),
                      const SizedBox(width: 9),
                      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Alex', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)), Text('Flutter learner', style: TextStyle(fontSize: 8.5, color: Color(0xFF64748B)))])),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(99)), child: const Text('Online', style: TextStyle(fontSize: 8, color: Color(0xFF047857), fontWeight: FontWeight.w800))),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                _SectionLabel('Column · vertical', accent),
                const SizedBox(height: 7),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: _box(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book_rounded, size: 42, color: accent),
                        const SizedBox(height: 10),
                        const Text('Sigue aprendiendo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 4),
                        const Text('Icono, título, texto y botón\napilados verticalmente.', textAlign: TextAlign.center, style: TextStyle(fontSize: 9, color: Color(0xFF64748B), height: 1.35)),
                        const SizedBox(height: 12),
                        FilledButton(onPressed: () {}, child: const Text('Continuar', style: TextStyle(fontSize: 10))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StateScreen extends StatelessWidget {
  const _StateScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Estado', accent: accent, leading: Icons.arrow_back_rounded, trailing: Icons.sync_rounded),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                const Text('La UI refleja el estado actual', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: _box(),
                  child: Column(
                    children: [
                      Text('12', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: accent)),
                      const Text('contador', style: TextStyle(fontSize: 9, color: Color(0xFF64748B))),
                      const SizedBox(height: 10),
                      FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.add_rounded, size: 16), label: const Text('Incrementar', style: TextStyle(fontSize: 9))),
                    ],
                  ),
                ),
                const SizedBox(height: 11),
                _MiniCard(
                  title: 'Curso favorito',
                  subtitle: 'El icono cambia cuando el estado cambia.',
                  icon: Icons.school_rounded,
                  color: accent,
                  trailing: Icon(Icons.favorite_rounded, color: accent, size: 20),
                ),
                const SizedBox(height: 11),
                SwitchListTile(
                  dense: true,
                  value: true,
                  onChanged: (_) {},
                  title: const Text('Notificaciones', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)),
                  subtitle: const Text('Otro ejemplo de estado', style: TextStyle(fontSize: 8)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NavigationScreen extends StatelessWidget {
  const _NavigationScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Cursos', accent: accent),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _MiniCard(title: 'Flutter básico', subtitle: 'Toca para abrir el detalle', icon: Icons.flutter_dash_rounded, color: accent),
                const SizedBox(height: 9),
                _MiniCard(title: 'Navegación', subtitle: 'Navigator.push → DetailPage', icon: Icons.alt_route_rounded, color: accent),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: _box(color: accent.withValues(alpha: .06)),
                  child: Column(
                    children: [
                      Icon(Icons.phone_android_rounded, color: accent, size: 34),
                      const SizedBox(height: 6),
                      const Text('Pantalla de detalle', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                      const Text('push() abre · pop() regresa', style: TextStyle(fontSize: 8.5, color: Color(0xFF64748B))),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        NavigationBar(height: 56, selectedIndex: 0, destinations: const [NavigationDestination(icon: Icon(Icons.home_outlined, size: 18), selectedIcon: Icon(Icons.home_rounded, size: 18), label: 'Inicio'), NavigationDestination(icon: Icon(Icons.book_outlined, size: 18), label: 'Cursos'), NavigationDestination(icon: Icon(Icons.person_outline_rounded, size: 18), label: 'Perfil')]),
      ],
    );
  }
}

class _FormScreen extends StatelessWidget {
  const _FormScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Crear cuenta', accent: accent, leading: Icons.arrow_back_rounded, trailing: Icons.help_outline_rounded),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(14),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const Text('Datos personales', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              _Field(label: 'Nombre', hint: 'Ana Torres', icon: Icons.person_outline_rounded),
              const SizedBox(height: 10),
              _Field(label: 'Correo', hint: 'ana@email.com', icon: Icons.email_outlined),
              const SizedBox(height: 10),
              _Field(label: 'Contraseña', hint: '••••••••', icon: Icons.lock_outline_rounded, error: 'Usa al menos 8 caracteres'),
              const SizedBox(height: 14),
              FilledButton(onPressed: () {}, child: const Text('Crear cuenta', style: TextStyle(fontSize: 10))),
            ],
          ),
        ),
      ],
    );
  }
}

class _ApiScreen extends StatelessWidget {
  const _ApiScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Cursos remotos', accent: accent, trailing: Icons.refresh_rounded),
        LinearProgressIndicator(minHeight: 3, color: accent, backgroundColor: accent.withValues(alpha: .10)),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _StateChip(icon: Icons.cloud_download_outlined, text: 'GET /courses · 200 OK', color: accent),
              const SizedBox(height: 10),
              _MiniCard(title: 'Flutter UI', subtitle: 'Dato recibido desde la API', icon: Icons.phone_android_rounded, color: accent),
              const SizedBox(height: 9),
              _MiniCard(title: 'Estado y datos', subtitle: 'loading → success', icon: Icons.sync_rounded, color: accent),
              const SizedBox(height: 14),
              Container(padding: const EdgeInsets.all(10), decoration: _box(color: const Color(0xFFFFFBEB)), child: const Row(children: [Icon(Icons.info_outline_rounded, size: 17, color: Color(0xFFD97706)), SizedBox(width: 8), Expanded(child: Text('La UI conoce estados, no detalles HTTP.', style: TextStyle(fontSize: 8.5, height: 1.3)))])),
            ],
          ),
        ),
      ],
    );
  }
}

class _PersistenceScreen extends StatelessWidget {
  const _PersistenceScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Preferencias', accent: accent, leading: Icons.arrow_back_rounded, trailing: Icons.save_rounded),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(10),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SwitchListTile(value: true, onChanged: (_) {}, secondary: Icon(Icons.dark_mode_outlined, color: accent), title: const Text('Tema oscuro', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)), subtitle: const Text('Guardado localmente', style: TextStyle(fontSize: 8))),
              CheckboxListTile(value: true, onChanged: (_) {}, secondary: Icon(Icons.favorite_rounded, color: accent), title: const Text('Curso favorito', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)), subtitle: const Text('Se restaura al abrir la app', style: TextStyle(fontSize: 8))),
              const SizedBox(height: 8),
              _StateChip(icon: Icons.storage_rounded, text: 'SharedPreferences · sincronizado', color: accent),
            ],
          ),
        ),
      ],
    );
  }
}

class _ArchitectureScreen extends StatelessWidget {
  const _ArchitectureScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final items = <(IconData, String, String)>[
      (Icons.widgets_outlined, 'presentation/', 'screens · widgets'),
      (Icons.memory_rounded, 'controllers/', 'estado y acciones'),
      (Icons.storage_rounded, 'repositories/', 'fuentes de datos'),
      (Icons.data_object_rounded, 'models/', 'entidades de la app'),
    ];
    return Column(
      children: [
        _PhoneAppBar(title: 'Arquitectura', accent: accent, leading: Icons.folder_open_rounded, trailing: Icons.account_tree_rounded),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return _MiniCard(title: item.$2, subtitle: item.$3, icon: item.$1, color: accent);
            },
          ),
        ),
      ],
    );
  }
}

class _TestingScreen extends StatelessWidget {
  const _TestingScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Quality checks', accent: accent, leading: Icons.fact_check_outlined, trailing: Icons.play_arrow_rounded),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _StateChip(icon: Icons.check_circle_rounded, text: 'flutter analyze · sin problemas', color: const Color(0xFF10B981)),
                const SizedBox(height: 10),
                _TestRow('course catalog', true),
                _TestRow('widget rendering', true),
                _TestRow('progress store', true),
                _TestRow('navigation flow', true),
                const Spacer(),
                Text('4 / 4 tests passed', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: accent)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PerformanceScreen extends StatelessWidget {
  const _PerformanceScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Lista eficiente', accent: accent, trailing: Icons.speed_rounded),
        Padding(padding: const EdgeInsets.fromLTRB(12, 10, 12, 0), child: _StateChip(icon: Icons.bolt_rounded, text: 'ListView.builder · render perezoso', color: accent)),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: 6,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: _MiniCard(title: 'Elemento ${index + 1}', subtitle: 'Se crea cuando entra en pantalla', icon: Icons.view_agenda_outlined, color: accent),
            ),
          ),
        ),
      ],
    );
  }
}

class _AccessibilityScreen extends StatelessWidget {
  const _AccessibilityScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Accesibilidad', accent: accent, leading: Icons.accessibility_new_rounded, trailing: Icons.visibility_rounded),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Controles claros y fáciles de tocar', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                const SizedBox(height: 12),
                FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.play_arrow_rounded), label: const Text('Comenzar lección')),
                const SizedBox(height: 10),
                OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.favorite_border_rounded), label: const Text('Agregar a favoritos')),
                const SizedBox(height: 12),
                _MiniCard(title: 'Contraste alto', subtitle: 'Texto legible sobre superficies claras.', icon: Icons.contrast_rounded, color: accent),
                const SizedBox(height: 8),
                _MiniCard(title: 'Semántica', subtitle: 'Botones con propósito comprensible.', icon: Icons.record_voice_over_rounded, color: accent),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LifecycleScreen extends StatelessWidget {
  const _LifecycleScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final steps = ['createState', 'initState', 'build', 'setState', 'dispose'];
    return Column(
      children: [
        _PhoneAppBar(title: 'Lifecycle', accent: accent, leading: Icons.refresh_rounded, trailing: Icons.info_outline_rounded),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                const Text('Vida de un StatefulWidget', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                const SizedBox(height: 12),
                ...steps.indexed.map((entry) {
                  final index = entry.$1;
                  final label = entry.$2;
                  return Expanded(
                    child: Row(
                      children: [
                        Column(children: [CircleAvatar(radius: 10, backgroundColor: accent, child: Text('${index + 1}', style: const TextStyle(fontSize: 7, color: Colors.white, fontWeight: FontWeight.w900))), if (index != steps.length - 1) Expanded(child: Container(width: 2, color: accent.withValues(alpha: .25)))]),
                        const SizedBox(width: 10),
                        Expanded(child: Align(alignment: Alignment.topLeft, child: Container(padding: const EdgeInsets.all(9), decoration: _box(), child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800))))),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ListsGridScreen extends StatelessWidget {
  const _ListsGridScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'ListView + GridView', accent: accent),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SegmentedButton<int>(segments: const [ButtonSegment(value: 0, label: Text('Lista', style: TextStyle(fontSize: 8))), ButtonSegment(value: 1, label: Text('Grid', style: TextStyle(fontSize: 8)))], selected: const {0}, onSelectionChanged: (_) {}),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _MiniCard(title: 'Dart', subtitle: 'Elemento de ListView', icon: Icons.code_rounded, color: accent),
                const SizedBox(height: 7),
                _MiniCard(title: 'Flutter', subtitle: 'Otro elemento perezoso', icon: Icons.flutter_dash_rounded, color: accent),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                    childAspectRatio: 1.5,
                    children: [
                      _GridTile(icon: Icons.palette_outlined, label: 'UI', color: accent),
                      _GridTile(icon: Icons.storage_rounded, label: 'Datos', color: accent),
                      _GridTile(icon: Icons.route_rounded, label: 'Rutas', color: accent),
                      _GridTile(icon: Icons.animation_rounded, label: 'Animación', color: accent),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ThemeScreen extends StatelessWidget {
  const _ThemeScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Material 3', accent: accent, leading: Icons.palette_outlined, trailing: Icons.dark_mode_outlined),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('ColorScheme', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                const SizedBox(height: 9),
                Row(children: [for (final opacity in [.25, .45, .7, 1.0]) Expanded(child: Container(height: 42, margin: const EdgeInsets.symmetric(horizontal: 3), decoration: BoxDecoration(color: accent.withValues(alpha: opacity), borderRadius: BorderRadius.circular(10))))]),
                const SizedBox(height: 14),
                _MiniCard(title: 'CardTheme', subtitle: 'Misma superficie en toda la app', icon: Icons.style_outlined, color: accent),
                const SizedBox(height: 10),
                FilledButton(onPressed: () {}, child: const Text('FilledButton temático', style: TextStyle(fontSize: 9))),
                const SizedBox(height: 8),
                OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton', style: TextStyle(fontSize: 9))),
                const Spacer(),
                _StateChip(icon: Icons.auto_awesome_rounded, text: 'Un tema · muchos componentes', color: accent),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimationScreen extends StatelessWidget {
  const _AnimationScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Animaciones', accent: accent, leading: Icons.animation_rounded, trailing: Icons.play_arrow_rounded),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: .4, end: 1),
                  duration: const Duration(milliseconds: 900),
                  builder: (context, value, child) => Transform.scale(scale: value, child: Opacity(opacity: value, child: child)),
                  child: Container(width: 96, height: 96, decoration: BoxDecoration(gradient: LinearGradient(colors: [accent, accent.withValues(alpha: .45)]), borderRadius: BorderRadius.circular(28)), child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 42)),
                ),
                const SizedBox(height: 15),
                const Text('AnimatedContainer', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                const Text('Cambios de tamaño, color y forma.', style: TextStyle(fontSize: 8.5, color: Color(0xFF64748B))),
                const SizedBox(height: 16),
                LinearProgressIndicator(value: .72, minHeight: 7, borderRadius: BorderRadius.circular(99), color: accent),
                const SizedBox(height: 8),
                const Text('Tween: 72%', style: TextStyle(fontSize: 8.5)),
                const Spacer(),
                _StateChip(icon: Icons.swap_horiz_rounded, text: 'AnimatedSwitcher · estado A → B', color: accent),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GesturesScreen extends StatelessWidget {
  const _GesturesScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Interacción', accent: accent, leading: Icons.touch_app_rounded, trailing: Icons.keyboard_alt_outlined),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _InteractionTile(icon: Icons.touch_app_rounded, title: 'Tap', subtitle: 'InkWell · feedback Material', color: accent),
                const SizedBox(height: 8),
                _InteractionTile(icon: Icons.swipe_rounded, title: 'Swipe', subtitle: 'GestureDetector · gesto específico', color: accent),
                const SizedBox(height: 8),
                _InteractionTile(icon: Icons.keyboard_return_rounded, title: 'Enter', subtitle: 'Focus + keyboard action', color: accent),
                const SizedBox(height: 12),
                Focus(
                  child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(border: Border.all(color: accent, width: 2), borderRadius: BorderRadius.circular(14)), child: Row(children: [Icon(Icons.adjust_rounded, color: accent), const SizedBox(width: 8), const Expanded(child: Text('Elemento con foco visible', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800)))])),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FeedbackScreen extends StatelessWidget {
  const _FeedbackScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Feedback', accent: accent, leading: Icons.notifications_active_outlined, trailing: Icons.more_vert_rounded),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  children: [
                    _MiniCard(title: 'Libro guardado', subtitle: 'Acción completada correctamente', icon: Icons.menu_book_rounded, color: accent),
                    const SizedBox(height: 12),
                    Container(padding: const EdgeInsets.all(12), decoration: _box(), child: Column(children: [const Text('¿Eliminar elemento?', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)), const SizedBox(height: 5), const Text('Un diálogo bloquea cuando la decisión es importante.', textAlign: TextAlign.center, style: TextStyle(fontSize: 8.5, color: Color(0xFF64748B))), const SizedBox(height: 9), Row(mainAxisAlignment: MainAxisAlignment.end, children: [TextButton(onPressed: () {}, child: const Text('Cancelar', style: TextStyle(fontSize: 8))), const SizedBox(width: 5), FilledButton(onPressed: () {}, child: const Text('Eliminar', style: TextStyle(fontSize: 8)))])])),
                  ],
                ),
              ),
              Positioned(left: 12, right: 12, bottom: 12, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9), decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(11)), child: const Row(children: [Icon(Icons.check_circle_rounded, color: Color(0xFF34D399), size: 16), SizedBox(width: 8), Text('Cambios guardados', style: TextStyle(color: Colors.white, fontSize: 8.5)), Spacer(), Text('DESHACER', style: TextStyle(color: Color(0xFF93C5FD), fontSize: 8, fontWeight: FontWeight.w900))]))),
            ],
          ),
        ),
      ],
    );
  }
}

class _StateArchitectureScreen extends StatelessWidget {
  const _StateArchitectureScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Feature state', accent: accent, leading: Icons.account_tree_rounded, trailing: Icons.refresh_rounded),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _LayerTile('UI', 'renderiza estados', Icons.phone_android_rounded, accent),
                _Arrow(accent),
                _LayerTile('Controller', 'loading · data · error', Icons.memory_rounded, accent),
                _Arrow(accent),
                _LayerTile('Repository', 'decide fuente de datos', Icons.storage_rounded, accent),
                _Arrow(accent),
                _LayerTile('Data source', 'API / local', Icons.cloud_sync_outlined, accent),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OfflineScreen extends StatelessWidget {
  const _OfflineScreen({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhoneAppBar(title: 'Offline first', accent: accent, leading: Icons.cloud_off_outlined, trailing: Icons.sync_rounded),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _StateChip(icon: Icons.offline_pin_rounded, text: 'Disponible sin conexión', color: const Color(0xFF10B981)),
                const SizedBox(height: 12),
                _MiniCard(title: 'Curso guardado', subtitle: 'Se carga desde la caché local', icon: Icons.download_done_rounded, color: accent),
                const SizedBox(height: 9),
                _MiniCard(title: 'Cambios pendientes', subtitle: '2 elementos por sincronizar', icon: Icons.pending_actions_rounded, color: accent),
                const Spacer(),
                Container(padding: const EdgeInsets.all(12), decoration: _box(color: accent.withValues(alpha: .06)), child: Column(children: [Icon(Icons.cloud_sync_rounded, color: accent, size: 36), const SizedBox(height: 5), const Text('local → red → caché actualizada', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800)), const SizedBox(height: 3), const Text('Si falla la red, conserva datos útiles.', style: TextStyle(fontSize: 8, color: Color(0xFF64748B))) ])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, this.color);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Align(alignment: Alignment.centerLeft, child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: color)));
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.hint, required this.icon, this.error});
  final String label;
  final String hint;
  final IconData icon;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9), decoration: BoxDecoration(color: Colors.white, border: Border.all(color: error == null ? const Color(0xFFCBD5E1) : const Color(0xFFEF4444)), borderRadius: BorderRadius.circular(11)), child: Row(children: [Icon(icon, size: 16, color: const Color(0xFF64748B)), const SizedBox(width: 8), Text(hint, style: const TextStyle(fontSize: 9, color: Color(0xFF94A3B8)))])),
      if (error != null) ...[const SizedBox(height: 3), Text(error!, style: const TextStyle(fontSize: 7.5, color: Color(0xFFEF4444)))],
    ]);
  }
}

class _StateChip extends StatelessWidget {
  const _StateChip({required this.icon, required this.text, required this.color});
  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), decoration: BoxDecoration(color: color.withValues(alpha: .10), borderRadius: BorderRadius.circular(99), border: Border.all(color: color.withValues(alpha: .24))), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: color, size: 15), const SizedBox(width: 6), Flexible(child: Text(text, style: TextStyle(fontSize: 8.5, color: color, fontWeight: FontWeight.w800)))]));
}

class _TestRow extends StatelessWidget {
  const _TestRow(this.label, this.ok);
  final String label;
  final bool ok;

  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [Icon(ok ? Icons.check_circle_rounded : Icons.cancel_rounded, color: ok ? const Color(0xFF10B981) : const Color(0xFFEF4444), size: 18), const SizedBox(width: 8), Expanded(child: Text(label, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700))), Text(ok ? 'PASS' : 'FAIL', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: ok ? const Color(0xFF10B981) : const Color(0xFFEF4444)))]));
}

class _GridTile extends StatelessWidget {
  const _GridTile({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(decoration: _box(color: color.withValues(alpha: .08)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: color, size: 22), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800))]));
}

class _InteractionTile extends StatelessWidget {
  const _InteractionTile({required this.icon, required this.title, required this.subtitle, required this.color});
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) => InkWell(onTap: () {}, borderRadius: BorderRadius.circular(14), child: Container(padding: const EdgeInsets.all(12), decoration: _box(), child: Row(children: [Icon(icon, color: color, size: 24), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)), Text(subtitle, style: const TextStyle(fontSize: 8, color: Color(0xFF64748B))) ])), const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF94A3B8))])));
}

class _LayerTile extends StatelessWidget {
  const _LayerTile(this.title, this.subtitle, this.icon, this.color);
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(child: Container(width: double.infinity, padding: const EdgeInsets.all(10), decoration: _box(color: color.withValues(alpha: .07)), child: Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 19)), const SizedBox(width: 9), Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900)), Text(subtitle, style: const TextStyle(fontSize: 7.8, color: Color(0xFF64748B))) ]))])));
}

class _Arrow extends StatelessWidget {
  const _Arrow(this.color);
  final Color color;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 3), child: Icon(Icons.arrow_downward_rounded, color: color, size: 15));
}

BoxDecoration _box({Color? color}) => BoxDecoration(color: color ?? Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE2E8F0)));
