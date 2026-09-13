import '../../models/course_section.dart';

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
