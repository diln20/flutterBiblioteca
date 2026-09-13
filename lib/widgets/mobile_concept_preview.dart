import 'package:flutter/material.dart';

import '../models/course_section.dart';

class MobileConceptPreview extends StatelessWidget {
  const MobileConceptPreview({super.key, required this.section});

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

  static bool supports(String id) => supportedIds.contains(id);

  @override
  Widget build(BuildContext context) {
    final accent = Color(section.accentValue);
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.alphaBlend(accent.withValues(alpha: .08), scheme.surface),
            scheme.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withValues(alpha: .22)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 760;
          final phone = _PhoneFrame(
            accent: accent,
            title: _previewTitle(section.id),
            child: _screenFor(section.id, accent),
          );
          final explanation = _Explanation(
            accent: accent,
            title: _previewTitle(section.id),
            points: _previewPoints(section.id),
          );

          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: explanation),
                const SizedBox(width: 28),
                SizedBox(width: 320, child: phone),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              explanation,
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: SizedBox(width: 310, child: phone),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Explanation extends StatelessWidget {
  const _Explanation({
    required this.accent,
    required this.title,
    required this.points,
  });

  final Color accent;
  final String title;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            'VISTA MÓVIL',
            style: TextStyle(
              color: accent,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Esta interfaz está construida con widgets de Flutter para que puedas relacionar el concepto con una pantalla real.',
          style: TextStyle(color: scheme.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 16),
        for (final point in points)
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: .12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_rounded, size: 14, color: accent),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(point, style: const TextStyle(height: 1.4)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({
    required this.accent,
    required this.title,
    required this.child,
  });

  final Color accent;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: .57,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(34),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .18),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(27),
          child: ColoredBox(
            color: scheme.surface,
            child: Column(
              children: [
                Container(
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: const Row(
                    children: [
                      Text('9:41', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800)),
                      Spacer(),
                      Icon(Icons.signal_cellular_alt_rounded, size: 11),
                      SizedBox(width: 4),
                      Icon(Icons.wifi_rounded, size: 11),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full_rounded, size: 12),
                    ],
                  ),
                ),
                Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accent, Color.lerp(accent, Colors.blue, .45)!],
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const Icon(Icons.more_vert_rounded, size: 17, color: Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: child,
                  ),
                ),
                Container(
                  width: 80,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: scheme.onSurface.withValues(alpha: .18),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _screenFor(String id, Color accent) {
  switch (id) {
    case 'flutter-intro':
      return _ScaffoldPreview(accent: accent);
    case 'widgets-layout':
      return _LayoutPreview(accent: accent);
    case 'estado-reactividad':
      return _StatePreview(accent: accent);
    case 'navegacion':
      return _NavigationPreview(accent: accent);
    case 'formularios':
      return _FormPreview(accent: accent);
    case 'async-api':
      return _ApiPreview(accent: accent);
    case 'persistencia':
      return _PersistencePreview(accent: accent);
    case 'arquitectura':
      return _ArchitecturePreview(accent: accent);
    case 'testing':
      return _TestingPreview(accent: accent);
    case 'rendimiento':
      return _PerformancePreview(accent: accent);
    case 'accesibilidad':
      return _AccessibilityPreview(accent: accent);
    case 'flutter-widget-lifecycle':
      return _LifecyclePreview(accent: accent);
    case 'flutter-lists-grids':
      return _ListsGridPreview(accent: accent);
    case 'flutter-material3-theme':
      return _ThemePreview(accent: accent);
    case 'flutter-animations':
      return _AnimationPreview(accent: accent);
    case 'flutter-gestures-focus':
      return _GesturesPreview(accent: accent);
    case 'flutter-feedback-overlays':
      return _FeedbackPreview(accent: accent);
    case 'flutter-state-architecture':
      return _StateArchitecturePreview(accent: accent);
    case 'flutter-offline-cache':
      return _OfflinePreview(accent: accent);
    default:
      return const SizedBox.shrink();
  }
}

String _previewTitle(String id) => switch (id) {
      'flutter-intro' => 'Scaffold y AppBar',
      'widgets-layout' => 'Row y Column',
      'estado-reactividad' => 'Estado reactivo',
      'navegacion' => 'Navegación',
      'formularios' => 'Formulario',
      'async-api' => 'Datos remotos',
      'persistencia' => 'Datos guardados',
      'arquitectura' => 'Arquitectura',
      'testing' => 'Testing',
      'rendimiento' => 'Rendimiento',
      'accesibilidad' => 'Accesibilidad',
      'flutter-widget-lifecycle' => 'Ciclo de vida',
      'flutter-lists-grids' => 'Listas y grids',
      'flutter-material3-theme' => 'Material 3',
      'flutter-animations' => 'Animaciones',
      'flutter-gestures-focus' => 'Gestos y foco',
      'flutter-feedback-overlays' => 'Feedback',
      'flutter-state-architecture' => 'Estado por feature',
      'flutter-offline-cache' => 'Offline y caché',
      _ => 'Flutter',
    };

List<String> _previewPoints(String id) => switch (id) {
      'flutter-intro' => ['AppBar arriba, body al centro y FAB como acción principal.', 'Scaffold organiza la estructura visual de toda la pantalla.'],
      'widgets-layout' => ['Row coloca elementos lado a lado.', 'Column apila contenido verticalmente dentro de la pantalla.'],
      'estado-reactividad' => ['El número y el favorito representan UI que cambia con el estado.', 'Solo las zonas dependientes del estado deberían reconstruirse.'],
      'navegacion' => ['Una lista abre una pantalla de detalle.', 'Navigator conecta pantallas y permite volver al punto anterior.'],
      'formularios' => ['TextFormField recoge datos del usuario.', 'El estado de error aparece junto al campo que debe corregirse.'],
      'async-api' => ['La UI distingue carga, contenido y error.', 'La pantalla no necesita conocer cómo se hizo la petición HTTP.'],
      'persistencia' => ['Preferencias y progreso permanecen después de cerrar la app.', 'La UI refleja inmediatamente los valores restaurados.'],
      'arquitectura' => ['La pantalla depende de capas pequeñas y separadas.', 'Modelos, datos, servicios y UI tienen responsabilidades distintas.'],
      'testing' => ['Los checks convierten comportamientos en contratos verificables.', 'Una suite saludable muestra claramente éxito y fallo.'],
      'rendimiento' => ['Las listas grandes crean solo lo visible.', 'Indicadores simples ayudan a explicar menos trabajo por frame.'],
      'accesibilidad' => ['Objetivos táctiles grandes y texto legible mejoran la interacción.', 'Foco, contraste y etiquetas ayudan a teclado y lector de pantalla.'],
      'flutter-widget-lifecycle' => ['initState prepara recursos, build pinta y dispose libera.', 'mounted evita usar context cuando el widget ya salió del árbol.'],
      'flutter-lists-grids' => ['ListView funciona para contenido lineal.', 'GridView aprovecha mejor el ancho cuando hay tarjetas repetidas.'],
      'flutter-material3-theme' => ['El mismo ColorScheme alimenta botones, cards, chips y superficies.', 'El tema cambia el sistema visual sin reescribir cada pantalla.'],
      'flutter-animations' => ['El movimiento explica cambios entre estados.', 'Animaciones cortas ayudan a mantener continuidad visual.'],
      'flutter-gestures-focus' => ['La misma acción puede funcionar con toque, mouse y teclado.', 'El foco visible muestra qué control recibirá la próxima acción.'],
      'flutter-feedback-overlays' => ['SnackBar informa sin bloquear.', 'Dialog y BottomSheet se reservan para decisiones o acciones contextuales.'],
      'flutter-state-architecture' => ['UI, controller, repository y datos forman un flujo claro.', 'Cada capa conoce solo lo necesario para hacer su trabajo.'],
      'flutter-offline-cache' => ['La app puede mostrar caché local antes de sincronizar.', 'La UI diferencia datos actuales, antiguos y sincronización pendiente.'],
      _ => const <String>[],
    };

class _ScaffoldPreview extends StatelessWidget {
  const _ScaffoldPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PreviewLabel(text: 'BODY', color: accent),
              const SizedBox(height: 8),
              for (final item in const [('Aprender', Icons.menu_book_rounded), ('Practicar', Icons.code_rounded), ('Progreso', Icons.bar_chart_rounded)])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _MiniTile(icon: item.$2, title: item.$1),
                ),
            ],
          ),
          Positioned(
            right: 4,
            bottom: 4,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: accent,
              child: const Icon(Icons.add_rounded, color: Colors.white),
            ),
          ),
        ],
      );
}

