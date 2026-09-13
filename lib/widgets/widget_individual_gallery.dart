import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/course_section.dart';

/// Galería visual con una imagen SVG independiente por widget/concepto.
///
/// A diferencia de los posters generales, aquí cada tarjeta representa un solo
/// widget para que el estudiante pueda reconocerlo antes de implementarlo.
class WidgetIndividualGallery extends StatelessWidget {
  const WidgetIndividualGallery({
    super.key,
    required this.section,
    this.compact = false,
  });

  final CourseSection section;
  final bool compact;

  static bool supports(CourseSection section) =>
      visualsFor(section.id).isNotEmpty;

  static List<WidgetVisualItem> visualsFor(String id) {
    return switch (id) {
      'flutter-intro' => const [
          WidgetVisualItem('Scaffold', 'Estructura base de la pantalla', WidgetVisualKind.scaffold),
          WidgetVisualItem('AppBar', 'Barra superior con título y acciones', WidgetVisualKind.appBar),
          WidgetVisualItem('Body', 'Contenido principal de la pantalla', WidgetVisualKind.body),
          WidgetVisualItem('FloatingActionButton', 'Acción principal flotante', WidgetVisualKind.fab),
        ],
      'widgets-layout' => const [
          WidgetVisualItem('Container', 'Caja visual con tamaño, color y decoración', WidgetVisualKind.container),
          WidgetVisualItem('Padding', 'Espacio interno alrededor de un widget', WidgetVisualKind.padding),
          WidgetVisualItem('Center', 'Centra su hijo en el espacio disponible', WidgetVisualKind.center),
          WidgetVisualItem('Row', 'Organiza widgets horizontalmente', WidgetVisualKind.row),
          WidgetVisualItem('Column', 'Organiza widgets verticalmente', WidgetVisualKind.column),
          WidgetVisualItem('Expanded', 'Ocupa el espacio restante disponible', WidgetVisualKind.expanded),
        ],
      'estado-reactividad' => const [
          WidgetVisualItem('StatefulWidget', 'Widget capaz de reaccionar a cambios', WidgetVisualKind.state),
          WidgetVisualItem('setState', 'Notifica cambios y reconstruye la UI', WidgetVisualKind.stateAction),
          WidgetVisualItem('ListenableBuilder', 'Escucha cambios de un Listenable', WidgetVisualKind.listener),
          WidgetVisualItem('Badge', 'Muestra información de estado compacta', WidgetVisualKind.badge),
        ],
      'navegacion' => const [
          WidgetVisualItem('Navigator', 'Abre y cierra pantallas', WidgetVisualKind.navigator),
          WidgetVisualItem('Drawer', 'Menú lateral de navegación', WidgetVisualKind.drawer),
          WidgetVisualItem('NavigationBar', 'Navegación inferior de Material 3', WidgetVisualKind.navigationBar),
          WidgetVisualItem('TabBar', 'Cambia entre secciones relacionadas', WidgetVisualKind.tabBar),
        ],
      'formularios' => const [
          WidgetVisualItem('Form', 'Agrupa y valida campos', WidgetVisualKind.form),
          WidgetVisualItem('TextFormField', 'Campo de texto con validación', WidgetVisualKind.textField),
          WidgetVisualItem('DropdownButtonFormField', 'Selector dentro de un formulario', WidgetVisualKind.dropdown),
          WidgetVisualItem('FilledButton', 'Acción principal de Material 3', WidgetVisualKind.filledButton),
          WidgetVisualItem('OutlinedButton', 'Acción secundaria con borde', WidgetVisualKind.outlinedButton),
        ],
      'async-api' => const [
          WidgetVisualItem('FutureBuilder', 'Representa loading, datos y error', WidgetVisualKind.future),
          WidgetVisualItem('CircularProgressIndicator', 'Indica una carga en progreso', WidgetVisualKind.progress),
          WidgetVisualItem('RefreshIndicator', 'Actualiza contenido con pull to refresh', WidgetVisualKind.refresh),
          WidgetVisualItem('ListView', 'Lista de resultados provenientes de la API', WidgetVisualKind.list),
        ],
      'persistencia' => const [
          WidgetVisualItem('SwitchListTile', 'Activa o desactiva preferencias', WidgetVisualKind.switchTile),
          WidgetVisualItem('CheckboxListTile', 'Representa opciones persistentes', WidgetVisualKind.checkboxTile),
          WidgetVisualItem('ListTile', 'Fila reutilizable para datos guardados', WidgetVisualKind.listTile),
        ],
      'arquitectura' => const [
          WidgetVisualItem('ListenableBuilder', 'Conecta controlador y UI', WidgetVisualKind.listener),
          WidgetVisualItem('Builder', 'Crea un contexto local de construcción', WidgetVisualKind.builder),
          WidgetVisualItem('InheritedWidget', 'Comparte datos por el árbol de widgets', WidgetVisualKind.inherited),
        ],
      'testing' => const [
          WidgetVisualItem('Key', 'Identifica widgets de forma estable', WidgetVisualKind.key),
          WidgetVisualItem('Semantics', 'Expone significado para accesibilidad y pruebas', WidgetVisualKind.semantics),
          WidgetVisualItem('Finder', 'Localiza widgets durante una prueba', WidgetVisualKind.finder),
        ],
      'rendimiento' => const [
          WidgetVisualItem('ListView.builder', 'Construye solo los items visibles', WidgetVisualKind.list),
          WidgetVisualItem('GridView.builder', 'Cuadrícula eficiente de elementos', WidgetVisualKind.grid),
          WidgetVisualItem('RepaintBoundary', 'Aísla zonas de repintado', WidgetVisualKind.repaint),
          WidgetVisualItem('const Widget', 'Evita reconstrucciones innecesarias', WidgetVisualKind.constWidget),
        ],
      'accesibilidad' => const [
          WidgetVisualItem('Semantics', 'Describe elementos a lectores de pantalla', WidgetVisualKind.semantics),
          WidgetVisualItem('Tooltip', 'Explica acciones con texto auxiliar', WidgetVisualKind.tooltip),
          WidgetVisualItem('Focus', 'Gestiona foco de teclado', WidgetVisualKind.focus),
          WidgetVisualItem('IconButton', 'Botón accesible basado en icono', WidgetVisualKind.iconButton),
        ],
      'flutter-widget-lifecycle' => const [
          WidgetVisualItem('StatefulWidget', 'Mantiene un objeto State asociado', WidgetVisualKind.state),
          WidgetVisualItem('State', 'Contiene datos mutables de la pantalla', WidgetVisualKind.stateBox),
          WidgetVisualItem('BuildContext', 'Ubica el widget dentro del árbol', WidgetVisualKind.context),
          WidgetVisualItem('Lifecycle', 'initState, build y dispose', WidgetVisualKind.lifecycle),
        ],
      'flutter-lists-grids' => const [
          WidgetVisualItem('ListView', 'Lista vertical desplazable', WidgetVisualKind.list),
          WidgetVisualItem('GridView', 'Cuadrícula de filas y columnas', WidgetVisualKind.grid),
          WidgetVisualItem('ListTile', 'Item estándar de una lista Material', WidgetVisualKind.listTile),
          WidgetVisualItem('Card', 'Agrupa visualmente un item', WidgetVisualKind.card),
          WidgetVisualItem('Scrollbar', 'Indica la posición del scroll', WidgetVisualKind.scrollbar),
        ],
      'flutter-material3-theme' => const [
          WidgetVisualItem('ThemeData', 'Configura el sistema visual de la app', WidgetVisualKind.theme),
          WidgetVisualItem('ColorScheme', 'Paleta semántica de colores', WidgetVisualKind.colorScheme),
          WidgetVisualItem('Card', 'Superficie Material con elevación', WidgetVisualKind.card),
          WidgetVisualItem('Chip', 'Etiqueta compacta e interactiva', WidgetVisualKind.chip),
          WidgetVisualItem('NavigationBar', 'Navegación inferior Material 3', WidgetVisualKind.navigationBar),
        ],
      'flutter-animations' => const [
          WidgetVisualItem('AnimatedContainer', 'Anima cambios de tamaño y decoración', WidgetVisualKind.animatedContainer),
          WidgetVisualItem('AnimatedSwitcher', 'Anima el cambio entre widgets', WidgetVisualKind.animatedSwitcher),
          WidgetVisualItem('TweenAnimationBuilder', 'Interpola valores automáticamente', WidgetVisualKind.tween),
          WidgetVisualItem('Hero', 'Anima un elemento entre pantallas', WidgetVisualKind.hero),
        ],
      'flutter-gestures-focus' => const [
          WidgetVisualItem('InkWell', 'Detecta taps con efecto Material', WidgetVisualKind.inkWell),
          WidgetVisualItem('GestureDetector', 'Detecta gestos personalizados', WidgetVisualKind.gesture),
          WidgetVisualItem('Focus', 'Gestiona el foco del teclado', WidgetVisualKind.focus),
          WidgetVisualItem('Shortcuts', 'Relaciona teclas con intenciones', WidgetVisualKind.shortcuts),
        ],
      'flutter-feedback-overlays' => const [
          WidgetVisualItem('SnackBar', 'Mensaje temporal en la parte inferior', WidgetVisualKind.snackBar),
          WidgetVisualItem('AlertDialog', 'Confirma acciones importantes', WidgetVisualKind.dialog),
          WidgetVisualItem('BottomSheet', 'Muestra acciones desde la zona inferior', WidgetVisualKind.bottomSheet),
          WidgetVisualItem('Tooltip', 'Ayuda contextual breve', WidgetVisualKind.tooltip),
        ],
      'flutter-state-architecture' => const [
          WidgetVisualItem('ListenableBuilder', 'UI reactiva conectada al controller', WidgetVisualKind.listener),
          WidgetVisualItem('InheritedWidget', 'Dependencias disponibles en el árbol', WidgetVisualKind.inherited),
          WidgetVisualItem('FutureBuilder', 'Integra operaciones asíncronas con UI', WidgetVisualKind.future),
        ],
      'flutter-offline-cache' => const [
          WidgetVisualItem('FutureBuilder', 'Carga datos locales o remotos', WidgetVisualKind.future),
          WidgetVisualItem('Banner', 'Informa que la app está sin conexión', WidgetVisualKind.banner),
          WidgetVisualItem('ListView', 'Muestra contenido disponible desde caché', WidgetVisualKind.list),
          WidgetVisualItem('IconButton', 'Permite sincronizar o reintentar', WidgetVisualKind.iconButton),
        ],
      _ => const <WidgetVisualItem>[],
    };
  }

