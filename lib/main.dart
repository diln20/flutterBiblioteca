import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const BibliotecaApp());

class BibliotecaApp extends StatelessWidget {
  const BibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca Flutter',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF07111F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF38BDF8),
          brightness: Brightness.dark,
          surface: const Color(0xFF0D1B2A),
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF0D1B2A),
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
      ),
      home: const LibraryHomePage(),
    );
  }
}

class CourseSection {
  final String id;
  final String group;
  final String title;
  final String level;
  final String description;
  final String code;
  final List<String> steps;
  final Color accent;

  const CourseSection({
    required this.id,
    required this.group,
    required this.title,
    required this.level,
    required this.description,
    required this.code,
    required this.steps,
    required this.accent,
  });
}

const sections = <CourseSection>[
  CourseSection(
    id: 'flutter-intro',
    group: 'Flutter',
    title: 'Introducción a Flutter',
    level: 'Principiante',
    description: 'Comprende widgets, árbol de renderizado y cómo se estructura una app Flutter.',
    code: '''void main() {\n  runApp(const MiApp());\n}\n\nclass MiApp extends StatelessWidget {\n  const MiApp({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return const MaterialApp(\n      home: Scaffold(\n        body: Center(child: Text('Hola Flutter')),\n      ),\n    );\n  }\n}''',
    steps: ['Crea un proyecto Flutter', 'Abre lib/main.dart', 'Reemplaza el contenido', 'Ejecuta flutter run'],
    accent: Color(0xFF38BDF8),
  ),
  CourseSection(
    id: 'dart-basics',
    group: 'Dart',
    title: 'Dart desde cero',
    level: 'Principiante',
    description: 'Variables, null safety, funciones, clases y colecciones que usarás a diario en Flutter.',
    code: '''String saludo(String nombre) => 'Hola, $nombre';\n\nvoid main() {\n  final tecnologias = <String>['Dart', 'Flutter'];\n  print(saludo(tecnologias.first));\n}''',
    steps: ['Practica final y const', 'Usa listas y mapas', 'Crea funciones tipadas', 'Modela datos con clases'],
    accent: Color(0xFF60A5FA),
  ),
  CourseSection(
    id: 'widgets-layout',
    group: 'UI',
    title: 'Widgets y layouts',
    level: 'Principiante',
    description: 'Domina Row, Column, Stack, Expanded y LayoutBuilder para interfaces responsive.',
    code: '''LayoutBuilder(\n  builder: (context, constraints) {\n    final desktop = constraints.maxWidth >= 900;\n    return desktop\n        ? const Row(children: [Sidebar(), Expanded(child: Content())])\n        : const Content();\n  },\n)''',
    steps: ['Construye una Column', 'Combina Row + Expanded', 'Prueba Stack', 'Adapta el layout por ancho'],
    accent: Color(0xFFE879F9),
  ),
  CourseSection(
    id: 'state',
    group: 'Estado',
    title: 'Estado y reactividad',
    level: 'Intermedio',
    description: 'Aprende setState, ValueNotifier y cómo separar estado de presentación.',
    code: '''final contador = ValueNotifier<int>(0);\n\nValueListenableBuilder<int>(\n  valueListenable: contador,\n  builder: (_, value, __) => Text('$value'),\n)''',
    steps: ['Empieza con setState', 'Extrae estado a ValueNotifier', 'Evita reconstrucciones innecesarias', 'Prepara la app para un gestor de estado'],
    accent: Color(0xFF34D399),
  ),
  CourseSection(
    id: 'navigation',
    group: 'Navegación',
    title: 'Rutas y navegación',
    level: 'Intermedio',
    description: 'Organiza pantallas y navegación con Navigator y patrones de rutas limpias.',
    code: '''Navigator.of(context).push(\n  MaterialPageRoute(\n    builder: (_) => const DetailPage(),\n  ),\n);''',
    steps: ['Crea una segunda pantalla', 'Navega con push', 'Regresa con pop', 'Pasa argumentos tipados'],
    accent: Color(0xFFA78BFA),
  ),
  CourseSection(
    id: 'api',
    group: 'APIs',
    title: 'Consumo de APIs',
    level: 'Intermedio',
    description: 'Modela respuestas, estados de carga, error y éxito para datos remotos.',
    code: '''Future<void> cargar() async {\n  setState(() => cargando = true);\n  try {\n    final datos = await repositorio.obtenerDatos();\n    setState(() => items = datos);\n  } finally {\n    setState(() => cargando = false);\n  }\n}''',
    steps: ['Crea un repositorio', 'Modela JSON', 'Maneja loading/error', 'Renderiza datos en lista'],
    accent: Color(0xFF22D3EE),
  ),
  CourseSection(
    id: 'architecture',
    group: 'Arquitectura',
    title: 'Arquitectura de proyecto',
    level: 'Avanzado',
    description: 'Separa presentación, dominio y datos para mantener una app grande y testeable.',
    code: '''lib/\n  core/\n  features/\n    biblioteca/\n      data/\n      domain/\n      presentation/''',
    steps: ['Agrupa por feature', 'Separa modelos de UI', 'Centraliza servicios', 'Añade pruebas por capa'],
    accent: Color(0xFFF97316),
  ),
];

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  final _search = TextEditingController();
  final Set<String> _favorites = {};
  final Set<String> _completed = {};
  String? _selectedId;
  String _group = 'Todos';

  @override
  void initState() {
    super.initState();
    _selectedId = sections.first.id;
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _favorites.addAll(prefs.getStringList('favorites') ?? const []);
      _completed.addAll(prefs.getStringList('completed') ?? const []);
      _selectedId = prefs.getString('selected') ?? _selectedId;
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites.toList());
    await prefs.setStringList('completed', _completed.toList());
    if (_selectedId != null) await prefs.setString('selected', _selectedId!);
  }

  List<CourseSection> get _filtered {
    final q = _search.text.trim().toLowerCase();
    return sections.where((s) {
      final matchesGroup = _group == 'Todos' || s.group == _group;
      final matchesSearch = q.isEmpty ||
          s.title.toLowerCase().contains(q) ||
          s.group.toLowerCase().contains(q) ||
          s.description.toLowerCase().contains(q);
      return matchesGroup && matchesSearch;
    }).toList();
  }

  CourseSection get _selected => sections.firstWhere(
        (s) => s.id == _selectedId,
        orElse: () => sections.first,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF091426),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Biblioteca Flutter', style: TextStyle(fontWeight: FontWeight.w800)),
            Text('Ruta interactiva de aprendizaje', style: TextStyle(fontSize: 12, color: Colors.white60)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text('${_completed.length}/${sections.length} completadas'),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          final wide = c.maxWidth >= 950;
          if (wide) {
            return Row(
              children: [
                SizedBox(width: 330, child: _sidebar()),
                const VerticalDivider(width: 1),
                Expanded(child: _detail(_selected)),
              ],
            );
          }
          return _mobile();
        },
      ),
    );
  }

  Widget _mobile() {
    return Column(
      children: [
        _filters(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ..._filtered.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _sectionTile(s, openDetail: true),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sidebar() {
    return Container(
      color: const Color(0xFF081321),
      child: Column(
        children: [
          _filters(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: LinearProgressIndicator(
              value: sections.isEmpty ? 0 : _completed.length / sections.length,
              minHeight: 6,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
              itemCount: _filtered.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _sectionTile(_filtered[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filters() {
    final groups = ['Todos', ...{for (final s in sections) s.group}];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _search,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Buscar tema, categoría o concepto',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFF0D1B2A),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: groups.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final g = groups[i];
                return ChoiceChip(
                  label: Text(g),
                  selected: _group == g,
                  onSelected: (_) => setState(() => _group = g),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTile(CourseSection s, {bool openDetail = false}) {
    final selected = s.id == _selectedId;
    final done = _completed.contains(s.id);
    final fav = _favorites.contains(s.id);
    return Material(
      color: selected ? s.accent.withValues(alpha: .12) : const Color(0xFF0D1B2A),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() => _selectedId = s.id);
          _save();
          if (openDetail) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(title: Text(s.title)), body: _detail(s))));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? s.accent.withValues(alpha: .6) : Colors.white10),
          ),
          child: Row(
            children: [
              Container(width: 4, height: 44, decoration: BoxDecoration(color: s.accent, borderRadius: BorderRadius.circular(99))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(s.group, style: TextStyle(color: s.accent, fontSize: 11, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 8),
                      Text(s.level, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ]),
                    const SizedBox(height: 4),
                    Text(s.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Favorito',
                onPressed: () { setState(() => fav ? _favorites.remove(s.id) : _favorites.add(s.id)); _save(); },
                icon: Icon(fav ? Icons.star : Icons.star_border, color: fav ? Colors.amber : Colors.white38),
              ),
              if (done) const Icon(Icons.check_circle, color: Color(0xFF34D399), size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detail(CourseSection s) {
    final done = _completed.contains(s.id);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(spacing: 8, runSpacing: 8, children: [
                Chip(label: Text(s.group), side: BorderSide(color: s.accent.withValues(alpha: .5))),
                Chip(label: Text(s.level)),
              ]),
              const SizedBox(height: 14),
              Text(s.title, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Text(s.description, style: const TextStyle(fontSize: 17, height: 1.55, color: Colors.white70)),
              const SizedBox(height: 22),
              FilledButton.icon(
                onPressed: () { setState(() => done ? _completed.remove(s.id) : _completed.add(s.id)); _save(); },
                icon: Icon(done ? Icons.check_circle : Icons.radio_button_unchecked),
                label: Text(done ? 'Completada' : 'Marcar como completada'),
              ),
              const SizedBox(height: 28),
              _panel('Ruta guiada', Column(
                children: [for (var i = 0; i < s.steps.length; i++) ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(radius: 15, backgroundColor: s.accent.withValues(alpha: .14), child: Text('${i + 1}', style: TextStyle(color: s.accent, fontSize: 12, fontWeight: FontWeight.w800))),
                  title: Text(s.steps[i]),
                )],
              )),
              const SizedBox(height: 18),
              _panel('Código de ejemplo', Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: const Color(0xFF050B13), borderRadius: BorderRadius.circular(12)),
                child: SelectableText(s.code, style: const TextStyle(fontFamily: 'monospace', height: 1.5, color: Color(0xFFC6E6FF))),
              )),
              const SizedBox(height: 18),
              _panel('Ejercicio', const Text('Reproduce el ejemplo, cambia una parte del comportamiento y documenta qué widget o concepto fue responsable del cambio.', style: TextStyle(height: 1.5))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _panel(String title, Widget child) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1B2A),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          child,
        ]),
      );
}
