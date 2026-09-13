import '../../models/course_section.dart';

/// Etapas posteriores a los fundamentos del lenguaje Dart.
const flutterCatalog = <CourseSection>[
  CourseSection(
    id: 'flutter-intro',
    group: 'Flutter',
    title: 'Introducción a Flutter',
    level: 'Principiante',
    description: 'Comprende widgets, árbol de widgets, BuildContext y el ciclo básico de construcción de una interfaz Flutter.',
    whyItMatters: 'Todo en Flutter se compone con widgets. Esta idea es la base para leer y crear cualquier pantalla.',
    code: r"""void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Hola Flutter')),
      ),
    );
  }
}""",
    steps: ['Crea el proyecto con flutter create', 'Revisa lib/main.dart', 'Identifica MaterialApp y Scaffold', 'Ejecuta flutter run'],
    challenge: 'Cambia la pantalla inicial por una tarjeta con icono, título y descripción.',
    keywords: ['widgets', 'buildcontext', 'materialapp', 'scaffold'],
    accentValue: 0xFF38BDF8,
  ),
  CourseSection(
    id: 'widgets-layout',
    group: 'UI',
    title: 'Widgets y layouts responsive',
    level: 'Principiante',
    description: 'Domina Row, Column, Stack, Expanded, Flexible y LayoutBuilder para interfaces adaptables.',
    whyItMatters: 'Una app Flutter puede ejecutarse en diferentes tamaños de pantalla y debe responder al espacio disponible.',
    code: r"""LayoutBuilder(
  builder: (context, constraints) {
    final desktop = constraints.maxWidth >= 900;
    return desktop
        ? Row(children: [sidebar, Expanded(child: content)])
        : content;
  },
)""",
    steps: ['Construye una Column', 'Combina Row y Expanded', 'Prueba Stack', 'Adapta la UI con LayoutBuilder'],
    challenge: 'Diseña una pantalla que use sidebar en escritorio y lista vertical en móvil.',
    keywords: ['row', 'column', 'stack', 'expanded', 'responsive'],
    accentValue: 0xFFE879F9,
  ),
  CourseSection(
    id: 'estado-reactividad',
    group: 'Estado',
    title: 'Estado y reactividad',
    level: 'Intermedio',
    description: 'Aprende setState, ValueNotifier y ChangeNotifier para separar estado y presentación.',
    whyItMatters: 'Una UI reactiva debe actualizar solo lo necesario y mantener una fuente de verdad clara.',
    code: r"""final contador = ValueNotifier<int>(0);

ValueListenableBuilder<int>(
  valueListenable: contador,
  builder: (_, value, __) => Text('$value'),
)""",
    steps: ['Empieza con setState', 'Extrae estado a ValueNotifier', 'Prueba ChangeNotifier', 'Separa lógica y widgets'],
    challenge: 'Implementa un contador y una lista de favoritos sin guardar estado directamente en cada tarjeta.',
    keywords: ['setstate', 'valuenotifier', 'changenotifier', 'reactividad'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'navegacion',
    group: 'Navegación',
    title: 'Rutas y navegación',
    level: 'Intermedio',
    description: 'Organiza pantallas, navegación hacia detalle y retorno de resultados usando Navigator.',
    whyItMatters: 'Las aplicaciones reales tienen flujos y pantallas relacionadas.',
    code: r"""final result = await Navigator.of(context).push<bool>(
  MaterialPageRoute(
    builder: (_) => const DetailPage(),
  ),
);""",
    steps: ['Crea una segunda pantalla', 'Navega con push', 'Regresa con pop', 'Pasa argumentos tipados'],
    challenge: 'Abre el detalle de un curso y devuelve true cuando el usuario lo complete.',
    keywords: ['navigator', 'rutas', 'push', 'pop', 'pantallas'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'formularios',
    group: 'Formularios',
    title: 'Formularios y validación',
    level: 'Intermedio',
    description: 'Construye formularios con TextFormField, Form, validadores y control de foco.',
    whyItMatters: 'Los formularios concentran entrada de datos, validación y accesibilidad.',
    code: r"""final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: TextFormField(
    validator: (value) =>
        value == null || value.isEmpty ? 'Campo requerido' : null,
  ),
)""",
    steps: ['Crea GlobalKey<FormState>', 'Añade TextFormField', 'Escribe validadores', 'Controla foco y envío'],
    challenge: 'Crea un formulario para añadir libros con título, autor y categoría.',
    keywords: ['form', 'textformfield', 'validator', 'focus'],
    accentValue: 0xFFF472B6,
  ),
  CourseSection(
    id: 'async-api',
    group: 'APIs',
    title: 'Async, HTTP y APIs',
    level: 'Intermedio',
    description: 'Modela estados de carga, éxito y error para datos remotos y separa la petición en un repositorio.',
    whyItMatters: 'La UI no debe conocer detalles de red. Separar acceso a datos facilita pruebas, caché y cambios de API.',
    code: r"""Future<void> cargar() async {
  loading = true;
  notifyListeners();
  try {
    items = await repository.obtenerCursos();
  } finally {
    loading = false;
    notifyListeners();
  }
}""",
    steps: ['Crea un modelo JSON', 'Crea un repositorio', 'Maneja loading y error', 'Renderiza datos remotos'],
    challenge: 'Consume una API pública y representa loading, error, vacío y éxito como estados distintos.',
    keywords: ['future', 'async', 'http', 'json', 'repository'],
    accentValue: 0xFF22D3EE,
  ),
  CourseSection(
    id: 'persistencia',
    group: 'Datos',
    title: 'Persistencia local',
    level: 'Intermedio',
    description: 'Guarda preferencias y progreso local con una capa de almacenamiento aislada de la UI.',
    whyItMatters: 'Favoritos, tema y progreso deben sobrevivir al reinicio de la app.',
    code: r"""final prefs = await SharedPreferences.getInstance();
await prefs.setStringList('completed', completed.toList());

final restored =
    (prefs.getStringList('completed') ?? const <String>[]).toSet();""",
    steps: ['Define las claves', 'Encapsula SharedPreferences', 'Restaura al iniciar', 'Guarda después de cada cambio'],
    challenge: 'Persiste favoritos y cursos completados y comprueba que se restauran al reiniciar.',
    keywords: ['sharedpreferences', 'persistencia', 'storage', 'favoritos'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'arquitectura',
    group: 'Arquitectura',
    title: 'Arquitectura por features',
    level: 'Avanzado',
    description: 'Separa modelos, datos, servicios y presentación para evitar un main.dart gigante.',
    whyItMatters: 'La estructura importa cuando el proyecto crece y reduce el acoplamiento.',
    code: r"""lib/
  data/
  models/
  screens/
  services/
  widgets/
  main.dart""",
    steps: ['Extrae modelos', 'Mueve datos estáticos', 'Aísla persistencia', 'Divide pantallas y widgets reutilizables'],
    challenge: 'Toma una pantalla monolítica y divídela en al menos cuatro piezas con responsabilidades claras.',
    keywords: ['arquitectura', 'features', 'clean code', 'separacion'],
    accentValue: 0xFFF97316,
  ),
  CourseSection(
    id: 'testing',
    group: 'Calidad',
    title: 'Testing y análisis estático',
    level: 'Avanzado',
    description: 'Combina flutter analyze, pruebas unitarias y widget tests para detectar regresiones.',
    whyItMatters: 'Las pruebas convierten comportamientos importantes en contratos verificables.',
    code: r"""test('los ids son únicos', () {
  final ids = courseCatalog.map((item) => item.id).toList();
  expect(ids.toSet().length, ids.length);
});""",
    steps: ['Activa flutter_lints', 'Escribe unit tests', 'Añade widget tests', 'Ejecuta pruebas en CI'],
    challenge: 'Añade una prueba que garantice que cada curso tenga reto, pasos y palabras clave.',
    keywords: ['test', 'flutter analyze', 'lint', 'ci'],
    accentValue: 0xFFFACC15,
  ),
  CourseSection(
    id: 'rendimiento',
    group: 'Rendimiento',
    title: 'Rendimiento y reconstrucciones',
    level: 'Avanzado',
    description: 'Reduce trabajo innecesario con widgets const, listas perezosas y estado granular.',
    whyItMatters: 'Reconstrucciones costosas y listas mal diseñadas degradan la experiencia.',
    code: r"""ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return CourseTile(item: items[index]);
  },
)""",
    steps: ['Usa const cuando aplique', 'Prefiere builders en listas grandes', 'Aísla estado cambiante', 'Mide antes de optimizar'],
    challenge: 'Convierte una lista de cientos de elementos en una lista perezosa y compara el comportamiento.',
    keywords: ['performance', 'const', 'listview builder', 'rebuild'],
    accentValue: 0xFFFB7185,
  ),
  CourseSection(
    id: 'accesibilidad',
    group: 'UI/UX',
    title: 'Accesibilidad y UX',
    level: 'Avanzado',
    description: 'Diseña controles con etiquetas claras, foco visible, objetivos táctiles adecuados y semántica comprensible.',
    whyItMatters: 'Una interfaz accesible mejora el producto para usuarios de teclado y lector de pantalla.',
    code: r"""Semantics(
  button: true,
  label: 'Marcar curso como favorito',
  child: IconButton(
    tooltip: 'Favorito',
    onPressed: toggleFavorite,
    icon: const Icon(Icons.star_border),
  ),
)""",
    steps: ['Añade tooltips', 'Revisa contraste', 'Prueba teclado', 'Usa Semantics cuando aporte contexto'],
    challenge: 'Recorre la app solo con teclado y corrige cualquier control que no pueda identificarse o accionarse.',
    keywords: ['accesibilidad', 'semantics', 'tooltip', 'teclado', 'ux'],
    accentValue: 0xFFC084FC,
  ),
];
