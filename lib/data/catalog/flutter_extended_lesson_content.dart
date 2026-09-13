import '../../models/lesson_content.dart';

/// Contenido enriquecido de la segunda etapa de Flutter.
const flutterExtendedLessonContent = <String, LessonContent>{
  'flutter-widget-lifecycle': LessonContent(
    syntax: r'''@override
void initState() {
  super.initState();
  controller = ScrollController();
}

@override
void dispose() {
  controller.dispose();
  super.dispose();
}''',
    concepts: [
      'initState se ejecuta una sola vez cuando el State entra al árbol.',
      'build puede ejecutarse muchas veces y debe permanecer barato y declarativo.',
      'dispose es el lugar para liberar controllers, focus nodes, streams y listeners.',
      'mounted confirma que el State todavía pertenece al árbol antes de usar context después de await.',
    ],
    examples: [
      LessonExample(
        title: 'Carga segura después de await',
        explanation: 'Después de una operación asíncrona comprueba mounted antes de navegar o usar ScaffoldMessenger.',
        code: r'''Future<void> save() async {
  await repository.save();
  if (!mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Guardado')),
  );
}''',
      ),
      LessonExample(
        title: 'Liberar un controller',
        explanation: 'Todo recurso con ciclo de vida propio debe cerrarse cuando el State desaparece.',
        code: r'''late final TextEditingController nameController;

@override
void initState() {
  super.initState();
  nameController = TextEditingController();
}

@override
void dispose() {
  nameController.dispose();
  super.dispose();
}''',
      ),
    ],
    commonMistakes: [
      'Hacer peticiones o crear listeners en build y repetirlos en cada reconstrucción.',
      'Olvidar dispose en controllers y focus nodes.',
      'Usar context después de await sin comprobar mounted.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Controller con ciclo de vida',
        prompt: 'Crea un TextEditingController en initState y libéralo correctamente.',
        hint: 'Decláralo late final y llama dispose antes de super.dispose().',
      ),
      PracticeExercise(
        title: 'Carga cancelable por navegación',
        prompt: 'Simula una carga lenta y sal de la pantalla antes de que termine sin provocar excepciones.',
        hint: 'Comprueba mounted antes de tocar la UI.',
      ),
      PracticeExercise(
        title: 'Detectar rebuilds',
        prompt: 'Añade temporalmente un debugPrint en build y observa cuántas veces se ejecuta.',
        hint: 'Cambia estado local y modifica el tamaño de la ventana.',
      ),
    ],
  ),
  'flutter-lists-grids': LessonContent(
    syntax: r'''ListView.separated(
  itemCount: items.length,
  separatorBuilder: (_, __) => const Divider(height: 1),
  itemBuilder: (context, index) {
    final item = items[index];
    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.title),
    );
  },
)''',
    concepts: [
      'Los constructores builder crean elementos bajo demanda.',
      'Las keys ayudan a Flutter a conservar identidad cuando una lista cambia de orden.',
      'GridView puede adaptar el número de columnas al espacio disponible.',
      'La paginación o carga incremental evita traer y pintar colecciones enormes de una sola vez.',
    ],
    examples: [
      LessonExample(
        title: 'Lista con separadores',
        explanation: 'ListView.separated evita insertar divisores manualmente entre filas.',
        code: r'''ListView.separated(
  itemCount: books.length,
  separatorBuilder: (_, __) => const SizedBox(height: 8),
  itemBuilder: (_, index) => BookCard(book: books[index]),
)''',
      ),
      LessonExample(
        title: 'Grid adaptable',
        explanation: 'El máximo ancho de cada celda hace que Flutter calcule automáticamente cuántas columnas caben.',
        code: r'''GridView.builder(
  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 280,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
  ),
  itemCount: books.length,
  itemBuilder: (_, index) => BookCard(book: books[index]),
)''',
      ),
    ],
    commonMistakes: [
      'Usar Column con cientos de hijos dentro de SingleChildScrollView.',
      'Usar índices como identidad cuando los elementos pueden reordenarse.',
      'Fijar crossAxisCount sin considerar pantallas muy anchas o muy estrechas.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Lista de 500 elementos',
        prompt: 'Renderiza 500 registros con ListView.builder y confirma que el scroll sigue fluido.',
        hint: 'No crees los 500 widgets antes de pasarlos a la lista.',
      ),
      PracticeExercise(
        title: 'Vista adaptable',
        prompt: 'Muestra lista en móvil y grid en escritorio usando la misma fuente de datos.',
        hint: 'Combina LayoutBuilder con GridView.builder.',
      ),
      PracticeExercise(
        title: 'Reordenamiento estable',
        prompt: 'Ordena una colección por título y conserva correctamente el estado visual de cada fila.',
        hint: 'Usa ValueKey con un id estable.',
      ),
    ],
  ),
  'flutter-material3-theme': LessonContent(
    syntax: r'''final scheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0EA5E9),
  brightness: Brightness.light,
);

ThemeData(
  useMaterial3: true,
  colorScheme: scheme,
)''',
    concepts: [
      'ColorScheme expresa roles semánticos como primary, surface y error.',
      'ThemeData centraliza decisiones de diseño para toda la aplicación.',
      'Los componentes deben leer el tema en vez de repetir colores y estilos.',
      'Un tema oscuro correcto no es simplemente invertir blanco y negro.',
    ],
    examples: [
      LessonExample(
        title: 'Botón siguiendo el tema',
        explanation: 'FilledButton usa automáticamente los colores y estados definidos por Material.',
        code: r'''FilledButton.icon(
  onPressed: save,
  icon: const Icon(Icons.save),
  label: const Text('Guardar'),
)''',
      ),
      LessonExample(
        title: 'Superficie personalizada',
        explanation: 'Cuando necesitas un contenedor propio, usa roles del ColorScheme para mantener coherencia.',
        code: r'''final scheme = Theme.of(context).colorScheme;

Container(
  color: scheme.surfaceContainerLow,
  child: Text(
    'Resumen',
    style: TextStyle(color: scheme.onSurface),
  ),
)''',
      ),
    ],
    commonMistakes: [
      'Hardcodear colores distintos en cada widget.',
      'Usar primary para absolutamente todo y perder jerarquía.',
      'Diseñar solo en tema claro y descubrir problemas de contraste al final.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Tema claro y oscuro',
        prompt: 'Define dos ThemeData y permite alternarlos desde la app.',
        hint: 'Usa theme, darkTheme y themeMode en MaterialApp.',
      ),
      PracticeExercise(
        title: 'Eliminar colores directos',
        prompt: 'Refactoriza tres tarjetas para que lean ColorScheme.',
        hint: 'Busca Colors.* dentro de widgets de UI.',
      ),
      PracticeExercise(
        title: 'Componente temático',
        prompt: 'Configura globalmente InputDecorationTheme para evitar repetir bordes y radios.',
        hint: 'Hazlo desde ThemeData.',
      ),
    ],
  ),
  'flutter-animations': LessonContent(
    syntax: r'''AnimatedContainer(
  duration: const Duration(milliseconds: 220),
  curve: Curves.easeOut,
  padding: EdgeInsets.all(selected ? 20 : 12),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(selected ? 24 : 14),
  ),
  child: child,
)''',
    concepts: [
      'Las animaciones implícitas son la primera opción para cambios simples de propiedades.',
      'AnimatedSwitcher funciona muy bien para transiciones entre estados distintos.',
      'TweenAnimationBuilder interpola valores sin administrar manualmente un controller.',
      'AnimationController es apropiado cuando necesitas reproducir, revertir o sincronizar varias animaciones.',
    ],
    examples: [
      LessonExample(
        title: 'Tarjeta seleccionada',
        explanation: 'AnimatedContainer interpola automáticamente tamaño, color y radio al cambiar selected.',
        code: r'''AnimatedContainer(
  duration: const Duration(milliseconds: 180),
  margin: EdgeInsets.all(selected ? 4 : 10),
  child: CourseCard(selected: selected),
)''',
      ),
      LessonExample(
        title: 'Loading a contenido',
        explanation: 'Keys diferentes permiten que AnimatedSwitcher entienda que son dos estados visuales distintos.',
        code: r'''AnimatedSwitcher(
  duration: const Duration(milliseconds: 200),
  child: loading
      ? const CircularProgressIndicator(key: ValueKey('loading'))
      : CourseList(key: const ValueKey('content'), items: items),
)''',
      ),
    ],
    commonMistakes: [
      'Animar todo al mismo tiempo y dificultar la lectura de la interfaz.',
      'Crear AnimationController y olvidar dispose.',
      'Usar duraciones largas para interacciones que deberían sentirse inmediatas.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Selección suave',
        prompt: 'Anima color y borde de la tarjeta seleccionada.',
        hint: 'AnimatedContainer es suficiente.',
      ),
      PracticeExercise(
        title: 'Cambiar estado',
        prompt: 'Anima vacío → loading → resultados con AnimatedSwitcher.',
        hint: 'Cada estado necesita una key distinta.',
      ),
      PracticeExercise(
        title: 'Contador animado',
        prompt: 'Interpola un porcentaje de 0 a 100.',
        hint: 'Usa TweenAnimationBuilder<double>.',
      ),
    ],
  ),
  'flutter-gestures-focus': LessonContent(
    syntax: r'''InkWell(
  onTap: open,
  onLongPress: showActions,
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Abrir curso'),
  ),
)''',
    concepts: [
      'InkWell ofrece feedback Material para taps y debe preferirse en superficies Material.',
      'GestureDetector reconoce gestos sin añadir feedback visual automáticamente.',
      'Focus y FocusNode permiten controlar navegación con teclado.',
      'Una interacción accesible ofrece más de una forma de descubrir y ejecutar acciones importantes.',
    ],
    examples: [
      LessonExample(
        title: 'Tap con feedback Material',
        explanation: 'InkWell dibuja ripple y respeta el radio configurado.',
        code: r'''Material(
  borderRadius: BorderRadius.circular(16),
  child: InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: open,
    child: const Padding(
      padding: EdgeInsets.all(16),
      child: Text('Detalle'),
    ),
  ),
)''',
      ),
      LessonExample(
        title: 'Mover foco',
        explanation: 'TextInputAction permite que el teclado avance naturalmente entre campos.',
        code: r'''TextFormField(
  textInputAction: TextInputAction.next,
  onFieldSubmitted: (_) => nextFocus.requestFocus(),
)''',
      ),
    ],
    commonMistakes: [
      'Usar GestureDetector en un botón sin feedback, tooltip ni semántica.',
      'Crear FocusNode dentro de build.',
      'Hacer acciones disponibles solo con swipe o long press sin alternativa visible.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Tarjeta accesible',
        prompt: 'Haz una tarjeta accionable con mouse, touch y teclado.',
        hint: 'Combina Material, InkWell y Focus.',
      ),
      PracticeExercise(
        title: 'Formulario con foco',
        prompt: 'Haz que Next avance entre tres campos y Done envíe el formulario.',
        hint: 'Usa TextInputAction y FocusNode.',
      ),
      PracticeExercise(
        title: 'Acción alternativa',
        prompt: 'Si tienes una acción en long press, añade otra forma visible de ejecutarla.',
        hint: 'Un menú contextual o IconButton puede ser suficiente.',
      ),
    ],
  ),
  'flutter-feedback-overlays': LessonContent(
    syntax: r'''ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Cambios guardados'),
  ),
);''',
    concepts: [
      'El feedback debe corresponder a la importancia y duración del evento.',
      'SnackBar sirve para mensajes breves no bloqueantes.',
      'Dialog debe reservarse para decisiones que requieren atención inmediata.',
      'BottomSheet permite ampliar acciones o filtros sin abandonar el contexto actual.',
    ],
    examples: [
      LessonExample(
        title: 'Confirmación breve',
        explanation: 'Un guardado exitoso normalmente no necesita un modal.',
        code: r'''ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Libro guardado')),
);''',
      ),
      LessonExample(
        title: 'Acciones en bottom sheet',
        explanation: 'La hoja inferior funciona bien para filtros o acciones secundarias en móvil.',
        code: r'''showModalBottomSheet<void>(
  context: context,
  builder: (_) => const FilterSheet(),
);''',
      ),
    ],
    commonMistakes: [
      'Mostrar un AlertDialog por cada error menor.',
      'Cerrar automáticamente un mensaje antes de que pueda leerse.',
      'Ocultar errores de validación solo dentro de SnackBar y lejos del campo afectado.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Mapa de feedback',
        prompt: 'Clasifica cinco eventos de tu app como inline, SnackBar, Dialog o BottomSheet.',
        hint: 'Piensa si la acción bloquea o no el flujo.',
      ),
      PracticeExercise(
        title: 'Confirmar eliminación',
        prompt: 'Pide confirmación antes de eliminar un registro y devuelve bool desde el diálogo.',
        hint: 'Navigator.pop(context, true/false).',
      ),
      PracticeExercise(
        title: 'Filtros móviles',
        prompt: 'Mueve filtros secundarios a un modal bottom sheet.',
        hint: 'Mantén la selección actual al abrirlo.',
      ),
    ],
  ),
  'flutter-state-architecture': LessonContent(
    syntax: r'''abstract interface class BooksRepository {
  Future<List<Book>> all();
  Future<void> save(Book book);
}

class BooksController extends ChangeNotifier {
  BooksController(this.repository);
  final BooksRepository repository;
}''',
    concepts: [
      'La UI debería describir estados y enviar intenciones, no implementar acceso a datos.',
      'Un repositorio oculta si los datos vienen de red, memoria o almacenamiento local.',
      'Un controlador de feature coordina operaciones y expone estado consumible por la vista.',
      'La inyección de dependencias facilita pruebas y reemplazo de implementaciones.',
    ],
    examples: [
      LessonExample(
        title: 'Repositorio abstracto',
        explanation: 'La vista y el controlador dependen de un contrato, no de HTTP o SharedPreferences.',
        code: r'''abstract interface class CoursesRepository {
  Future<List<Course>> load();
}''',
      ),
      LessonExample(
        title: 'Estados explícitos',
        explanation: 'Loading, error y datos se exponen de manera clara para que la UI pueda decidir qué mostrar.',
        code: r'''bool loading = false;
Object? error;
List<Book> books = const [];

bool get isEmpty => !loading && error == null && books.isEmpty;''',
      ),
    ],
    commonMistakes: [
      'Poner HTTP, parsing, navegación y estado de pantalla en la misma clase.',
      'Crear repositorios directamente dentro de build.',
      'Usar una arquitectura muy compleja antes de que el problema lo necesite.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Extraer repositorio',
        prompt: 'Mueve una llamada de datos fuera de la pantalla a un repositorio.',
        hint: 'Empieza por una interfaz con load().',
      ),
      PracticeExercise(
        title: 'Controlador testeable',
        prompt: 'Inyecta un repositorio falso y prueba loading → data.',
        hint: 'No hagas new del repositorio real dentro del controlador.',
      ),
      PracticeExercise(
        title: 'Estado vacío',
        prompt: 'Diferencia visualmente lista vacía de error y de loading.',
        hint: 'Modela las condiciones por separado.',
      ),
    ],
  ),
  'flutter-offline-cache': LessonContent(
    syntax: r'''final cached = await local.read();

try {
  final fresh = await remote.fetch();
  await local.write(fresh);
  return fresh;
} catch (_) {
  if (cached.isNotEmpty) return cached;
  rethrow;
}''',
    concepts: [
      'Caché y fuente de verdad no siempre son lo mismo.',
      'Una estrategia cache-first puede mostrar contenido rápido y actualizar después.',
      'Los datos locales necesitan reglas de expiración o actualización.',
      'La UI debe distinguir datos antiguos disponibles de ausencia total de datos.',
    ],
    examples: [
      LessonExample(
        title: 'Fallback local',
        explanation: 'Si la red falla pero hay datos guardados, la app puede seguir siendo útil.',
        code: r'''try {
  return await api.fetchBooks();
} catch (_) {
  return await storage.readBooks();
}''',
      ),
      LessonExample(
        title: 'Marca de sincronización',
        explanation: 'Guardar la fecha de última actualización permite explicar al usuario la antigüedad de los datos.',
        code: r'''await prefs.setString(
  'last_sync',
  DateTime.now().toIso8601String(),
);''',
      ),
    ],
    commonMistakes: [
      'Tratar SharedPreferences como base de datos para información grande o relacional.',
      'Guardar caché sin estrategia de invalidez.',
      'Borrar datos locales útiles simplemente porque una petición remota falló.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Fallback de caché',
        prompt: 'Devuelve datos locales cuando una petición simulada falle.',
        hint: 'Captura la excepción en el repositorio.',
      ),
      PracticeExercise(
        title: 'Última sincronización',
        prompt: 'Muestra cuándo se actualizaron los datos por última vez.',
        hint: 'Guarda una fecha ISO junto a la caché.',
      ),
      PracticeExercise(
        title: 'Estado desactualizado',
        prompt: 'Muestra datos antiguos con una advertencia discreta en vez de una pantalla de error completa.',
        hint: 'Error con datos no es el mismo estado que error sin datos.',
      ),
    ],
  ),
};