class _LayoutPreview extends StatelessWidget {
  const _LayoutPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          _PreviewLabel(text: 'ROW', color: accent),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: _softBox(context, accent),
            child: const Row(
              children: [
                CircleAvatar(radius: 18, child: Icon(Icons.person_rounded, size: 18)),
                SizedBox(width: 8),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Alex', style: TextStyle(fontWeight: FontWeight.w800)), Text('Flutter learner', style: TextStyle(fontSize: 9))])),
                _StatusChip(label: 'Online'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _PreviewLabel(text: 'COLUMN', color: accent),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: _softBox(context, accent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_rounded, size: 32, color: accent),
                  const SizedBox(height: 8),
                  const Text('Sigue aprendiendo', style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  const Text('Widgets apilados verticalmente', textAlign: TextAlign.center, style: TextStyle(fontSize: 9)),
                  const SizedBox(height: 10),
                  FilledButton(onPressed: () {}, child: const Text('Continuar')),
                ],
              ),
            ),
          ),
        ],
      );
}

class _StatePreview extends StatelessWidget {
  const _StatePreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          _PreviewLabel(text: 'ESTADO', color: accent),
          const SizedBox(height: 12),
          Text('12', style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: accent)),
          const Text('puntos actuales', style: TextStyle(fontSize: 10)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.add_rounded), label: const Text('Sumar')),
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_rounded, color: accent)),
            ],
          ),
          const SizedBox(height: 14),
          _MiniTile(icon: Icons.sync_rounded, title: 'UI actualizada', subtitle: 'notifyListeners / setState'),
        ],
      );
}

