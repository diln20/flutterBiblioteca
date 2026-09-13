import '../../models/course_section.dart';

/// Segunda etapa de Flutter: temas que aparecen cuando una app deja de ser
/// una demo y empieza a comportarse como un producto real.
const flutterExtendedCatalog = <CourseSection>[
  CourseSection(
    id: 'flutter-widget-lifecycle',
    group: 'Flutter',
    title: 'Ciclo de vida, State y BuildContext',
    level: 'Intermedio',
    description:
        'Entiende initState, didUpdateWidget, dispose, mounted y cuándo BuildContext es seguro para navegar, mostrar diálogos o leer dependencias.',
    whyItMatters:
        'Muchos errores difíciles de Flutter nacen de ejecutar lógica demasiado pronto, demasiado tarde o con un context que ya no pertenece a un widget montado.',
    code: r'''class DetailState extends State<DetailPage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  Future<void> load() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Datos cargados')),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}''',
    steps: [
      'Diferencia creación del State, initState, build y dispose.',
      'Identifica recursos que deben liberarse como controllers y listeners.',
      'Comprueba mounted después de operaciones asíncronas antes de usar context.',
      'Usa didUpdateWidget cuando una configuración externa cambia y debes reaccionar.',
    ],
    challenge:
        'Crea una pantalla que cargue datos al iniciar, use ScrollController y no produzca errores aunque el usuario salga antes de terminar la carga.',
    keywords: ['lifecycle', 'initstate', 'dispose', 'buildcontext', 'mounted'],
    accentValue: 0xFF38BDF8,
  ),
  CourseSection(
    id: 'flutter-lists-grids',
    group: 'UI',
    title: 'Listas, grids y contenido grande',
    level: 'Intermedio',
    description:
        'Construye listas y cuadrículas eficientes con ListView.builder, GridView, separators, keys y carga incremental.',
    whyItMatters:
        'Las interfaces reales muestran catálogos, mensajes, productos o cursos. Renderizar cientos de widgets de golpe desperdicia memoria y empeora el desplazamiento.',
    code: r'''GridView.builder(
  padding: const EdgeInsets.all(16),
  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 320,
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
    childAspectRatio: 1.2,
  ),
  itemCount: courses.length,
  itemBuilder: (context, index) {
    final course = courses[index];
    return CourseCard(
      key: ValueKey(course.id),
      course: course,
    );
  },
)''',
    steps: [
      'Empieza con ListView.builder para crear solo elementos visibles.',
      'Añade separadores sin envolver cada fila manualmente.',
      'Convierte la vista en GridView cuando el ancho lo permita.',
      'Usa keys estables si el orden de los elementos puede cambiar.',
    ],
    challenge:
        'Crea un catálogo que use una columna en móvil, dos en tablet y tres o más en escritorio sin duplicar el widget de tarjeta.',
    keywords: ['listview', 'gridview', 'builder', 'keys', 'lazy list'],
    accentValue: 0xFFE879F9,
  ),
  CourseSection(
    id: 'flutter-material3-theme',
    group: 'UI/UX',
    title: 'Material 3, temas y sistema visual',
    level: 'Intermedio',
    description:
        'Centraliza color, tipografía, superficies, componentes y modo claro/oscuro con ThemeData y ColorScheme.',
    whyItMatters:
        'Un sistema visual coherente evita estilos repetidos y permite cambiar la identidad completa de la app desde un punto central.',
    code: r'''final scheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0EA5E9),
  brightness: Brightness.dark,
);

MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    cardTheme: const CardThemeData(elevation: 0),
  ),
)''',
    steps: [
      'Define un ColorScheme en vez de colores aislados por pantalla.',
      'Configura ThemeData para botones, cards, inputs y chips.',
      'Lee Theme.of(context) dentro de widgets reutilizables.',
      'Prueba contraste y jerarquía tanto en modo claro como oscuro.',
    ],
    challenge:
        'Crea dos temas completos para la biblioteca y consigue que ninguna tarjeta necesite colores de fondo hardcodeados.',
    keywords: ['material 3', 'themedata', 'colorscheme', 'dark mode', 'design system'],
    accentValue: 0xFFC084FC,
  ),
  CourseSection(
    id: 'flutter-animations',
    group: 'Animaciones',
    title: 'Animaciones implícitas y explícitas',
    level: 'Intermedio',
    description:
        'Aprende cuándo usar AnimatedContainer, AnimatedSwitcher, TweenAnimationBuilder y AnimationController.',
    whyItMatters:
        'El movimiento ayuda a explicar cambios de estado, jerarquía y navegación. Debe aportar información, no convertirse en decoración que ralentiza la interfaz.',
    code: r'''AnimatedSwitcher(
  duration: const Duration(milliseconds: 240),
  child: loading
      ? const CircularProgressIndicator(key: ValueKey('loading'))
      : Text(
          '$total resultados',
          key: const ValueKey('result'),
        ),
)''',
    steps: [
      'Empieza por AnimatedContainer y AnimatedOpacity para cambios simples.',
      'Usa AnimatedSwitcher cuando cambia el widget representado.',
      'Prueba TweenAnimationBuilder cuando necesitas interpolar un valor.',
      'Reserva AnimationController para secuencias que necesitan control fino.',
    ],
    challenge:
        'Anima la selección de una tarjeta, el cambio entre loading y contenido y la aparición de un panel de filtros sin bloquear interacción.',
    keywords: ['animation', 'animatedcontainer', 'animatedswitcher', 'tween', 'animationcontroller'],
    accentValue: 0xFFFB7185,
  ),
  CourseSection(
    id: 'flutter-gestures-focus',
    group: 'Interacción',
    title: 'Gestos, teclado y foco',
    level: 'Intermedio',
    description:
        'Diseña interacción con InkWell, GestureDetector, FocusNode, Shortcuts y acciones de teclado sin sacrificar accesibilidad.',
    whyItMatters:
        'Flutter se ejecuta en móvil, web y escritorio. Una interfaz robusta no puede depender únicamente de tocar la pantalla.',
    code: r'''Focus(
  autofocus: true,
  onKeyEvent: (node, event) {
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      openSelected();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  },
  child: InkWell(
    onTap: openSelected,
    child: const CourseTile(),
  ),
)''',
    steps: [
      'Usa InkWell para superficies Material que necesitan feedback visual.',
      'Usa GestureDetector solo cuando necesitas reconocer gestos más específicos.',
      'Controla el foco en formularios y navegación por teclado.',
      'Comprueba que las acciones importantes también tengan tooltip o semántica.',
    ],
    challenge:
        'Permite recorrer la lista de cursos con teclado, abrir el seleccionado con Enter y seguir funcionando correctamente con mouse o touch.',
    keywords: ['gestures', 'inkwell', 'focusnode', 'keyboard', 'shortcuts'],
    accentValue: 0xFFF59E0B,
  ),
  CourseSection(
    id: 'flutter-feedback-overlays',
    group: 'UX',
    title: 'SnackBars, diálogos, sheets y feedback',
    level: 'Intermedio',
    description:
        'Comunica éxito, error, confirmaciones y acciones secundarias con SnackBar, Dialog, BottomSheet y estados inline.',
    whyItMatters:
        'La aplicación debe explicar qué ocurrió después de cada acción sin interrumpir al usuario más de lo necesario.',
    code: r'''final confirmed = await showDialog<bool>(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Eliminar libro'),
    content: const Text('Esta acción no se puede deshacer.'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: const Text('Cancelar'),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, true),
        child: const Text('Eliminar'),
      ),
    ],
  ),
);''',
    steps: [
      'Usa feedback inline para errores que deben permanecer visibles.',
      'Usa SnackBar para confirmaciones breves que no bloquean.',
      'Usa Dialog cuando el usuario debe tomar una decisión antes de continuar.',
      'Usa BottomSheet para acciones o filtros relacionados con la pantalla actual.',
    ],
    challenge:
        'Añade confirmar eliminación, aviso de guardado, error inline y un bottom sheet de filtros a una misma pantalla sin abusar de diálogos.',
    keywords: ['snackbar', 'dialog', 'bottomsheet', 'feedback', 'overlay'],
    accentValue: 0xFFF472B6,
  ),
  CourseSection(
    id: 'flutter-state-architecture',
    group: 'Estado',
    title: 'Arquitectura de estado por feature',
    level: 'Avanzado',
    description:
        'Separa estado de vista, lógica de negocio, repositorios y modelos para que una feature pueda crecer sin convertir el controlador en un objeto gigante.',
    whyItMatters:
        'El problema no es elegir una librería de estado; es definir responsabilidades, dependencias y límites claros entre UI, lógica y datos.',
    code: r'''class BooksController extends ChangeNotifier {
  BooksController(this.repository);

  final BooksRepository repository;
  List<Book> books = const [];
  bool loading = false;
  Object? error;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      books = await repository.all();
    } catch (value) {
      error = value;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}''',
    steps: [
      'Define qué estado pertenece únicamente a la vista y cuál a la feature.',
      'Aísla fuentes de datos detrás de repositorios.',
      'Modela loading, data, empty y error explícitamente.',
      'Inyecta dependencias en vez de crearlas dentro del widget.',
    ],
    challenge:
        'Refactoriza una pantalla que carga, filtra y guarda libros para que la UI no importe SharedPreferences ni conozca detalles de red.',
    keywords: ['state architecture', 'repository', 'controller', 'dependency injection', 'feature'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'flutter-offline-cache',
    group: 'Datos',
    title: 'Offline, caché y sincronización',
    level: 'Avanzado',
    description:
        'Diseña una estrategia donde los datos locales permitan abrir la app rápido y la red actualice la información cuando esté disponible.',
    whyItMatters:
        'Una buena experiencia no debería depender de una conexión perfecta. Caché y sincronización también reducen esperas y llamadas innecesarias.',
    code: r'''Future<List<Book>> loadBooks() async {
  final cached = await local.readBooks();

  try {
    final remoteBooks = await remote.fetchBooks();
    await local.saveBooks(remoteBooks);
    return remoteBooks;
  } catch (_) {
    if (cached.isNotEmpty) return cached;
    rethrow;
  }
}''',
    steps: [
      'Define qué datos necesitan persistencia real y cuáles son solo caché.',
      'Carga primero una versión local cuando mejore el tiempo de respuesta.',
      'Actualiza desde red y reemplaza la caché de forma controlada.',
      'Diferencia error sin datos de error con datos antiguos disponibles.',
    ],
    challenge:
        'Construye una lista que abra con datos guardados, muestre cuándo están desactualizados y se sincronice al recuperar conexión.',
    keywords: ['offline', 'cache', 'sync', 'local data', 'repository'],
    accentValue: 0xFF2DD4BF,
  ),
];
