# Flutter Biblioteca

Biblioteca interactiva para estudiar **Dart y Flutter** mediante una ruta progresiva, explicaciones, imágenes representativas, código de referencia, pasos guiados, ejemplos, errores comunes, ejercicios, retos y proyectos completos.

La interfaz toma como referencia la biblioteca HTML original: conserva navegación por áreas, búsqueda, favoritos, progreso persistente y diseño responsive, pero está implementada completamente con widgets Flutter.

## Enfoque de aprendizaje

La ruta está organizada para que el estudiante **aprenda y construya al mismo tiempo**. Cada sección indica qué hacer, qué archivo crear o modificar, dónde ubicar el código y cómo comprobar el resultado.

### Etapa 1 · Dart básico

Son 19 lecciones que construyen progresivamente una **biblioteca de consola**:

1. Qué es Dart y primer programa.
2. Variables, `var`, `final` y `const`.
3. Tipos de datos: `int`, `double`, `num`, `String`, `bool`, `Object` y `dynamic`.
4. Operadores aritméticos, relacionales, lógicos y ternarios.
5. Strings e interpolación.
6. Conversión de tipos y entrada por consola.
7. Condicionales: `if`, `else if` y `else`.
8. `switch` y `enum`.
9. Bucles: `for`, `for-in`, `while`, `do-while`, `break` y `continue`.
10. Colecciones: `List`, `Set` y `Map`.
11. Funciones y parámetros.
12. Scope, callbacks y funciones anónimas.
13. Null safety.
14. Clases, objetos y constructores.
15. POO: abstracción, herencia, interfaces y mixins.
16. Errores y excepciones.
17. `Future`, `async` y `await`.
18. Archivos, imports y paquetes.
19. Proyecto integrador: biblioteca de consola.

Cada lección Dart incluye **Sintaxis esencial**, ejemplos, ejercicios y ejemplo integrador con una tarjeta que señala el archivo recomendado, la ubicación del código y el comando para ejecutarlo.

### Etapa 2 · Flutter

La ruta Flutter también tiene 19 pasos y construye progresivamente una misma app llamada **Mi Biblioteca**.

Primera parte:

- Introducción a Flutter, `MaterialApp`, `Scaffold`, `AppBar` y FAB.
- Widgets y layouts responsive.
- Estado y reactividad.
- Rutas y navegación.
- Formularios y validación.
- Async, HTTP y APIs.
- Persistencia local.
- Arquitectura por features.
- Testing y análisis estático.
- Rendimiento y reconstrucciones.
- Accesibilidad y UX.

Segunda parte:

- Ciclo de vida, `State`, `BuildContext`, `mounted` y `dispose`.
- `ListView`, `GridView`, builders y keys.
- Material 3, `ThemeData` y `ColorScheme`.
- Animaciones implícitas y explícitas.
- Gestos, teclado y foco.
- `SnackBar`, `Dialog`, `BottomSheet` y feedback.
- Arquitectura de estado por feature.
- Offline, caché y sincronización.

Cada paso Flutter incluye:

- imagen representativa del tema;
- imágenes individuales de widgets cuando aplica;
- preview visual de móvil;
- sintaxis, ejemplos, errores y ejercicios;
- proyecto continuo con **archivos a crear** y **archivos a modificar**;
- sección **Dónde poner el código**;
- resultado esperado y checkpoint.

### Etapa 3 · Proyectos Flutter

La ruta termina con 4 proyectos independientes. Cada uno cuenta con contenido enriquecido, imagen, comandos, estructura de archivos, ubicación del código, práctica y checklist final.

1. Gestor de tareas con CRUD, filtros, estado y persistencia.
2. Biblioteca personal con búsqueda, favoritos, navegación y responsive.
3. Aplicación de clima con API, JSON, async, estados y tests.
4. Proyecto final con arquitectura, datos remotos, persistencia, accesibilidad, pruebas, CI y despliegue.

## Funciones de la aplicación

- Diseño responsive para escritorio, tableta y móvil.
- Tema **claro, oscuro o automático según el sistema**, guardado localmente.
- Dashboard de progreso con completadas, pendientes, favoritos y total de módulos.
- Sidebar de ruta de aprendizaje en pantallas grandes.
- Búsqueda por título, categoría, nivel y palabras clave.
- Resultados de búsqueda resaltados visualmente.
- Filtros por categoría, nivel y vista de solo favoritos.
- Favoritos persistentes con `shared_preferences`.
- Progreso persistente y restauración de la última sección abierta.
- **42 módulos**: 19 Dart + 19 Flutter + 4 proyectos.
- Vista de detalle con explicación, sintaxis, ejemplos, errores comunes, ejercicios, código y reto.
- Imágenes SVG/HTML representativas y carrusel de widgets en Flutter.
- Navegación anterior/siguiente entre módulos.
- Guías prácticas con rutas de archivos y ubicación exacta del código.
- Pruebas del catálogo, contenido educativo, imágenes, proyectos y planes progresivos.
- Análisis estático y tests automáticos en GitHub Actions.
- Build y despliegue de Flutter Web con GitHub Pages.

## GitHub Pages

El workflow de despliegue:

1. instala dependencias;
2. ejecuta `flutter analyze`;
3. ejecuta `flutter test`;
4. genera `flutter build web --release`;
5. copia el resultado a `docs/` como fallback para Pages por rama.

El build utiliza el `base-href` correspondiente a `/flutterBiblioteca/` y ajusta el fallback publicado en `docs/`.

## Estructura principal

```text
lib/
  data/
    catalog/
      dart_basics_catalog.dart
      dart_lesson_content.dart
      flutter_catalog.dart
      flutter_extended_catalog.dart
      flutter_lesson_content.dart
      flutter_extended_lesson_content.dart
      project_catalog.dart
    dart_progressive_plan.dart
    flutter_code_placement.dart
    progressive_app_plan.dart
    course_catalog.dart
  models/
    course_section.dart
    guided_build_step.dart
    lesson_content.dart
  screens/
    library_home_page.dart
  services/
    library_controller.dart
    progress_store.dart
  widgets/
    dart_code_location_hint.dart
    guided_project_panel.dart
    html_asset_image.dart
    lesson_illustration.dart
    lesson_visual_poster.dart
    library_filters.dart
    library_sidebar.dart
    progress_dashboard.dart
    section_card.dart
    section_detail_enriched.dart
    widget_individual_gallery.dart
    widget_mobile_preview.dart
    widget_visual_carousel.dart
  app.dart
  main.dart
```

Los catálogos describen la ruta. Los archivos `*_lesson_content.dart` contienen teoría y ejemplos enriquecidos. Los planes progresivos describen la práctica, archivos y checkpoints. Los widgets visuales muestran imágenes, previews y guías de ubicación del código.

## Ejecutar

```bash
flutter pub get
flutter run
```

Para web:

```bash
flutter run -d chrome
```

## Verificar

```bash
flutter analyze
flutter test
flutter build web
```

GitHub Actions ejecuta análisis y pruebas en cada push a `main`; el workflow de despliegue también valida y construye Flutter Web antes de actualizar `docs/`.
