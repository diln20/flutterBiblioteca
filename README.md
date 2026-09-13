# Flutter Biblioteca

Biblioteca interactiva para estudiar **Dart y Flutter** mediante una ruta progresiva, explicaciones, código de referencia, pasos guiados, ejemplos, errores comunes, ejercicios y retos.

La interfaz toma como referencia la biblioteca HTML original: conserva navegación por áreas, filtros, búsqueda, favoritos, progreso persistente y diseño responsive, pero está implementada completamente con widgets Flutter.

## Enfoque de aprendizaje

La ruta no comienza directamente con widgets. Primero se completa una etapa de **Dart básico**, porque todos los conceptos posteriores de Flutter dependen del lenguaje.

### Etapa 1 · Dart básico

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

### Etapa 2 · Flutter

Después de la base de Dart, la ruta continúa con:

- Introducción a Flutter y árbol de widgets.
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

Tanto las lecciones de Dart como las de Flutter cuentan con contenido extendido: **sintaxis esencial, conceptos clave, ejemplos explicados, errores comunes y ejercicios con pistas**, además del código integrador y el reto final de cada módulo.

## Funciones de la aplicación

- Diseño responsive para escritorio, tableta y móvil.
- Sidebar de ruta de aprendizaje en pantallas grandes.
- Búsqueda por título, categoría, nivel y palabras clave.
- Filtros por categoría y vista de solo favoritos.
- Favoritos persistentes con `shared_preferences`.
- Progreso persistente y restauración de la última sección abierta.
- 30 módulos organizados por etapas.
- Vista de detalle con explicación, sintaxis, ejemplos, errores comunes, ejercicios, código y reto.
- Navegación anterior/siguiente entre módulos.
- Pruebas del catálogo y del contenido educativo.
- Análisis estático y tests automáticos en GitHub Actions.
- Build y despliegue de Flutter Web con GitHub Pages.

## Estructura

```text
lib/
  data/
    catalog/
      dart_basics_catalog.dart
      dart_lesson_content.dart
      flutter_catalog.dart
      flutter_lesson_content.dart
    course_catalog.dart
  models/
    course_section.dart
    lesson_content.dart
  screens/
    library_home_page.dart
  services/
    library_controller.dart
    progress_store.dart
  widgets/
    library_filters.dart
    library_sidebar.dart
    section_card.dart
    section_detail_enriched.dart
  app.dart
  main.dart
```

El archivo `course_catalog.dart` solo compone las etapas. El catálogo base y el contenido extendido están separados para que la biblioteca pueda crecer sin volver a crear archivos monolíticos.

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
```

GitHub Actions ejecuta ambas verificaciones en cada push a `main`. El workflow de Pages también genera el build web con el `base-href` correcto para `/flutterBiblioteca/` y publica el resultado.