class _NavigationPreview extends StatelessWidget {
  const _NavigationPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreviewLabel(text: 'PANTALLA 1', color: accent),
          const SizedBox(height: 10),
          _MiniTile(icon: Icons.book_rounded, title: 'Curso Flutter', subtitle: 'Toca para abrir'),
          const SizedBox(height: 10),
          Icon(Icons.arrow_downward_rounded, color: accent),
          const SizedBox(height: 10),
          _PreviewLabel(text: 'DETALLE', color: accent),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: _softBox(context, accent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_android_rounded, color: accent, size: 34),
                  const SizedBox(height: 8),
                  const Text('Detalle del curso', style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.arrow_back_rounded), label: const Text('Volver')),
                ],
              ),
            ),
          ),
        ],
      );
}

class _FormPreview extends StatelessWidget {
  const _FormPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.person_add_alt_1_rounded, size: 32, color: accent),
          const SizedBox(height: 8),
          const Text('Crear cuenta', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          const _FakeField(label: 'Nombre completo', value: 'Ana Torres', icon: Icons.person_outline_rounded),
          const SizedBox(height: 8),
          const _FakeField(label: 'Email', value: 'ana@email.com', icon: Icons.mail_outline_rounded),
          const SizedBox(height: 8),
          const _FakeField(label: 'Contraseña', value: '••••••••', icon: Icons.lock_outline_rounded, error: 'Mínimo 8 caracteres'),
          const Spacer(),
          FilledButton(onPressed: () {}, child: const Text('Crear cuenta')),
        ],
      );
}

class _ApiPreview extends StatelessWidget {
  const _ApiPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreviewLabel(text: 'API', color: accent),
          const SizedBox(height: 10),
          LinearProgressIndicator(color: accent),
          const SizedBox(height: 12),
          _MiniTile(icon: Icons.cloud_download_outlined, title: 'Cargando cursos...', subtitle: 'Future + repository'),
          const SizedBox(height: 10),
          _MiniTile(icon: Icons.check_circle_outline_rounded, title: '24 cursos recibidos', subtitle: 'Estado de éxito'),
          const SizedBox(height: 10),
          _MiniTile(icon: Icons.wifi_off_rounded, title: 'Sin conexión', subtitle: 'Estado de error'),
        ],
      );
}

class _PersistencePreview extends StatelessWidget {
  const _PersistencePreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          _PreviewLabel(text: 'PREFERENCIAS', color: accent),
          const SizedBox(height: 10),
          _MiniSwitch(title: 'Tema oscuro', value: true, accent: accent),
          const SizedBox(height: 8),
          _MiniSwitch(title: 'Recordar progreso', value: true, accent: accent),
          const SizedBox(height: 12),
          _MiniTile(icon: Icons.star_rounded, title: '8 favoritos', subtitle: 'Guardados localmente'),
          const SizedBox(height: 8),
          _MiniTile(icon: Icons.check_circle_rounded, title: '14 completadas', subtitle: 'Restauradas al iniciar'),
        ],
      );
}

