import '../../models/lesson_content.dart';

/// Contenido extendido de la etapa Flutter.
/// Cada lección añade sintaxis, ejemplos, errores comunes y ejercicios.
const flutterLessonContent = <String, LessonContent>{
  'flutter-intro': LessonContent(
    syntax: r'''void main() {
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
}''',
    concepts: [
      'Flutter describe la interfaz mediante un árbol de widgets inmutables.',
      'runApp() conecta el widget raíz con el motor de Flutter.',
      'build() transforma estado y configuración en una descripción de UI.',
      'BuildContext identifica la posición de un widget dentro del árbol.',
    ],
    examples: [
      LessonExample(
        title: 'Pantalla mínima con Material',
        explanation: 'MaterialApp configura la aplicación y Scaffold aporta la estructura visual básica de una pantalla.',
        code: r'''class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: Center(child: Text('Mi primera pantalla')),
    );
  }
}''',
      ),
      LessonExample(
        title: 'Composición de widgets',
        explanation: 'En vez de dibujar manualmente cada elemento, compones widgets pequeños para construir otros más grandes.',
        code: r'''Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: const [
        Icon(Icons.school),
        SizedBox(width: 12),
        Text('Curso de Flutter'),
      ],
    ),
  ),
)''',
      ),
    ],
    commonMistakes: [
      'Poner toda la aplicación dentro de main.dart en lugar de extraer pantallas y widgets.',
      'Crear objetos mutables dentro de build() sin necesidad y perder claridad sobre el estado.',
      'Usar BuildContext después de una operación async sin comprobar que el widget siga montado.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Hola Flutter personalizado',
        prompt: 'Crea una pantalla con AppBar, icono, título, subtítulo y un botón.',
        hint: 'Empieza con Scaffold y usa Column dentro de Center.',
      ),
      PracticeExercise(
        title: 'Extraer un widget',
        prompt: 'Convierte una tarjeta repetida en un StatelessWidget reutilizable.',
        hint: 'Pasa título e icono por el constructor.',
      ),
      PracticeExercise(
        title: 'Leer el árbol',
        prompt: 'Dibuja en texto la jerarquía de widgets de tu pantalla principal.',
        hint: 'Empieza por MaterialApp y baja hasta los widgets de texto.',
      ),
    ],
  ),
  'widgets-layout': LessonContent(
    syntax: r'''LayoutBuilder(
  builder: (context, constraints) {
    final desktop = constraints.maxWidth >= 900;

    return desktop
        ? Row(
            children: [
              const SizedBox(width: 280, child: Sidebar()),
              Expanded(child: Content()),
            ],
          )
        : const Content();
  },
)''',
    concepts: [
      'Row distribuye hijos horizontalmente y Column verticalmente.',
      'Expanded ocupa el espacio restante dentro de Row, Column o Flex.',
      'Flexible permite ceder espacio sin obligar al hijo a llenarlo por completo.',
      'LayoutBuilder permite decidir la composición según el espacio disponible, no según un dispositivo específico.',
    ],
    examples: [
      LessonExample(
        title: 'Dos columnas adaptables',
        explanation: 'La tarjeta izquierda mantiene un ancho estable y el contenido aprovecha el resto.',
        code: r'''Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const SizedBox(width: 240, child: MenuPanel()),
    const SizedBox(width: 16),
    const Expanded(child: CourseList()),
  ],
)''',
      ),
      LessonExample(
        title: 'Cambio de diseño por ancho',
        explanation: 'En pantallas pequeñas la UI cambia de Row a Column sin consultar la plataforma.',
        code: r'''LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return const Column(children: [Summary(), Details()]);
    }
    return const Row(
      children: [
        Expanded(child: Summary()),
        Expanded(child: Details()),
      ],
    );
  },
)''',
      ),
    ],
    commonMistakes: [
      'Usar anchos fijos grandes que generan overflow en móviles.',
      'Anidar Expanded fuera de Row, Column o Flex.',
      'Basar el responsive únicamente en Platform.isAndroid o Platform.isIOS.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Sidebar responsive',
        prompt: 'Muestra un sidebar a partir de 900 px y reemplázalo por una lista simple en móvil.',
        hint: 'Usa LayoutBuilder y constraints.maxWidth.',
      ),
      PracticeExercise(
        title: 'Tarjetas fluidas',
        prompt: 'Construye una cuadrícula que muestre más columnas cuando aumenta el ancho.',
        hint: 'Prueba GridView y SliverGridDelegateWithMaxCrossAxisExtent.',
      ),
      PracticeExercise(
        title: 'Eliminar overflow',
        prompt: 'Busca un Row con textos largos y corrígelo para que no desborde.',
        hint: 'Expanded, Flexible y TextOverflow son tus herramientas principales.',
      ),
    ],
  ),
  'estado-reactividad': LessonContent(
    syntax: r'''class CounterController extends ChangeNotifier {
  int value = 0;

  void increment() {
    value++;
    notifyListeners();
  }
}

AnimatedBuilder(
  animation: controller,
  builder: (_, __) => Text('${controller.value}'),
)''',
    concepts: [
      'El estado es información que puede cambiar y afectar lo que se renderiza.',
      'setState es apropiado para estado local y pequeño de un StatefulWidget.',
      'ValueNotifier funciona bien cuando una sola pieza de estado necesita notificar cambios.',
      'ChangeNotifier permite agrupar lógica y estado fuera de la vista.',
    ],
    examples: [
      LessonExample(
        title: 'Estado local con setState',
        explanation: 'Para un contador aislado, StatefulWidget y setState son suficientes.',
        code: r'''int count = 0;

FilledButton(
  onPressed: () {
    setState(() => count++);
  },
  child: Text('Clicks: $count'),
)''',
      ),
      LessonExample(
        title: 'Estado extraído a ValueNotifier',
        explanation: 'La vista escucha el valor y se reconstruye solo donde se usa ValueListenableBuilder.',
        code: r'''final selectedId = ValueNotifier<String?>(null);

ValueListenableBuilder<String?>(
  valueListenable: selectedId,
  builder: (_, value, __) {
    return Text(value ?? 'Sin selección');
  },
)''',
      ),
    ],
    commonMistakes: [
      'Duplicar el mismo estado en varios widgets y provocar inconsistencias.',
      'Llamar notifyListeners() antes de cambiar los datos o demasiadas veces en una sola operación.',
      'Usar una solución de estado global para información puramente visual y local.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Contador local',
        prompt: 'Implementa incremento, decremento y reinicio con setState.',
        hint: 'Mantén count dentro del State.',
      ),
      PracticeExercise(
        title: 'Favoritos',
        prompt: 'Mueve un Set de favoritos a un ChangeNotifier y actualiza la lista desde el controlador.',
        hint: 'Crea toggleFavorite(id) y llama notifyListeners().',
      ),
      PracticeExercise(
        title: 'Estado derivado',
        prompt: 'Calcula un porcentaje de progreso a partir de elementos completados sin guardarlo por separado.',
        hint: 'Crea un getter en el controlador.',
      ),
    ],
  ),
  'navegacion': LessonContent(
    syntax: r'''Navigator.of(context).push(
  MaterialPageRoute<void>(
    builder: (_) => const DetailPage(),
  ),
);

Navigator.of(context).pop();''',
    concepts: [
      'Navigator administra una pila de rutas: push agrega una pantalla y pop regresa.',
      'MaterialPageRoute crea una transición de navegación compatible con Material.',
      'Una ruta puede recibir datos por constructor y devolver un resultado tipado.',
      'La navegación debe reflejar el flujo real del producto, no convertirse en lógica de negocio.',
    ],
    examples: [
      LessonExample(
        title: 'Abrir un detalle con datos',
        explanation: 'La pantalla recibe el id seleccionado a través de su constructor.',
        code: r'''Navigator.of(context).push(
  MaterialPageRoute<void>(
    builder: (_) => BookDetailPage(bookId: book.id),
  ),
);''',
      ),
      LessonExample(
        title: 'Esperar un resultado',
        explanation: 'push<T> permite esperar un valor enviado por pop.',
        code: r'''final saved = await Navigator.of(context).push<bool>(
  MaterialPageRoute(builder: (_) => const EditorPage()),
);

if (saved == true && context.mounted) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Guardado')),
  );
}''',
      ),
    ],
    commonMistakes: [
      'Usar context después de await sin verificar context.mounted.',
      'Pasar objetos enormes o estado mutable compartido entre rutas sin una estrategia clara.',
      'Llamar push repetidamente desde build() y crear múltiples pantallas involuntarias.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Lista y detalle',
        prompt: 'Abre una pantalla de detalle al tocar un curso y muestra el título recibido.',
        hint: 'Pasa el CourseSection por constructor o usa su id.',
      ),
      PracticeExercise(
        title: 'Resultado de edición',
        prompt: 'Haz que una pantalla de edición devuelva true al guardar y false al cancelar.',
        hint: 'Usa Navigator.pop(context, true).',
      ),
      PracticeExercise(
        title: 'Navegación segura',
        prompt: 'Añade una operación async antes de mostrar un SnackBar sin generar warnings de BuildContext.',
        hint: 'Comprueba context.mounted después del await.',
      ),
    ],
  ),
  'formularios': LessonContent(
    syntax: r'''final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: TextFormField(
    decoration: const InputDecoration(labelText: 'Título'),
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Campo requerido';
      }
      return null;
    },
  ),
)''',
    concepts: [
      'Form agrupa campos y permite validar el conjunto desde un GlobalKey<FormState>.',
      'TextFormField integra entrada, decoración y validación.',
      'Los controladores deben liberarse con dispose() cuando pertenecen a un State.',
      'La validación debe explicar cómo corregir el dato, no solo indicar que algo falló.',
    ],
    examples: [
      LessonExample(
        title: 'Validar antes de guardar',
        explanation: 'El botón consulta el estado del formulario y continúa solo cuando todos los validadores pasan.',
        code: r'''FilledButton(
  onPressed: () {
    final valid = formKey.currentState?.validate() ?? false;
    if (!valid) return;
    // Guardar datos.
  },
  child: const Text('Guardar'),
)''',
      ),
      LessonExample(
        title: 'Controlador de texto',
        explanation: 'TextEditingController permite leer y modificar el contenido de un campo.',
        code: r'''final titleController = TextEditingController();

TextFormField(
  controller: titleController,
  textInputAction: TextInputAction.next,
  decoration: const InputDecoration(labelText: 'Título'),
)''',
      ),
    ],
    commonMistakes: [
      'Crear TextEditingController dentro de build() y perder el texto en reconstrucciones.',
      'Validar solo al enviar sin dar información clara cerca del campo incorrecto.',
      'No configurar keyboardType, textInputAction o autofillHints cuando mejoran la entrada.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Formulario de libro',
        prompt: 'Crea campos para título, autor y año con validación específica.',
        hint: 'El año puede validarse con int.tryParse().',
      ),
      PracticeExercise(
        title: 'Mover foco',
        prompt: 'Configura Next en los primeros campos y Done en el último.',
        hint: 'Usa textInputAction.',
      ),
      PracticeExercise(
        title: 'Mensajes útiles',
        prompt: 'Reescribe tres validaciones genéricas para que expliquen exactamente qué debe corregirse.',
        hint: 'Evita mensajes como Error o Dato inválido.',
      ),
    ],
  ),
  'async-api': LessonContent(
    syntax: r'''Future<List<Course>> loadCourses() async {
  final response = await client.get(uri);

  if (response.statusCode != 200) {
    throw Exception('No se pudieron cargar los cursos');
  }

  final data = jsonDecode(response.body) as List<dynamic>;
  return data.map(Course.fromJson).toList();
}''',
    concepts: [
      'Future representa un resultado que estará disponible más adelante.',
      'La capa de datos debe traducir HTTP y JSON a modelos usados por la aplicación.',
      'La UI necesita distinguir carga, éxito, vacío y error.',
      'Separar un repositorio permite sustituir la API por un fake durante pruebas.',
    ],
    examples: [
      LessonExample(
        title: 'Estado de carga explícito',
        explanation: 'El controlador expone loading y error sin obligar al widget a conocer detalles HTTP.',
        code: r'''Future<void> refresh() async {
  loading = true;
  error = null;
  notifyListeners();

  try {
    courses = await repository.fetchCourses();
  } catch (exception) {
    error = exception.toString();
  } finally {
    loading = false;
    notifyListeners();
  }
}''',
      ),
      LessonExample(
        title: 'Renderizar estados',
        explanation: 'Cada estado visual tiene una salida clara y verificable.',
        code: r'''if (controller.loading) {
  return const Center(child: CircularProgressIndicator());
}
if (controller.error != null) {
  return ErrorView(message: controller.error!);
}
if (controller.courses.isEmpty) {
  return const EmptyView();
}
return CourseList(items: controller.courses);''',
      ),
    ],
    commonMistakes: [
      'Hacer peticiones directamente desde build() y repetirlas en cada reconstrucción.',
      'Capturar errores sin mostrar una opción de reintento o contexto útil.',
      'Confiar en dynamic para todo el JSON en lugar de convertirlo a modelos tipados.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Modelo desde JSON',
        prompt: 'Crea un modelo Course con fromJson y datos mínimos de una API.',
        hint: 'Convierte explícitamente id, title y description.',
      ),
      PracticeExercise(
        title: 'Cuatro estados',
        prompt: 'Implementa loading, error, vacío y lista con datos.',
        hint: 'Haz que cada estado se pueda provocar durante pruebas.',
      ),
      PracticeExercise(
        title: 'Repositorio fake',
        prompt: 'Sustituye la red por un repositorio que devuelva datos locales con Future.delayed.',
        hint: 'Define una interfaz o una clase base con fetchCourses().',
      ),
    ],
  ),
  'persistencia': LessonContent(
    syntax: r'''final preferences = await SharedPreferences.getInstance();

await preferences.setStringList(
  'completed',
  completed.toList(),
);

final restored =
    (preferences.getStringList('completed') ?? const <String>[]).toSet();''',
    concepts: [
      'SharedPreferences sirve para preferencias y datos pequeños de tipo clave-valor.',
      'La UI no debería conocer las claves ni detalles de almacenamiento.',
      'La restauración debe validar que los ids guardados todavía existan.',
      'Persistir después de cada cambio importante evita perder progreso al cerrar la app.',
    ],
    examples: [
      LessonExample(
        title: 'Servicio de preferencias',
        explanation: 'Un servicio concentra las claves y deja al controlador trabajar con tipos del dominio.',
        code: r'''class ProgressStore {
  static const completedKey = 'completed';

  Future<Set<String>> loadCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(completedKey) ?? const <String>[])
        .toSet();
  }
}''',
      ),
      LessonExample(
        title: 'Filtrar datos obsoletos',
        explanation: 'Al restaurar, conserva únicamente ids que siguen presentes en el catálogo actual.',
        code: r'''final validIds = catalog.map((item) => item.id).toSet();
completed
  ..clear()
  ..addAll(savedCompleted.where(validIds.contains));''',
      ),
    ],
    commonMistakes: [
      'Guardar información sensible en SharedPreferences como si fuera almacenamiento seguro.',
      'Repartir strings de claves por toda la aplicación y provocar errores difíciles de detectar.',
      'Restaurar ids antiguos sin comprobar si el catálogo cambió.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Persistir favoritos',
        prompt: 'Guarda y restaura un Set<String> de ids favoritos.',
        hint: 'Convierte el Set a List para setStringList.',
      ),
      PracticeExercise(
        title: 'Última sección',
        prompt: 'Guarda el id de la última lección abierta y restáurala al iniciar.',
        hint: 'Usa setString y getString.',
      ),
      PracticeExercise(
        title: 'Datos válidos',
        prompt: 'Simula la eliminación de un curso y evita que un id antiguo rompa la restauración.',
        hint: 'Interseca los ids guardados con los ids actuales.',
      ),
    ],
  ),
  'arquitectura': LessonContent(
    syntax: r'''lib/
  data/
    catalog/
  models/
  screens/
  services/
  widgets/
  app.dart
  main.dart''',
    concepts: [
      'Separar responsabilidades reduce el acoplamiento y facilita encontrar cada cambio.',
      'Los modelos describen datos; los servicios concentran lógica o infraestructura; los widgets presentan UI.',
      'Una pantalla coordina piezas, pero no debería convertirse en un archivo monolítico.',
      'La estructura debe crecer por necesidad real y no por copiar una arquitectura excesivamente compleja.',
    ],
    examples: [
      LessonExample(
        title: 'Extraer persistencia',
        explanation: 'El controlador delega el almacenamiento y queda libre de detalles de SharedPreferences.',
        code: r'''class LibraryController extends ChangeNotifier {
  LibraryController(this.store);

  final ProgressStore store;

  Future<void> save() async {
    await store.save(completed: completed);
  }
}''',
      ),
      LessonExample(
        title: 'Componer catálogos',
        explanation: 'Cada dominio mantiene su propio archivo y course_catalog.dart solo define el orden de la ruta.',
        code: r'''const courseCatalog = <CourseSection>[
  ...dartBasicsCatalog,
  ...flutterCatalog,
];''',
      ),
    ],
    commonMistakes: [
      'Crear carpetas sin una responsabilidad clara y obligar a saltar entre demasiados archivos.',
      'Permitir que widgets lean directamente preferencias, red y base de datos.',
      'Mantener un único archivo de miles de líneas porque todavía compila.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Dividir pantalla',
        prompt: 'Separa una pantalla con filtros, lista y detalle en tres widgets con entradas claras.',
        hint: 'La pantalla debe seguir coordinando el estado.',
      ),
      PracticeExercise(
        title: 'Extraer servicio',
        prompt: 'Mueve el almacenamiento de favoritos fuera del widget y del controlador visual.',
        hint: 'Define un ProgressStore o FavoritesStore.',
      ),
      PracticeExercise(
        title: 'Revisar dependencias',
        prompt: 'Dibuja qué capas importan a cuáles y elimina una dependencia circular o innecesaria.',
        hint: 'Los modelos deberían ser fáciles de reutilizar.',
      ),
    ],
  ),
  'testing': LessonContent(
    syntax: r'''test('los ids del catálogo son únicos', () {
  final ids = courseCatalog.map((item) => item.id).toList();
  expect(ids.toSet().length, ids.length);
});

// También ejecuta:
// flutter analyze
// flutter test''',
    concepts: [
      'flutter analyze detecta problemas estáticos y reglas de lint antes de ejecutar la app.',
      'Los unit tests validan lógica aislada con rapidez.',
      'Los widget tests verifican interacción y renderizado sin levantar una app completa en un dispositivo.',
      'CI ejecuta los mismos contratos automáticamente en cada cambio.',
    ],
    examples: [
      LessonExample(
        title: 'Contrato del catálogo',
        explanation: 'Una prueba de datos evita introducir cursos vacíos o ids duplicados.',
        code: r'''for (final section in courseCatalog) {
  expect(section.title.trim(), isNotEmpty);
  expect(section.steps.length, greaterThanOrEqualTo(3));
  expect(section.challenge.trim(), isNotEmpty);
}''',
      ),
      LessonExample(
        title: 'Widget test pequeño',
        explanation: 'pumpWidget construye el widget y find comprueba que el contenido esperado esté presente.',
        code: r'''testWidgets('muestra el título', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(home: Text('Biblioteca Flutter')),
  );

  expect(find.text('Biblioteca Flutter'), findsOneWidget);
});''',
      ),
    ],
    commonMistakes: [
      'Probar detalles internos en vez de comportamiento observable.',
      'Depender de red o tiempo real en unit tests que deberían ser deterministas.',
      'Ignorar warnings del analizador porque la aplicación parece funcionar.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Ids únicos',
        prompt: 'Escribe una prueba que falle si dos lecciones usan el mismo id.',
        hint: 'Compara length con toSet().length.',
      ),
      PracticeExercise(
        title: 'Cobertura de contenido',
        prompt: 'Verifica que cada lección tenga ejemplos, errores y ejercicios.',
        hint: 'Recorre el catálogo y busca su LessonContent por id.',
      ),
      PracticeExercise(
        title: 'Prueba de favorito',
        prompt: 'Haz un widget test que toque una estrella y compruebe el cambio visible.',
        hint: 'Usa tester.tap y pump().',
      ),
    ],
  ),
  'rendimiento': LessonContent(
    syntax: r'''ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return CourseTile(item: items[index]);
  },
)

const SizedBox(height: 12);''',
    concepts: [
      'const permite reutilizar instancias de widgets inmutables cuando sus argumentos también son constantes.',
      'ListView.builder crea elementos bajo demanda y evita construir listas enormes de una vez.',
      'El estado debe estar lo más cerca posible de los widgets que realmente dependen de él.',
      'DevTools ayuda a medir antes de decidir qué optimizar.',
    ],
    examples: [
      LessonExample(
        title: 'Lista perezosa',
        explanation: 'builder crea solo los elementos requeridos por el viewport y sus alrededores.',
        code: r'''ListView.builder(
  itemCount: courses.length,
  itemBuilder: (_, index) {
    return CourseTile(course: courses[index]);
  },
)''',
      ),
      LessonExample(
        title: 'Aislar una zona reactiva',
        explanation: 'Solo el texto que depende del ValueNotifier se reconstruye cuando cambia el contador.',
        code: r'''ValueListenableBuilder<int>(
  valueListenable: counter,
  builder: (_, value, __) {
    return Text('Total: $value');
  },
)''',
      ),
    ],
    commonMistakes: [
      'Optimizar prematuramente sin medir dónde existe un problema real.',
      'Reemplazar listas pequeñas por soluciones complejas solo para reducir rebuilds irrelevantes.',
      'Construir cientos de widgets en children: cuando ListView.builder resolvería el caso.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Lista grande',
        prompt: 'Renderiza 1000 elementos con ListView.builder y evita crear una lista de widgets manualmente.',
        hint: 'Genera los datos, no los widgets.',
      ),
      PracticeExercise(
        title: 'Agregar const',
        prompt: 'Revisa una pantalla y marca como const todos los widgets que puedan ser constantes.',
        hint: 'El analizador suele sugerir varios casos.',
      ),
      PracticeExercise(
        title: 'Medir reconstrucciones',
        prompt: 'Mueve un estado global a una zona más pequeña y observa qué parte de la UI deja de reconstruirse.',
        hint: 'Separa el widget que realmente escucha el cambio.',
      ),
    ],
  ),
  'accesibilidad': LessonContent(
    syntax: r'''Semantics(
  button: true,
  label: 'Marcar curso como favorito',
  child: IconButton(
    tooltip: 'Favorito',
    onPressed: toggleFavorite,
    icon: const Icon(Icons.star_border),
  ),
)''',
    concepts: [
      'Semantics aporta información adicional cuando la apariencia visual no comunica suficiente contexto.',
      'Tooltip ayuda a identificar acciones representadas únicamente por iconos.',
      'El contraste, tamaño táctil y orden de foco forman parte de la usabilidad, no son extras.',
      'Una app debe poder recorrerse con teclado en escritorio y web.',
    ],
    examples: [
      LessonExample(
        title: 'Botón con intención clara',
        explanation: 'Tooltip y Semantics describen la misma acción para diferentes formas de interacción.',
        code: r'''Semantics(
  label: 'Eliminar libro de favoritos',
  button: true,
  child: IconButton(
    tooltip: 'Quitar de favoritos',
    onPressed: onRemove,
    icon: const Icon(Icons.star),
  ),
)''',
      ),
      LessonExample(
        title: 'Campo comprensible',
        explanation: 'Un label persistente es más claro que depender únicamente de un hint temporal.',
        code: r'''TextFormField(
  decoration: const InputDecoration(
    labelText: 'Correo electrónico',
    hintText: 'nombre@ejemplo.com',
  ),
  keyboardType: TextInputType.emailAddress,
  autofillHints: const [AutofillHints.email],
)''',
      ),
    ],
    commonMistakes: [
      'Usar IconButton sin tooltip cuando el icono puede resultar ambiguo.',
      'Depender solo del color para expresar error, éxito o selección.',
      'Crear controles táctiles demasiado pequeños o sin espacio suficiente entre acciones.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Recorrido por teclado',
        prompt: 'Usa Tab y Shift+Tab para recorrer toda la pantalla y corrige controles inaccesibles.',
        hint: 'Comprueba también que el foco sea visible.',
      ),
      PracticeExercise(
        title: 'Iconos con nombre',
        prompt: 'Añade tooltips a todas las acciones que solo muestran un icono.',
        hint: 'El texto debe expresar la acción, no describir la forma del icono.',
      ),
      PracticeExercise(
        title: 'No depender del color',
        prompt: 'Añade un segundo indicador para estados seleccionado, completado y error.',
        hint: 'Usa texto, iconos o formas además del color.',
      ),
    ],
  ),
};