  @override
  Widget build(BuildContext context) {
    final items = visualsFor(section.id);
    if (items.isEmpty) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final accent = Color(section.accentValue);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 14 : 18),
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
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${items.length} widgets visualizados individualmente en esta lección.',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              if (compact) {
                return SizedBox(
                  height: 220,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) => SizedBox(
                      width: 235,
                      child: _WidgetVisualCard(item: items[index], accent: accent),
                    ),
                  ),
                );
              }

              final columns = constraints.maxWidth >= 760 ? 3 : 2;
              final width = (constraints.maxWidth - ((columns - 1) * 12)) / columns;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final item in items)
                    SizedBox(
                      width: width,
                      child: _WidgetVisualCard(item: item, accent: accent),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class WidgetVisualItem {
  const WidgetVisualItem(this.name, this.description, this.kind);

  final String name;
  final String description;
  final WidgetVisualKind kind;
}

enum WidgetVisualKind {
  scaffold,
  appBar,
  body,
  fab,
  container,
  padding,
  center,
  row,
  column,
  expanded,
  state,
  stateAction,
  listener,
  badge,
  navigator,
  drawer,
  navigationBar,
  tabBar,
  form,
  textField,
  dropdown,
  filledButton,
  outlinedButton,
  future,
  progress,
  refresh,
  list,
  switchTile,
  checkboxTile,
  listTile,
  builder,
  inherited,
  key,
  semantics,
  finder,
  grid,
  repaint,
  constWidget,
  tooltip,
  focus,
  iconButton,
  stateBox,
  context,
  lifecycle,
  card,
  scrollbar,
  theme,
  colorScheme,
  chip,
  animatedContainer,
  animatedSwitcher,
  tween,
  hero,
  inkWell,
  gesture,
  shortcuts,
  snackBar,
  dialog,
  bottomSheet,
  banner,
}

class _WidgetVisualCard extends StatelessWidget {
  const _WidgetVisualCard({required this.item, required this.accent});

  final WidgetVisualItem item;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: SvgPicture.string(
              _svgFor(item),
              fit: BoxFit.cover,
              semanticsLabel: 'Imagen del widget ${item.name}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
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

String _svgFor(WidgetVisualItem item) {
  final art = switch (item.kind) {
    WidgetVisualKind.scaffold => _phone('<rect x="150" y="65" width="220" height="36" rx="8" fill="#0ea5e9"/><rect x="165" y="120" width="190" height="90" rx="14" fill="#e0f2fe"/><circle cx="330" cy="230" r="22" fill="#2563eb"/><text x="322" y="238" class="white">+</text>'),
    WidgetVisualKind.appBar => _phone('<rect x="150" y="65" width="220" height="48" rx="8" fill="#0ea5e9"/><text x="176" y="95" class="white">Mi Biblioteca</text><circle cx="340" cy="89" r="9" fill="#fff"/>'),
    WidgetVisualKind.body => _phone('<rect x="165" y="120" width="190" height="42" rx="10" fill="#dbeafe"/><rect x="165" y="174" width="190" height="42" rx="10" fill="#e0f2fe"/><rect x="165" y="228" width="190" height="42" rx="10" fill="#ecfeff"/>'),
    WidgetVisualKind.fab => _phone('<rect x="165" y="120" width="190" height="105" rx="14" fill="#eff6ff"/><circle cx="330" cy="235" r="27" fill="#2563eb"/><text x="320" y="245" class="white big">+</text>'),
    WidgetVisualKind.container => '<rect x="95" y="65" width="330" height="190" rx="30" fill="#dbeafe" stroke="#2563eb" stroke-width="4"/><rect x="135" y="105" width="250" height="110" rx="22" fill="#fff"/><text x="190" y="170" class="label">Container</text>',
    WidgetVisualKind.padding => '<rect x="90" y="60" width="340" height="200" rx="26" fill="#f5f3ff" stroke="#8b5cf6" stroke-width="3" stroke-dasharray="10 8"/><rect x="145" y="110" width="230" height="100" rx="18" fill="#ddd6fe"/><text x="208" y="169" class="label">Padding</text>',
    WidgetVisualKind.center => '<rect x="90" y="55" width="340" height="210" rx="24" fill="#eff6ff"/><line x1="260" y1="75" x2="260" y2="245" stroke="#93c5fd" stroke-width="3"/><line x1="115" y1="160" x2="405" y2="160" stroke="#93c5fd" stroke-width="3"/><rect x="205" y="125" width="110" height="70" rx="16" fill="#2563eb"/><text x="226" y="168" class="white">Center</text>',
    WidgetVisualKind.row => '<rect x="75" y="80" width="115" height="130" rx="18" fill="#dbeafe"/><rect x="205" y="80" width="115" height="130" rx="18" fill="#bfdbfe"/><rect x="335" y="80" width="115" height="130" rx="18" fill="#93c5fd"/><path d="M90 235H435" stroke="#2563eb" stroke-width="6" stroke-linecap="round"/><text x="220" y="266" class="small">Row</text>',
    WidgetVisualKind.column => '<rect x="145" y="48" width="230" height="55" rx="16" fill="#dbeafe"/><rect x="145" y="118" width="230" height="55" rx="16" fill="#bfdbfe"/><rect x="145" y="188" width="230" height="55" rx="16" fill="#93c5fd"/><text x="215" y="276" class="small">Column</text>',
    WidgetVisualKind.expanded => '<rect x="70" y="92" width="95" height="135" rx="14" fill="#cbd5e1"/><rect x="180" y="92" width="275" height="135" rx="14" fill="#3b82f6"/><text x="248" y="166" class="white">Expanded</text><path d="M195 68H440" stroke="#2563eb" stroke-width="4"/><path d="M195 68l16-10v20zM440 68l-16-10v20z" fill="#2563eb"/>',
    WidgetVisualKind.state || WidgetVisualKind.stateBox => '<rect x="105" y="75" width="310" height="170" rx="28" fill="#ecfeff" stroke="#14b8a6" stroke-width="4"/><circle cx="190" cy="160" r="40" fill="#14b8a6"/><text x="176" y="169" class="white">S</text><path d="M245 132H370M245 160H345M245 188H320" stroke="#0f766e" stroke-width="10" stroke-linecap="round"/>',
    WidgetVisualKind.stateAction => '<rect x="105" y="75" width="310" height="170" rx="28" fill="#f0fdf4"/><text x="155" y="135" class="label">setState()</text><path d="M165 180C215 230 320 230 370 165" fill="none" stroke="#22c55e" stroke-width="10" stroke-linecap="round"/><path d="M370 165l-30 6 18 24z" fill="#22c55e"/>',
    WidgetVisualKind.listener => '<rect x="95" y="72" width="135" height="175" rx="22" fill="#dbeafe"/><rect x="290" y="72" width="135" height="175" rx="22" fill="#dcfce7"/><path d="M230 160H290" stroke="#2563eb" stroke-width="8"/><circle cx="260" cy="160" r="16" fill="#2563eb"/><text x="120" y="166" class="small">State</text><text x="325" y="166" class="small">UI</text>',
    WidgetVisualKind.badge => '<rect x="120" y="100" width="280" height="120" rx="26" fill="#fff" stroke="#cbd5e1" stroke-width="3"/><circle cx="260" cy="160" r="34" fill="#2563eb"/><text x="247" y="171" class="white">★</text><circle cx="294" cy="124" r="22" fill="#ef4444"/><text x="287" y="131" class="white tiny">3</text>',
    WidgetVisualKind.navigator => '<rect x="75" y="80" width="150" height="180" rx="26" fill="#dbeafe"/><rect x="295" y="80" width="150" height="180" rx="26" fill="#dcfce7"/><path d="M235 170H285" stroke="#2563eb" stroke-width="8"/><path d="M285 170l-22-15v30z" fill="#2563eb"/><text x="113" y="170" class="small">Lista</text><text x="326" y="170" class="small">Detalle</text>',
    WidgetVisualKind.drawer => _phone('<rect x="150" y="65" width="145" height="220" rx="12" fill="#fff"/><rect x="172" y="92" width="95" height="18" rx="9" fill="#34d399"/><rect x="172" y="128" width="95" height="12" rx="6" fill="#cbd5e1"/><rect x="172" y="158" width="95" height="12" rx="6" fill="#cbd5e1"/><rect x="172" y="188" width="95" height="12" rx="6" fill="#cbd5e1"/>'),
    WidgetVisualKind.navigationBar => _phone('<rect x="150" y="238" width="220" height="50" rx="16" fill="#fff"/><circle cx="185" cy="263" r="10" fill="#0ea5e9"/><circle cx="235" cy="263" r="10" fill="#cbd5e1"/><circle cx="285" cy="263" r="10" fill="#cbd5e1"/><circle cx="335" cy="263" r="10" fill="#cbd5e1"/>'),
    WidgetVisualKind.tabBar => _phone('<rect x="150" y="65" width="220" height="45" rx="8" fill="#ecfeff"/><text x="180" y="92" class="small">Lista</text><text x="285" y="92" class="small">Grid</text><rect x="165" y="104" width="80" height="5" rx="3" fill="#14b8a6"/>'),
    WidgetVisualKind.form => _phone('<rect x="165" y="90" width="190" height="40" rx="10" fill="#fff" stroke="#94a3b8"/><rect x="165" y="145" width="190" height="40" rx="10" fill="#fff" stroke="#94a3b8"/><rect x="165" y="205" width="190" height="46" rx="14" fill="#10b981"/><text x="222" y="234" class="white">Guardar</text>'),
    WidgetVisualKind.textField => '<rect x="85" y="95" width="350" height="92" rx="18" fill="#fff" stroke="#94a3b8" stroke-width="3"/><text x="110" y="132" class="tiny dark">Título</text><text x="110" y="168" class="small muted">Escribe aquí...</text><line x1="110" y1="203" x2="390" y2="203" stroke="#ef4444" stroke-width="4"/><text x="110" y="228" class="tiny red">Campo obligatorio</text>',
    WidgetVisualKind.dropdown => '<rect x="85" y="95" width="350" height="92" rx="18" fill="#fff" stroke="#94a3b8" stroke-width="3"/><text x="110" y="132" class="tiny dark">Categoría</text><text x="110" y="171" class="small muted">Selecciona una opción</text><path d="M395 142l14 14 14-14" fill="none" stroke="#64748b" stroke-width="5"/>',
    WidgetVisualKind.filledButton => '<rect x="130" y="110" width="260" height="90" rx="28" fill="#2563eb"/><text x="203" y="166" class="white">Continuar</text>',
    WidgetVisualKind.outlinedButton => '<rect x="130" y="110" width="260" height="90" rx="28" fill="#fff" stroke="#2563eb" stroke-width="4"/><text x="203" y="166" class="blue">Cancelar</text>',
    WidgetVisualKind.future => '<rect x="90" y="80" width="340" height="170" rx="24" fill="#eef2ff"/><circle cx="165" cy="165" r="38" fill="none" stroke="#6366f1" stroke-width="12" stroke-dasharray="90 40"/><text x="230" y="145" class="label">FutureBuilder</text><text x="230" y="178" class="small muted">loading → data → error</text>',
    WidgetVisualKind.progress => '<circle cx="260" cy="155" r="70" fill="none" stroke="#dbeafe" stroke-width="18"/><path d="M260 85A70 70 0 0 1 330 155" fill="none" stroke="#2563eb" stroke-width="18" stroke-linecap="round"/><text x="208" y="270" class="small">Cargando...</text>',
    WidgetVisualKind.refresh => '<path d="M190 110A85 85 0 1 1 175 190" fill="none" stroke="#0ea5e9" stroke-width="18" stroke-linecap="round"/><path d="M165 78l56 8-33 45z" fill="#0ea5e9"/><text x="205" y="170" class="label">Refresh</text>',
    WidgetVisualKind.list => '<rect x="105" y="58" width="310" height="58" rx="16" fill="#fff" stroke="#cbd5e1"/><rect x="105" y="132" width="310" height="58" rx="16" fill="#fff" stroke="#cbd5e1"/><rect x="105" y="206" width="310" height="58" rx="16" fill="#fff" stroke="#cbd5e1"/><circle cx="142" cy="87" r="15" fill="#60a5fa"/><circle cx="142" cy="161" r="15" fill="#34d399"/><circle cx="142" cy="235" r="15" fill="#a78bfa"/><path d="M178 82H375M178 156H375M178 230H375" stroke="#94a3b8" stroke-width="8" stroke-linecap="round"/>',
    WidgetVisualKind.switchTile => '<rect x="85" y="105" width="350" height="100" rx="22" fill="#fff" stroke="#cbd5e1"/><text x="112" y="164" class="label">Modo offline</text><rect x="340" y="130" width="70" height="38" rx="19" fill="#22c55e"/><circle cx="389" cy="149" r="15" fill="#fff"/>',
    WidgetVisualKind.checkboxTile => '<rect x="85" y="105" width="350" height="100" rx="22" fill="#fff" stroke="#cbd5e1"/><rect x="110" y="135" width="38" height="38" rx="8" fill="#2563eb"/><path d="M118 154l8 8 15-18" fill="none" stroke="#fff" stroke-width="6"/><text x="172" y="164" class="label">Guardar preferencia</text>',
    WidgetVisualKind.listTile => '<rect x="85" y="100" width="350" height="115" rx="20" fill="#fff" stroke="#cbd5e1"/><circle cx="135" cy="157" r="28" fill="#dbeafe"/><path d="M185 138H365M185 168H320" stroke="#64748b" stroke-width="10" stroke-linecap="round"/><path d="M390 145l12 12-12 12" fill="none" stroke="#64748b" stroke-width="5"/>',
    WidgetVisualKind.builder => '<rect x="105" y="78" width="310" height="165" rx="24" fill="#f8fafc" stroke="#cbd5e1"/><text x="185" y="135" class="label">Builder</text><path d="M165 185H355" stroke="#2563eb" stroke-width="8" stroke-dasharray="12 10"/><circle cx="260" cy="185" r="24" fill="#2563eb"/>',
    WidgetVisualKind.inherited => '<circle cx="260" cy="82" r="34" fill="#2563eb"/><path d="M260 116V150M260 150H150M260 150H370M150 150V205M370 150V205" stroke="#64748b" stroke-width="6"/><rect x="95" y="205" width="110" height="55" rx="14" fill="#dbeafe"/><rect x="315" y="205" width="110" height="55" rx="14" fill="#dcfce7"/><text x="218" y="90" class="white tiny">data</text>',
    WidgetVisualKind.key => '<rect x="105" y="95" width="310" height="125" rx="22" fill="#fff7ed"/><circle cx="175" cy="158" r="38" fill="#f59e0b"/><rect x="205" y="147" width="105" height="22" rx="11" fill="#f59e0b"/><rect x="290" y="147" width="22" height="50" rx="8" fill="#f59e0b"/><text x="330" y="169" class="label">Key</text>',
    WidgetVisualKind.semantics => '<rect x="95" y="80" width="330" height="170" rx="24" fill="#eff6ff"/><circle cx="170" cy="165" r="46" fill="#2563eb"/><text x="153" y="176" class="white big">A</text><path d="M235 125H385M235 160H360M235 195H330" stroke="#64748b" stroke-width="10" stroke-linecap="round"/>',
    WidgetVisualKind.finder => '<rect x="110" y="85" width="300" height="150" rx="24" fill="#f8fafc" stroke="#cbd5e1"/><circle cx="220" cy="150" r="45" fill="none" stroke="#2563eb" stroke-width="12"/><line x1="252" y1="183" x2="315" y2="225" stroke="#2563eb" stroke-width="12" stroke-linecap="round"/><text x="300" y="135" class="label">Finder</text>',
    WidgetVisualKind.grid => '<rect x="100" y="55" width="140" height="90" rx="18" fill="#dbeafe"/><rect x="280" y="55" width="140" height="90" rx="18" fill="#bfdbfe"/><rect x="100" y="175" width="140" height="90" rx="18" fill="#a7f3d0"/><rect x="280" y="175" width="140" height="90" rx="18" fill="#ddd6fe"/>',
    WidgetVisualKind.repaint => '<rect x="105" y="75" width="310" height="170" rx="22" fill="#fff" stroke="#cbd5e1"/><rect x="145" y="110" width="110" height="100" rx="18" fill="#dbeafe" stroke="#2563eb" stroke-width="4"/><rect x="280" y="110" width="95" height="100" rx="18" fill="#f1f5f9"/><text x="157" y="164" class="tiny dark">repaint</text>',
    WidgetVisualKind.constWidget => '<rect x="115" y="90" width="290" height="140" rx="24" fill="#ecfdf5" stroke="#10b981" stroke-width="4"/><text x="185" y="152" class="label">const</text><path d="M190 185H330" stroke="#10b981" stroke-width="8" stroke-linecap="round"/><text x="214" y="216" class="tiny dark">Widget estable</text>',
    WidgetVisualKind.tooltip => '<circle cx="260" cy="170" r="34" fill="#2563eb"/><text x="247" y="181" class="white">?</text><rect x="170" y="72" width="180" height="58" rx="14" fill="#111827"/><text x="195" y="108" class="white tiny">Ayuda contextual</text><path d="M255 130l12 20 12-20z" fill="#111827"/>',
    WidgetVisualKind.focus => '<rect x="130" y="95" width="260" height="120" rx="24" fill="#fff" stroke="#2563eb" stroke-width="5"/><rect x="145" y="110" width="230" height="90" rx="16" fill="#eff6ff" stroke="#93c5fd" stroke-width="2"/><text x="220" y="165" class="label">Focus</text>',
    WidgetVisualKind.iconButton => '<circle cx="260" cy="158" r="68" fill="#dbeafe"/><circle cx="260" cy="158" r="42" fill="#2563eb"/><text x="243" y="171" class="white big">★</text><text x="205" y="260" class="small">IconButton</text>',
    WidgetVisualKind.context => '<rect x="110" y="72" width="300" height="175" rx="24" fill="#f8fafc"/><circle cx="260" cy="125" r="36" fill="#2563eb"/><path d="M260 161V205M260 205H180M260 205H340" stroke="#64748b" stroke-width="7"/><circle cx="180" cy="220" r="22" fill="#93c5fd"/><circle cx="340" cy="220" r="22" fill="#86efac"/><text x="180" y="95" class="small">BuildContext</text>',
    WidgetVisualKind.lifecycle => '<circle cx="260" cy="158" r="92" fill="none" stroke="#cbd5e1" stroke-width="16"/><path d="M260 66A92 92 0 0 1 352 158" fill="none" stroke="#2563eb" stroke-width="16"/><path d="M352 158A92 92 0 0 1 260 250" fill="none" stroke="#10b981" stroke-width="16"/><text x="205" y="155" class="tiny dark">initState</text><text x="230" y="180" class="tiny dark">build</text><text x="220" y="205" class="tiny dark">dispose</text>',
    WidgetVisualKind.card => '<rect x="105" y="70" width="310" height="180" rx="28" fill="#fff" stroke="#dbeafe" stroke-width="3"/><rect x="135" y="100" width="95" height="120" rx="16" fill="#bfdbfe"/><path d="M260 120H380M260 155H350M260 190H330" stroke="#64748b" stroke-width="10" stroke-linecap="round"/>',
    WidgetVisualKind.scrollbar => '<rect x="120" y="55" width="270" height="220" rx="22" fill="#fff" stroke="#cbd5e1"/><rect x="360" y="80" width="10" height="170" rx="5" fill="#e2e8f0"/><rect x="360" y="115" width="10" height="65" rx="5" fill="#2563eb"/><path d="M150 100H330M150 145H330M150 190H330M150 235H330" stroke="#cbd5e1" stroke-width="12" stroke-linecap="round"/>',
    WidgetVisualKind.theme => '<circle cx="180" cy="160" r="42" fill="#6366f1"/><circle cx="260" cy="125" r="42" fill="#0ea5e9"/><circle cx="340" cy="160" r="42" fill="#10b981"/><circle cx="260" cy="205" r="42" fill="#f59e0b"/><text x="205" y="280" class="small">ThemeData</text>',
    WidgetVisualKind.colorScheme => '<rect x="80" y="95" width="85" height="130" rx="18" fill="#4f46e5"/><rect x="175" y="95" width="85" height="130" rx="18" fill="#0ea5e9"/><rect x="270" y="95" width="85" height="130" rx="18" fill="#10b981"/><rect x="365" y="95" width="85" height="130" rx="18" fill="#f59e0b"/>',
    WidgetVisualKind.chip => '<rect x="125" y="105" width="125" height="55" rx="28" fill="#dbeafe"/><text x="155" y="140" class="tiny dark">Ficción</text><rect x="270" y="105" width="125" height="55" rx="28" fill="#dcfce7"/><text x="305" y="140" class="tiny dark">Nuevo</text><rect x="190" y="180" width="140" height="55" rx="28" fill="#ede9fe"/><text x="222" y="215" class="tiny dark">Favorito</text>',
    WidgetVisualKind.animatedContainer => '<rect x="95" y="110" width="120" height="100" rx="18" fill="#93c5fd"/><path d="M230 160H295" stroke="#2563eb" stroke-width="8"/><path d="M295 160l-20-14v28z" fill="#2563eb"/><rect x="315" y="80" width="130" height="160" rx="32" fill="#60a5fa"/><text x="168" y="280" class="small">AnimatedContainer</text>',
    WidgetVisualKind.animatedSwitcher => '<rect x="100" y="95" width="135" height="135" rx="26" fill="#ddd6fe"/><text x="152" y="172" class="label">A</text><path d="M245 162H300" stroke="#8b5cf6" stroke-width="8"/><path d="M300 162l-20-14v28z" fill="#8b5cf6"/><rect x="315" y="95" width="135" height="135" rx="26" fill="#bfdbfe"/><text x="367" y="172" class="label">B</text>',
    WidgetVisualKind.tween => '<circle cx="120" cy="160" r="22" fill="#2563eb"/><circle cx="400" cy="160" r="42" fill="#8b5cf6"/><path d="M150 160H360" stroke="#c4b5fd" stroke-width="10" stroke-dasharray="18 12"/><circle cx="255" cy="160" r="32" fill="#60a5fa"/><text x="170" y="245" class="small">Tween 0 → 1</text>',
    WidgetVisualKind.hero => '<rect x="80" y="85" width="145" height="150" rx="24" fill="#eff6ff"/><circle cx="152" cy="160" r="42" fill="#2563eb"/><path d="M235 160H285" stroke="#2563eb" stroke-width="8"/><rect x="295" y="65" width="145" height="190" rx="24" fill="#eff6ff"/><circle cx="367" cy="160" r="60" fill="#2563eb"/><text x="225" y="285" class="small">Hero</text>',
    WidgetVisualKind.inkWell => '<rect x="115" y="100" width="290" height="125" rx="30" fill="#dbeafe"/><circle cx="260" cy="162" r="50" fill="#93c5fd" fill-opacity=".65"/><circle cx="260" cy="162" r="25" fill="#2563eb"/><text x="212" y="275" class="small">InkWell</text>',
    WidgetVisualKind.gesture => '<rect x="120" y="95" width="280" height="140" rx="28" fill="#fff7ed"/><path d="M220 185c0-70 80-80 80-20v35M260 200v-75M300 200v-55" fill="none" stroke="#f59e0b" stroke-width="14" stroke-linecap="round"/><text x="185" y="275" class="small">GestureDetector</text>',
    WidgetVisualKind.shortcuts => '<rect x="110" y="85" width="300" height="165" rx="24" fill="#111827"/><rect x="140" y="115" width="70" height="55" rx="10" fill="#334155"/><rect x="225" y="115" width="70" height="55" rx="10" fill="#334155"/><rect x="310" y="115" width="70" height="55" rx="10" fill="#334155"/><rect x="165" y="188" width="190" height="38" rx="10" fill="#475569"/><text x="163" y="151" class="white tiny">CTRL</text><text x="248" y="151" class="white tiny">K</text>',
    WidgetVisualKind.snackBar => _phone('<rect x="160" y="215" width="200" height="48" rx="12" fill="#065f46"/><text x="178" y="245" class="white tiny">Guardado correctamente</text>'),
    WidgetVisualKind.dialog => _phone('<rect x="170" y="115" width="180" height="125" rx="18" fill="#fff" stroke="#cbd5e1"/><text x="205" y="150" class="tiny dark">¿Eliminar libro?</text><rect x="195" y="190" width="60" height="28" rx="10" fill="#e2e8f0"/><rect x="268" y="190" width="60" height="28" rx="10" fill="#ef4444"/>'),
    WidgetVisualKind.bottomSheet => _phone('<rect x="150" y="175" width="220" height="113" rx="22" fill="#fff"/><rect x="225" y="187" width="70" height="7" rx="4" fill="#cbd5e1"/><circle cx="195" cy="235" r="18" fill="#dbeafe"/><circle cx="260" cy="235" r="18" fill="#dcfce7"/><circle cx="325" cy="235" r="18" fill="#ede9fe"/>'),
    WidgetVisualKind.banner => '<rect x="95" y="85" width="330" height="155" rx="24" fill="#fff7ed"/><path d="M95 85h115l-115 115z" fill="#f59e0b"/><text x="108" y="120" class="white tiny" transform="rotate(-45 108 120)">OFFLINE</text><text x="215" y="170" class="label">Sin conexión</text>',
  };

  return '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 320">
<style>
.bg{fill:#f8fafc}.label{font:700 24px Arial;fill:#0f172a}.small{font:700 19px Arial;fill:#334155}.tiny{font:700 15px Arial}.white{font:700 19px Arial;fill:white}.white.big{font-size:30px}.white.tiny{font-size:13px}.blue{font:700 20px Arial;fill:#2563eb}.dark{fill:#0f172a}.muted{fill:#64748b}.red{fill:#ef4444}
</style>
<rect width="520" height="320" rx="28" class="bg"/>
$art
</svg>''';
}

String _phone(String body) => '''
<rect x="125" y="28" width="270" height="274" rx="40" fill="#111827"/>
<rect x="142" y="45" width="236" height="240" rx="28" fill="#f8fafc"/>
<rect x="220" y="52" width="80" height="14" rx="7" fill="#0f172a"/>
$body
''';