class _ArchitecturePreview extends StatelessWidget {
  const _ArchitecturePreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          for (final item in const [('UI', Icons.phone_android_rounded), ('Controller', Icons.tune_rounded), ('Repository', Icons.inventory_2_outlined), ('Data', Icons.storage_rounded)]) ...[
            Expanded(child: _LayerBox(label: item.$1, icon: item.$2, accent: accent)),
            if (item.$1 != 'Data') Icon(Icons.arrow_downward_rounded, size: 16, color: accent),
          ],
        ],
      );
}

class _TestingPreview extends StatelessWidget {
  const _TestingPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreviewLabel(text: 'TEST SUITE', color: accent),
          const SizedBox(height: 12),
          for (final item in const [('IDs únicos', true), ('Contenido completo', true), ('Navegación', true), ('Formulario', false)])
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _TestRow(label: item.$1, ok: item.$2),
            ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: _softBox(context, accent),
            child: const Text('3 passed · 1 failed', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      );
}

class _PerformancePreview extends StatelessWidget {
  const _PerformancePreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(children: [Expanded(child: _Metric(label: 'FPS', value: '60', accent: accent)), const SizedBox(width: 8), Expanded(child: _Metric(label: 'Widgets', value: '12', accent: accent))]),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: _MiniTile(icon: Icons.flash_on_rounded, title: 'Elemento ${index + 1}', subtitle: 'Creado bajo demanda'),
              ),
            ),
          ),
        ],
      );
}

class _AccessibilityPreview extends StatelessWidget {
  const _AccessibilityPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreviewLabel(text: 'ACCESIBLE', color: accent),
          const SizedBox(height: 12),
          const Text('Texto legible y controles claros', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(border: Border.all(color: accent, width: 3), borderRadius: BorderRadius.circular(14)),
            child: FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.star_border_rounded), label: const Text('Agregar a favoritos')),
          ),
          const SizedBox(height: 12),
          const _MiniTile(icon: Icons.keyboard_rounded, title: 'Foco visible', subtitle: 'Tab + Enter'),
          const SizedBox(height: 8),
          const _MiniTile(icon: Icons.record_voice_over_rounded, title: 'Semantics', subtitle: 'Etiqueta descriptiva'),
        ],
      );
}

class _LifecyclePreview extends StatelessWidget {
  const _LifecyclePreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          for (final item in const [('1', 'initState', Icons.play_arrow_rounded), ('2', 'build', Icons.widgets_rounded), ('3', 'setState', Icons.refresh_rounded), ('4', 'dispose', Icons.delete_outline_rounded)])
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(radius: 15, backgroundColor: accent.withValues(alpha: .15), child: Text(item.$1, style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.w900))),
                  const SizedBox(width: 8),
                  Expanded(child: _MiniTile(icon: item.$3, title: item.$2)),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            decoration: BoxDecoration(color: accent.withValues(alpha: .1), borderRadius: BorderRadius.circular(99)),
            child: Text('mounted = true', style: TextStyle(color: accent, fontSize: 9, fontWeight: FontWeight.w900)),
          ),
        ],
      );
}

class _ListsGridPreview extends StatelessWidget {
  const _ListsGridPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(children: [Expanded(child: _PreviewLabel(text: 'LISTVIEW', color: accent)), const SizedBox(width: 6), Expanded(child: _PreviewLabel(text: 'GRIDVIEW', color: accent))]),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: List.generate(4, (i) => Expanded(child: Padding(padding: const EdgeInsets.only(bottom: 6), child: _MiniTile(icon: Icons.book_outlined, title: 'Curso ${i + 1}')))),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    children: List.generate(6, (i) => Container(decoration: _softBox(context, accent), child: Icon(Icons.grid_view_rounded, size: 18, color: accent))),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class _ThemePreview extends StatelessWidget {
  const _ThemePreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreviewLabel(text: 'COLOR SCHEME', color: accent),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final color in [accent, Colors.indigo, Colors.teal, Colors.orange])
                Expanded(child: Container(height: 34, margin: const EdgeInsets.symmetric(horizontal: 3), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)))),
            ],
          ),
          const SizedBox(height: 12),
          Container(padding: const EdgeInsets.all(12), decoration: _softBox(context, accent), child: const Text('Card con ThemeData', style: TextStyle(fontWeight: FontWeight.w900))),
          const SizedBox(height: 10),
          FilledButton(onPressed: () {}, child: const Text('FilledButton')),
          const SizedBox(height: 8),
          Wrap(spacing: 6, children: const [Chip(label: Text('Material 3')), Chip(label: Text('Dark mode'))]),
        ],
      );
}

