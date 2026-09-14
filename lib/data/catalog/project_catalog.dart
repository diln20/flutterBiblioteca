import '../../models/course_section.dart';
import '../../models/guided_build_step.dart';
import '../../models/lesson_content.dart';

const projectCatalog = <CourseSection>[
  CourseSection(
    id: 'project-01-task-manager',
    group: 'Proyectos Flutter',
    title: 'Proyecto 1 · Gestor de tareas',
    level: 'Principiante',
    description: 'Construye una app CRUD sencilla con lista, formulario, filtros y persistencia local.',
    whyItMatters: 'Integra widgets, formularios, estado y almacenamiento en una aplicación pequeña pero completa.',
    code: r'''class TaskController extends ChangeNotifier {
  final List<TaskItem> tasks = [];

  void add(TaskItem task) {
    tasks.add(task);
    notifyListeners();
  }

  void toggle(int index) {
    tasks[index] = tasks[index].copyWith(done: !tasks[index].done);
    notifyListeners();
  }
}''',
    steps: [
      'Crea el modelo TaskItem y una lista inicial.',
      'Construye pantalla de lista y formulario para nuevas tareas.',
      'Extrae el estado a un ChangeNotifier.',
      'Añade filtro por pendientes y completadas.',
      'Persiste las tareas localmente y restaura al iniciar.',
    ],
    challenge: 'Añade prioridades, fecha límite y una vista de tareas vencidas.',
    keywords: ['proyecto', 'crud', 'tareas', 'formularios', 'estado', 'persistencia'],
    accentValue: 0xFF22C55E,
  ),
  CourseSection(
    id: 'project-02-book-library',
    group: 'Proyectos Flutter',
    title: 'Proyecto 2 · Biblioteca personal',
    level: 'Intermedio',
    description: 'Crea una biblioteca de libros con búsqueda, favoritos, progreso de lectura y diseño responsive.',
    whyItMatters: 'Practica una arquitectura parecida a esta biblioteca educativa con datos, filtros y navegación de detalle.',
    code: r'''class LibraryController extends ChangeNotifier {
  final List<Book> books = [];
  final Set<String> favorites = {};

  List<Book> search(String query) {
    final value = query.trim().toLowerCase();
    return books.where((book) {
      return book.title.toLowerCase().contains(value) ||
          book.author.toLowerCase().contains(value);
    }).toList();
  }
}''',
    steps: [
      'Define Book, ReadingStatus y datos de ejemplo.',
      'Crea búsqueda, categorías y favoritos.',
      'Añade pantalla de detalle y edición.',
      'Adapta la interfaz a móvil y escritorio.',
      'Guarda favoritos y progreso de lectura.',
    ],
    challenge: 'Añade estadísticas por género y porcentaje de libros terminados.',
    keywords: ['biblioteca', 'busqueda', 'favoritos', 'responsive', 'navegacion'],
    accentValue: 0xFF0EA5E9,
  ),
  CourseSection(
    id: 'project-03-weather-api',
    group: 'Proyectos Flutter',
    title: 'Proyecto 3 · Clima con API',
    level: 'Intermedio',
    description: 'Consume una API de clima y representa carga, error, búsqueda de ciudad y resultados recientes.',
    whyItMatters: 'Combina red, JSON, async, estados de UI y separación mediante repositorio.',
    code: r'''Future<void> loadWeather(String city) async {
  loading = true;
  error = null;
  notifyListeners();

  try {
    weather = await repository.fetchWeather(city);
  } catch (exception) {
    error = exception.toString();
  } finally {
    loading = false;
    notifyListeners();
  }
}''',
    steps: [
      'Crea el modelo Weather y su conversión desde JSON.',
      'Aísla la petición en WeatherRepository.',
      'Implementa loading, error, vacío y éxito.',
      'Añade búsqueda de ciudades y últimas consultas.',
      'Escribe pruebas usando un repositorio falso.',
    ],
    challenge: 'Añade pronóstico de varios días y caché de la última respuesta válida.',
    keywords: ['api', 'http', 'json', 'async', 'repository', 'testing'],
    accentValue: 0xFF06B6D4,
  ),
  CourseSection(
    id: 'project-04-final-app',
    group: 'Proyectos Flutter',
    title: 'Proyecto final · App Flutter completa',
    level: 'Avanzado',
    description: 'Integra arquitectura, autenticación simulada, API, persistencia, accesibilidad, tests y CI.',
    whyItMatters: 'Es el cierre de la ruta: pasar de ejercicios aislados a un producto mantenible y verificable.',
    code: r'''lib/
  app/
  features/
    auth/
    catalog/
    favorites/
  shared/
    data/
    widgets/
  main.dart''',
    steps: [
      'Define el problema, alcance y flujo de pantallas.',
      'Organiza la aplicación por features y responsabilidades.',
      'Conecta datos remotos y almacenamiento local.',
      'Añade estados de carga, error, vacío y recuperación.',
      'Escribe unit tests, widget tests y ejecuta flutter analyze.',
      'Publica la versión web mediante GitHub Actions.',
    ],
    challenge: 'Entrega una app desplegada con README técnico, pruebas y una lista de decisiones de arquitectura.',
    keywords: ['proyecto final', 'arquitectura', 'api', 'persistencia', 'testing', 'ci', 'deploy'],
    accentValue: 0xFFA855F7,
  ),
];

