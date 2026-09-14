/// Ubicación exacta del código para cada paso de la ruta Flutter.
///
/// Complementa [progressiveAppPlan] con una explicación de qué responsabilidad
/// vive en cada archivo. Se mantiene separado para no convertir el plan de
/// tareas en un archivo todavía más grande.
const flutterCodePlacement = <String, Map<String, String>>{
  'flutter-intro': {
    'lib/main.dart': 'Déjalo como punto de entrada: importa app.dart y ejecuta runApp(const LibraryApp()).',
    'lib/app.dart': 'Define LibraryApp y MaterialApp. Aquí van theme, darkTheme, themeMode y la pantalla inicial.',
    'lib/screens/library_home_page.dart': 'Construye aquí el Scaffold, AppBar, body y FloatingActionButton de la pantalla principal.',
  },
  'widgets-layout': {
    'lib/widgets/library_summary.dart': 'Crea el resumen reutilizable con Row, Column, Expanded y textos de estadísticas.',
    'lib/widgets/category_card.dart': 'Define una tarjeta reutilizable para una categoría; evita lógica de navegación o almacenamiento aquí.',
    'lib/screens/library_home_page.dart': 'Usa LayoutBuilder para decidir si muestras una composición compacta o ancha y ensambla los widgets anteriores.',
  },
  'estado-reactividad': {
    'lib/models/book.dart': 'Define el modelo Book con id, title, author, category y favorite. Mantén este archivo sin widgets.',
    'lib/controllers/library_controller.dart': 'Guarda la lista de libros y métodos como addBook() y toggleFavorite(); llama notifyListeners() después de cada cambio.',
    'lib/widgets/book_card.dart': 'Dibuja un Book y expón callbacks para favorito o apertura; no modifiques la lista directamente desde la tarjeta.',
    'lib/app.dart': 'Crea o inyecta la instancia del controlador que compartirá la aplicación.',
    'lib/screens/library_home_page.dart': 'Escucha el controlador y transforma su estado en lista, contador y favoritos visibles.',
  },
  'navegacion': {
    'lib/screens/book_detail_page.dart': 'Construye la pantalla de detalle y recibe Book por constructor.',
    'lib/widgets/book_card.dart': 'Desde onTap usa Navigator.push para abrir BookDetailPage con el libro seleccionado.',
    'lib/screens/library_home_page.dart': 'Mantén aquí la lista y cualquier resultado que deba procesarse al volver del detalle.',
  },
  'formularios': {
    'lib/screens/book_form_page.dart': 'Crea el Scaffold de la pantalla de alta y aloja BookForm.',
    'lib/widgets/book_form.dart': 'Coloca GlobalKey<FormState>, TextFormField, validadores, controladores y el botón de guardar.',
    'lib/controllers/library_controller.dart': 'Implementa addBook() y cualquier validación de negocio que no pertenezca al widget.',
    'lib/screens/library_home_page.dart': 'Haz que el FloatingActionButton abra BookFormPage y refresque el listado al guardar.',
  },
  'async-api': {
    'lib/services/books_api_service.dart': 'Coloca únicamente la petición HTTP y la respuesta cruda de la API.',
    'lib/repositories/books_repository.dart': 'Convierte la respuesta remota en modelos Book y expón una API limpia a la capa de estado.',
    'lib/controllers/library_controller.dart': 'Modela loading, error, empty y data y llama al repositorio desde métodos async.',
    'lib/widgets/recommendations_section.dart': 'Representa visualmente los cuatro estados sin contener código HTTP.',
    'lib/screens/library_home_page.dart': 'Inserta RecommendationsSection dentro del inicio.',
  },
  'persistencia': {
    'lib/services/local_storage_service.dart': 'Encapsula SharedPreferences: claves, lectura y escritura viven aquí.',
    'lib/controllers/library_controller.dart': 'Restaura datos al iniciar y delega guardado al servicio después de cada cambio persistente.',
    'lib/app.dart': 'Inicializa dependencias antes de construir la UI si la restauración necesita ser asíncrona.',
  },
  'arquitectura': {
    'lib/features/books/data/': 'Mueve aquí servicios, data sources y repositorios concretos relacionados con libros.',
    'lib/features/books/presentation/': 'Mueve aquí screens, widgets y controllers de la feature.',
    'lib/app.dart': 'Conserva composición global, tema e inyección de dependencias; evita lógica específica de libros.',
  },
  'testing': {
    'test/library_controller_test.dart': 'Prueba lógica de estado sin construir la UI.',
    'test/book_form_test.dart': 'Escribe widget tests del formulario, validaciones y envío.',
    'test/library_home_page_test.dart': 'Comprueba que la pantalla principal renderiza datos y acciones críticas.',
  },
  'rendimiento': {
    'lib/features/books/presentation/widgets/book_list.dart': 'Implementa ListView.builder o GridView.builder y usa keys estables.',
    'lib/features/books/presentation/widgets/book_card.dart': 'Mantén la tarjeta pequeña, const cuando sea posible y sin cálculos costosos en build().',
    'lib/features/books/presentation/screens/library_home_page.dart': 'Usa BookList como única responsable de renderizar colecciones grandes.',
  },
  'accesibilidad': {
    'lib/features/books/presentation/widgets/book_card.dart': 'Añade Semantics, tooltips y áreas táctiles claras a acciones basadas en iconos.',
    'lib/features/books/presentation/widgets/book_form.dart': 'Configura labels, focusNode, textInputAction y mensajes de error comprensibles.',
    'lib/features/books/presentation/screens/library_home_page.dart': 'Revisa orden de foco y navegación por teclado a nivel de pantalla.',
  },
  'flutter-widget-lifecycle': {
    'lib/features/books/presentation/screens/reading_session_page.dart': 'Crea un StatefulWidget; inicializa controllers/listeners en initState, verifica mounted tras await y libera recursos en dispose.',
    'lib/features/books/presentation/screens/book_detail_page.dart': 'Añade la acción que abre ReadingSessionPage.',
  },
  'flutter-lists-grids': {
    'lib/features/books/presentation/widgets/book_grid.dart': 'Implementa GridView.builder y calcula columnas según el ancho disponible.',
    'lib/features/books/presentation/widgets/view_mode_selector.dart': 'Crea el selector lista/grid como widget pequeño que emite el modo elegido.',
    'lib/features/books/presentation/screens/library_home_page.dart': 'Guarda el modo de vista y elige BookList o BookGrid sin duplicar BookCard.',
  },
  'flutter-material3-theme': {
    'lib/theme/app_theme.dart': 'Define ThemeData claro y oscuro, ColorScheme y estilos globales de componentes.',
    'lib/app.dart': 'Asigna theme, darkTheme y themeMode al MaterialApp.',
    'widgets con colores hardcodeados': 'Reemplaza colores literales por Theme.of(context).colorScheme o extensiones del tema.',
  },
  'flutter-animations': {
    'lib/features/books/presentation/widgets/animated_book_card.dart': 'Encapsula animaciones de selección o expansión que necesiten reutilización.',
    'lib/features/books/presentation/widgets/book_card.dart': 'Usa AnimatedSwitcher o AnimatedContainer para cambios pequeños como favorito/selección.',
    'lib/features/books/presentation/screens/library_home_page.dart': 'Anima la transición entre loading, error y contenido, no la lógica de carga.',
  },
  'flutter-gestures-focus': {
    'lib/features/books/presentation/widgets/library_shortcuts.dart': 'Declara Shortcuts, Actions y Focus para navegación por teclado.',
    'lib/features/books/presentation/widgets/book_card.dart': 'Usa InkWell para tap y foco visible; reserva GestureDetector para gestos específicos.',
    'lib/features/books/presentation/screens/library_home_page.dart': 'Coordina la selección actual y envuelve la colección con la capa de atajos.',
  },
  'flutter-feedback-overlays': {
    'lib/features/books/presentation/widgets/book_actions_sheet.dart': 'Define el contenido del BottomSheet de acciones secundarias.',
    'lib/features/books/presentation/screens/book_detail_page.dart': 'Muestra AlertDialog para acciones destructivas y devuelve la decisión.',
    'lib/features/books/presentation/screens/library_home_page.dart': 'Usa ScaffoldMessenger para SnackBar y abre el sheet de filtros/acciones.',
  },
  'flutter-state-architecture': {
    'lib/features/books/domain/books_repository.dart': 'Declara la abstracción que necesita la capa de presentación; no importes implementaciones concretas.',
    'lib/features/books/data/books_repository_impl.dart': 'Implementa el contrato combinando fuentes locales/remotas.',
    'lib/features/books/presentation/controllers/library_controller.dart': 'Depende de BooksRepository por constructor y expone estado listo para la UI.',
    'lib/app.dart': 'Construye las implementaciones concretas e inyéctalas en el controlador.',
  },
  'flutter-offline-cache': {
    'lib/features/books/data/local/books_local_data_source.dart': 'Lee y guarda la versión local/caché del catálogo.',
    'lib/features/books/data/remote/books_remote_data_source.dart': 'Realiza la petición de red y devuelve modelos remotos o DTOs.',
    'lib/features/books/data/sync/books_sync_service.dart': 'Coordina actualización, timestamps y decisiones de sincronización.',
    'lib/features/books/data/books_repository_impl.dart': 'Decide cuándo devolver caché, consultar red y actualizar almacenamiento local.',
    'lib/features/books/presentation/controllers/library_controller.dart': 'Expone estado online/offline y sincronización sin conocer detalles de almacenamiento.',
  },
};