class _AnimationPreview extends StatelessWidget {
  const _AnimationPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          _PreviewLabel(text: 'TRANSICIÓN', color: accent),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 64, height: 64, decoration: BoxDecoration(color: accent.withValues(alpha: .18), borderRadius: BorderRadius.circular(14)), child: Icon(Icons.circle_outlined, color: accent)),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Icon(Icons.arrow_forward_rounded, color: accent)),
              Container(width: 86, height: 86, decoration: BoxDecoration(color: accent.withValues(alpha: .28), borderRadius: BorderRadius.circular(26)), child: Icon(Icons.check_rounded, color: accent, size: 34)),
            ],
          ),
          const Spacer(),
          const Text('AnimatedContainer + AnimatedSwitcher', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)),
        ],
      );
}

class _GesturesPreview extends StatelessWidget {
  const _GesturesPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreviewLabel(text: 'INTERACCIÓN', color: accent),
          const SizedBox(height: 12),
          _GestureCard(icon: Icons.touch_app_rounded, title: 'Tap', subtitle: 'InkWell', accent: accent),
          const SizedBox(height: 8),
          _GestureCard(icon: Icons.swipe_rounded, title: 'Swipe', subtitle: 'GestureDetector', accent: accent),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(border: Border.all(color: accent, width: 3), borderRadius: BorderRadius.circular(14)),
            child: _GestureCard(icon: Icons.keyboard_return_rounded, title: 'Enter', subtitle: 'Focus + teclado', accent: accent),
          ),
        ],
      );
}

class _FeedbackPreview extends StatelessWidget {
  const _FeedbackPreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Column(
            children: [
              _MiniTile(icon: Icons.delete_outline_rounded, title: 'Eliminar libro', subtitle: 'Acción sensible'),
              const SizedBox(height: 12),
              Expanded(child: Container(width: double.infinity, decoration: _softBox(context, accent), alignment: Alignment.center, child: const Text('Contenido de la pantalla'))),
            ],
          ),
          Positioned(
            left: 8,
            right: 8,
            top: 74,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: accent), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .12), blurRadius: 12)]),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('¿Eliminar libro?', style: TextStyle(fontWeight: FontWeight.w900)), SizedBox(height: 4), Text('Esta acción no se puede deshacer.', style: TextStyle(fontSize: 9))]),
            ),
          ),
          Positioned(left: 8, right: 8, bottom: 8, child: Container(padding: const EdgeInsets.all(9), decoration: BoxDecoration(color: const Color(0xFF111827), borderRadius: BorderRadius.circular(10)), child: const Text('Guardado correctamente', style: TextStyle(color: Colors.white, fontSize: 9)))),
        ],
      );
}

class _StateArchitecturePreview extends StatelessWidget {
  const _StateArchitecturePreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          _LayerBox(label: 'UI', icon: Icons.phone_android_rounded, accent: accent),
          Icon(Icons.arrow_downward_rounded, size: 15, color: accent),
          _LayerBox(label: 'Controller', icon: Icons.tune_rounded, accent: accent),
          Icon(Icons.arrow_downward_rounded, size: 15, color: accent),
          _LayerBox(label: 'Repository', icon: Icons.account_tree_outlined, accent: accent),
          Icon(Icons.arrow_downward_rounded, size: 15, color: accent),
          Row(children: [Expanded(child: _LayerBox(label: 'Local', icon: Icons.storage_rounded, accent: accent)), const SizedBox(width: 6), Expanded(child: _LayerBox(label: 'API', icon: Icons.cloud_outlined, accent: accent))]),
        ],
      );
}