/// Guía de archivos para los cuatro proyectos independientes de cierre.
const projectBuildPlan = <String, GuidedBuildStep>{
  'project-01-task-manager': GuidedBuildStep(
    number: 1,
    total: 4,
    title: 'Construye un gestor de tareas completo',
    goal: 'Crear una app CRUD pequeña que reúna modelo, estado, formulario, filtros y persistencia local.',
    createFiles: [
      'lib/models/task_item.dart',
      'lib/controllers/task_controller.dart',
      'lib/screens/task_list_page.dart',
      'lib/screens/task_form_page.dart',
      'lib/widgets/task_tile.dart',
      'lib/services/task_storage_service.dart',
    ],
    modifyFiles: ['lib/main.dart', 'lib/app.dart', 'pubspec.yaml'],
    commands: [
      'flutter create gestor_tareas',
      'cd gestor_tareas',
      'flutter pub add shared_preferences',
      'flutter run',
    ],
    codePlacement: {
      'lib/models/task_item.dart': 'Define TaskItem con id, title, done, priority y dueDate opcional; añade copyWith para cambios inmutables.',
      'lib/controllers/task_controller.dart': 'Guarda la lista, filtros y métodos add, toggle y remove; notifica cambios desde aquí.',
      'lib/screens/task_list_page.dart': 'Construye el Scaffold principal, filtros y lista de TaskTile.',
      'lib/screens/task_form_page.dart': 'Coloca el Form para crear o editar tareas y devuelve el resultado al controlador.',
      'lib/widgets/task_tile.dart': 'Representa una tarea individual con checkbox, prioridad y acciones.',
      'lib/services/task_storage_service.dart': 'Encapsula SharedPreferences y serialización local.',
      'lib/app.dart': 'Configura MaterialApp, tema y TaskListPage como home.',
    },
    tasks: [
      'Crea el modelo y datos de prueba antes de conectar persistencia.',
      'Implementa alta, completado y eliminación desde TaskController.',
      'Añade formulario validado y filtros de todas/pendientes/completadas.',
      'Persiste el estado y restáuralo al reiniciar.',
      'Prueba una tarea vencida y otra completada para verificar filtros.',
    ],
    expectedResult: 'Una app de tareas funcional que permite crear, completar, filtrar y conservar tareas entre reinicios.',
    checkpoint: 'Cierra y abre la app: las tareas y su estado deben mantenerse y ningún widget debe acceder directamente al almacenamiento.',
  ),
  'project-02-book-library': GuidedBuildStep(
    number: 2,
    total: 4,
    title: 'Construye una biblioteca personal',
    goal: 'Crear una app responsive con catálogo, búsqueda, favoritos, detalle y progreso de lectura.',
    createFiles: [
      'lib/models/book.dart',
      'lib/models/reading_status.dart',
      'lib/controllers/library_controller.dart',
      'lib/screens/library_page.dart',
      'lib/screens/book_detail_page.dart',
      'lib/widgets/book_card.dart',
      'lib/widgets/library_filters.dart',
      'lib/services/library_storage_service.dart',
    ],
    modifyFiles: ['lib/main.dart', 'lib/app.dart', 'pubspec.yaml'],
    commands: [
      'flutter create biblioteca_personal',
      'cd biblioteca_personal',
      'flutter pub add shared_preferences',
      'flutter run',
    ],
    codePlacement: {
      'lib/models/book.dart': 'Modela id, title, author, category, progress y favorite sin dependencias de UI.',
      'lib/models/reading_status.dart': 'Define el enum pendiente, leyendo y terminado.',
      'lib/controllers/library_controller.dart': 'Centraliza búsqueda, filtros, favoritos y progreso de lectura.',
      'lib/screens/library_page.dart': 'Compone buscador, filtros y catálogo responsive.',
      'lib/screens/book_detail_page.dart': 'Muestra detalle y acciones de favorito/progreso.',
      'lib/widgets/book_card.dart': 'Crea la tarjeta reutilizable para lista y grid.',
      'lib/widgets/library_filters.dart': 'Aísla chips, búsqueda y selector de estado.',
      'lib/services/library_storage_service.dart': 'Guarda favoritos, progreso y preferencias de vista.',
    },
    tasks: [
      'Carga al menos ocho libros de ejemplo con varias categorías.',
      'Implementa búsqueda por título/autor y filtros por categoría/estado.',
      'Abre una pantalla de detalle y permite cambiar favorito y progreso.',
      'Adapta lista/grid usando LayoutBuilder o ancho disponible.',
      'Persiste favoritos y progreso y verifica restauración.',
    ],
    expectedResult: 'Una biblioteca personal responsive con búsqueda, detalle, favoritos y progreso persistente.',
    checkpoint: 'Busca, filtra, abre un libro, cambia su progreso, reinicia y confirma que el estado siga correcto.',
  ),
  'project-03-weather-api': GuidedBuildStep(
    number: 3,
    total: 4,
    title: 'Construye una app de clima con API',
    goal: 'Practicar HTTP, JSON, estados async, repositorio y pruebas con dependencias falsas.',
    createFiles: [
      'lib/models/weather.dart',
      'lib/data/weather_api_client.dart',
      'lib/repositories/weather_repository.dart',
      'lib/controllers/weather_controller.dart',
      'lib/screens/weather_page.dart',
      'lib/widgets/weather_card.dart',
      'lib/widgets/weather_search.dart',
      'test/weather_controller_test.dart',
    ],
    modifyFiles: ['lib/main.dart', 'lib/app.dart', 'pubspec.yaml'],
    commands: [
      'flutter create clima_api',
      'cd clima_api',
      'flutter pub add http',
      'flutter run',
    ],
    codePlacement: {
      'lib/models/weather.dart': 'Convierte JSON a un modelo tipado Weather y evita que la UI lea mapas dinámicos.',
      'lib/data/weather_api_client.dart': 'Realiza la petición HTTP, arma URL/query y valida statusCode.',
      'lib/repositories/weather_repository.dart': 'Expone fetchWeather(city) y traduce la respuesta del cliente a dominio.',
      'lib/controllers/weather_controller.dart': 'Modela idle/loading/data/empty/error y conserva búsquedas recientes.',
      'lib/screens/weather_page.dart': 'Orquesta buscador, estados y resultados sin ejecutar HTTP directamente.',
      'lib/widgets/weather_card.dart': 'Presenta temperatura, condición y datos principales.',
      'test/weather_controller_test.dart': 'Usa un repositorio falso para comprobar éxito y error sin conexión real.',
    },
    tasks: [
      'Conecta una API pública o un endpoint configurable y modela su JSON.',
      'Implementa búsqueda de ciudad y estados loading/error/éxito.',
      'Guarda las últimas consultas en memoria o almacenamiento local.',
      'Añade un repositorio falso y pruebas para carga exitosa y fallo.',
      'Comprueba que una respuesta inválida no rompa la UI.',
    ],
    expectedResult: 'Una app que busca clima por ciudad, explica el estado de la petición y puede probarse sin llamar a la API real.',
    checkpoint: 'Ejecuta flutter analyze y flutter test, luego prueba una ciudad válida y otra inexistente.',
  ),
  'project-04-final-app': GuidedBuildStep(
    number: 4,
    total: 4,
    title: 'Entrega una aplicación Flutter completa',
    goal: 'Cerrar la ruta construyendo un producto organizado por features con datos remotos/locales, pruebas, accesibilidad y despliegue web.',
    createFiles: [
      'lib/app/app.dart',
      'lib/features/auth/',
      'lib/features/catalog/',
      'lib/features/favorites/',
      'lib/shared/data/',
      'lib/shared/widgets/',
      'test/',
      '.github/workflows/flutter.yml',
    ],
    modifyFiles: ['lib/main.dart', 'pubspec.yaml', 'README.md'],
    commands: [
      'flutter create app_final',
      'cd app_final',
      'flutter analyze',
      'flutter test',
      'flutter build web',
    ],
    codePlacement: {
      'lib/main.dart': 'Déjalo como bootstrap: inicializa dependencias necesarias y ejecuta la aplicación.',
      'lib/app/app.dart': 'Configura MaterialApp, tema, navegación y dependencias globales.',
      'lib/features/auth/': 'Agrupa modelos, data y presentation de autenticación.',
      'lib/features/catalog/': 'Agrupa listado, detalle, repositorio, controller y datos del catálogo.',
      'lib/features/favorites/': 'Aísla favoritos si tienen lógica o estado propio.',
      'lib/shared/data/': 'Coloca almacenamiento, cliente HTTP o caché transversal.',
      'lib/shared/widgets/': 'Guarda widgets realmente reutilizables entre features.',
      'test/': 'Añade unit tests y widget tests de los flujos más importantes.',
      '.github/workflows/flutter.yml': 'Automatiza pub get, analyze, test y build web.',
      'README.md': 'Documenta instalación, arquitectura, pruebas y enlace desplegado.',
    },
    tasks: [
      'Define alcance y flujo de pantallas antes de programar.',
      'Organiza el código por features con límites claros.',
      'Integra al menos una fuente remota y una persistencia local.',
      'Incluye loading, error, vacío, retry y funcionamiento accesible.',
      'Escribe pruebas de lógica y UI y deja CI en verde.',
      'Construye y publica la versión web y documenta el proyecto.',
    ],
    expectedResult: 'Una aplicación mantenible, probada y desplegada que demuestre el recorrido completo de la biblioteca de aprendizaje.',
    checkpoint: 'La entrega está lista cuando analyze, test y build web pasan, el README permite reproducirla y existe una URL funcional.',
  ),
};