class _OfflinePreview extends StatelessWidget {
  const _OfflinePreview({required this.accent});
  final Color accent;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(children: [Expanded(child: _LayerBox(label: 'Caché local', icon: Icons.phone_android_rounded, accent: accent)), Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Icon(Icons.sync_alt_rounded, color: accent)), Expanded(child: _LayerBox(label: 'Cloud', icon: Icons.cloud_rounded, accent: accent))]),
          const SizedBox(height: 12),
          _MiniTile(icon: Icons.history_rounded, title: 'Datos disponibles', subtitle: 'Última sincronización: hace 4 min'),
          const SizedBox(height: 8),
          _MiniTile(icon: Icons.sync_rounded, title: 'Sincronizando...', subtitle: 'Actualizando en segundo plano'),
          const Spacer(),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7), decoration: BoxDecoration(color: accent.withValues(alpha: .12), borderRadius: BorderRadius.circular(99)), child: Text('La app sigue funcionando offline', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: accent))),
        ],
      );
}

class _MiniTile extends StatelessWidget {
  const _MiniTile({required this.icon, required this.title, this.subtitle});
  final IconData icon;
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(color: scheme.surfaceContainerHighest.withValues(alpha: .5), borderRadius: BorderRadius.circular(12), border: Border.all(color: scheme.outlineVariant)),
      child: Row(
        children: [
          Icon(icon, size: 18, color: scheme.primary),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)), if (subtitle != null) Text(subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 8, color: scheme.onSurfaceVariant))])),
          const Icon(Icons.chevron_right_rounded, size: 16),
        ],
      ),
    );
  }
}

class _PreviewLabel extends StatelessWidget {
  const _PreviewLabel({required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(99)),
        child: Text(text, style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: .7)),
      );
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF10B981).withValues(alpha: .12), borderRadius: BorderRadius.circular(99)), child: const Text('Online', style: TextStyle(color: Color(0xFF059669), fontSize: 8, fontWeight: FontWeight.w900)));
}

class _FakeField extends StatelessWidget {
  const _FakeField({required this.label, required this.value, required this.icon, this.error});
  final String label;
  final String value;
  final IconData icon;
  final String? error;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900)), const SizedBox(height: 4), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9), decoration: BoxDecoration(border: Border.all(color: error == null ? scheme.outlineVariant : Colors.redAccent), borderRadius: BorderRadius.circular(9)), child: Row(children: [Icon(icon, size: 14, color: scheme.onSurfaceVariant), const SizedBox(width: 6), Expanded(child: Text(value, style: TextStyle(fontSize: 9, color: scheme.onSurfaceVariant)))])), if (error != null) Padding(padding: const EdgeInsets.only(top: 3), child: Text(error!, style: const TextStyle(fontSize: 7, color: Colors.redAccent))) ]);
  }
}

class _MiniSwitch extends StatelessWidget {
  const _MiniSwitch({required this.title, required this.value, required this.accent});
  final String title;
  final bool value;
  final Color accent;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), decoration: _softBox(context, accent), child: Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800))), Switch(value: value, onChanged: (_) {}, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)]));
}

class _LayerBox extends StatelessWidget {
  const _LayerBox({required this.label, required this.icon, required this.accent});
  final String label;
  final IconData icon;
  final Color accent;
  @override
  Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), decoration: _softBox(context, accent), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 15, color: accent), const SizedBox(width: 6), Flexible(child: Text(label, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900)))]));
}

class _TestRow extends StatelessWidget {
  const _TestRow({required this.label, required this.ok});
  final String label;
  final bool ok;
  @override
  Widget build(BuildContext context) => Row(children: [Icon(ok ? Icons.check_circle_rounded : Icons.cancel_rounded, size: 17, color: ok ? const Color(0xFF10B981) : Colors.redAccent), const SizedBox(width: 8), Expanded(child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800))), Text(ok ? 'PASS' : 'FAIL', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: ok ? const Color(0xFF10B981) : Colors.redAccent))]);
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value, required this.accent});
  final String label;
  final String value;
  final Color accent;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(10), decoration: _softBox(context, accent), child: Column(children: [Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: accent)), Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800))]));
}

class _GestureCard extends StatelessWidget {
  const _GestureCard({required this.icon, required this.title, required this.subtitle, required this.accent});
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(10), decoration: _softBox(context, accent), child: Row(children: [Icon(icon, color: accent, size: 20), const SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)), Text(subtitle, style: const TextStyle(fontSize: 8))]))]));
}

BoxDecoration _softBox(BuildContext context, Color accent) {
  final scheme = Theme.of(context).colorScheme;
  return BoxDecoration(
    color: Color.alphaBlend(accent.withValues(alpha: .06), scheme.surface),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: accent.withValues(alpha: .18)),
  );
}