const projectLessonContent = <String, LessonContent>{
  'project-01-task-manager': LessonContent(
    syntax: r'''class TaskItem {
  const TaskItem({required this.id, required this.title, this.done = false});
  final String id;
  final String title;
  final bool done;
}''',
    concepts: [
      'Separar modelo, estado, pantallas, widgets y persistencia.',
      'Crear un flujo CRUD con validación de formulario.',
      'Filtrar la misma colección sin duplicar datos.',
      'Restaurar el estado al iniciar la aplicación.',
    ],
    examples: [
      LessonExample(
        title: 'Cambiar una tarea',
        explanation: 'El controlador modifica el estado y notifica a la interfaz.',
        code: r'''void toggle(String id) {
  final index = tasks.indexWhere((task) => task.id == id);
  tasks[index] = tasks[index].copyWith(done: !tasks[index].done);
  notifyListeners();
}''',
      ),
      LessonExample(
        title: 'Filtrar pendientes',
        explanation: 'Deriva la vista desde la lista original en vez de mantener otra lista sincronizada.',
        code: r'''List<TaskItem> get pending =>
    tasks.where((task) => !task.done).toList();''',
      ),
    ],
    commonMistakes: [
      'Guardar estado directamente dentro de cada TaskTile.',
      'Mezclar SharedPreferences con la lógica de los widgets.',
      'Mantener listas separadas de pendientes y completadas que pueden quedar desincronizadas.',
    ],
    exercises: [
      PracticeExercise(title: 'Prioridades', prompt: 'Añade prioridad baja, media y alta y muéstrala visualmente.', hint: 'Usa enum y un campo en TaskItem.'),
      PracticeExercise(title: 'Tareas vencidas', prompt: 'Crea un filtro que muestre tareas no completadas cuya fecha ya pasó.', hint: 'Compara dueDate con DateTime.now().'),
      PracticeExercise(title: 'Edición', prompt: 'Permite abrir una tarea existente en el mismo formulario para editarla.', hint: 'Inicializa los controllers con los valores actuales.'),
    ],
  ),
  'project-02-book-library': LessonContent(
    syntax: r'''enum ReadingStatus { pending, reading, finished }

class Book {
  const Book({required this.id, required this.title, required this.author});
  final String id;
  final String title;
  final String author;
}''',
    concepts: [
      'Modelar catálogo, estado de lectura y favoritos.',
      'Combinar búsqueda y filtros sobre una misma fuente de verdad.',
      'Reutilizar BookCard en lista y cuadrícula.',
      'Mantener navegación y persistencia separadas de la UI.',
    ],
    examples: [
      LessonExample(
        title: 'Búsqueda normalizada',
        explanation: 'Normaliza consulta y campos para evitar diferencias por mayúsculas.',
        code: r'''List<Book> search(String query) {
  final q = query.trim().toLowerCase();
  return books.where((book) =>
    book.title.toLowerCase().contains(q) ||
    book.author.toLowerCase().contains(q),
  ).toList();
}''',
      ),
      LessonExample(
        title: 'Detalle tipado',
        explanation: 'Pasa el objeto seleccionado directamente a la pantalla de detalle.',
        code: r'''Navigator.of(context).push(
  MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
);''',
      ),
    ],
    commonMistakes: [
      'Duplicar BookCard para móvil y escritorio.',
      'Guardar favoritos por índice en vez de usar ids estables.',
      'Aplicar búsqueda y filtros en widgets distintos sin una fuente de verdad común.',
    ],
    exercises: [
      PracticeExercise(title: 'Estadísticas', prompt: 'Calcula cuántos libros están pendientes, leyendo y terminados.'),
      PracticeExercise(title: 'Ordenamiento', prompt: 'Permite ordenar por título, autor o progreso.', hint: 'Trabaja sobre una copia antes de sort().'),
      PracticeExercise(title: 'Responsive', prompt: 'Usa una columna en móvil y varias columnas al aumentar el ancho.'),
    ],
  ),
  'project-03-weather-api': LessonContent(
    syntax: r'''Future<Weather> fetchWeather(String city) async {
  final response = await client.get(buildUri(city));
  if (response.statusCode != 200) {
    throw Exception('No se pudo cargar el clima');
  }
  return Weather.fromJson(jsonDecode(response.body));
}''',
    concepts: [
      'Separar cliente HTTP, repositorio, controlador y presentación.',
      'Modelar JSON antes de llevar datos a la UI.',
      'Representar loading, error, vacío y éxito explícitamente.',
      'Probar el controlador con un repositorio falso.',
    ],
    examples: [
      LessonExample(
        title: 'Estado de carga',
        explanation: 'Activa loading antes de esperar la red y restáuralo en finally.',
        code: r'''loading = true;
notifyListeners();
try {
  weather = await repository.fetchWeather(city);
} finally {
  loading = false;
  notifyListeners();
}''',
      ),
      LessonExample(
        title: 'Repositorio falso',
        explanation: 'Las pruebas no necesitan conexión real si la dependencia puede sustituirse.',
        code: r'''class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(String city) async => sampleWeather;
}''',
      ),
    ],
    commonMistakes: [
      'Hacer la petición HTTP directamente dentro de build().',
      'Usar Map<String, dynamic> por toda la interfaz en lugar de un modelo.',
      'Mostrar un spinner indefinido cuando ocurre una excepción.',
    ],
    exercises: [
      PracticeExercise(title: 'Reintentar', prompt: 'Añade un botón de retry cuando la consulta falle.'),
      PracticeExercise(title: 'Recientes', prompt: 'Guarda las últimas cinco ciudades consultadas y permite repetir una búsqueda.'),
      PracticeExercise(title: 'Pronóstico', prompt: 'Extiende el modelo para presentar varios días sin mezclar parsing con widgets.'),
    ],
  ),
  'project-04-final-app': LessonContent(
    syntax: r'''lib/
  app/
  features/
    auth/
      data/
      domain/
      presentation/
    catalog/
      data/
      domain/
      presentation/
  shared/
    data/
    widgets/''',
    concepts: [
      'Definir alcance y arquitectura antes de crecer el código.',
      'Separar features y dependencias transversales.',
      'Diseñar estados de error, recuperación y funcionamiento offline.',
      'Automatizar análisis, pruebas y build en integración continua.',
    ],
    examples: [
      LessonExample(
        title: 'Inyección desde la raíz',
        explanation: 'La composición de implementaciones concretas ocurre fuera de la pantalla.',
        code: r'''final repository = CatalogRepositoryImpl(remote, local);
final controller = CatalogController(repository);
runApp(App(controller: controller));''',
      ),
      LessonExample(
        title: 'Pipeline mínimo',
        explanation: 'Cada push debe verificar calidad antes del despliegue.',
        code: r'''flutter pub get
flutter analyze
flutter test
flutter build web''',
      ),
    ],
    commonMistakes: [
      'Crear carpetas por arquitectura sin límites claros entre responsabilidades.',
      'Dejar claves, URLs sensibles o configuración secreta directamente en el repositorio.',
      'Publicar sin probar estados de error, accesibilidad y tamaños de pantalla diferentes.',
    ],
    exercises: [
      PracticeExercise(title: 'Diagrama', prompt: 'Dibuja el flujo UI → controller → repository → data source de una feature.'),
      PracticeExercise(title: 'CI', prompt: 'Configura un workflow que falle si analyze, test o build web fallan.'),
      PracticeExercise(title: 'README', prompt: 'Documenta arquitectura, comandos, decisiones, capturas y URL desplegada.'),
    ],
  ),
};
