# Flutter Biblioteca

Biblioteca interactiva para estudiar **Dart y Flutter** mediante una ruta progresiva, explicaciones breves, código de referencia, pasos guiados y retos.

La interfaz toma como referencia la biblioteca HTML original: conserva navegación por áreas, filtros, búsqueda, favoritos, progreso persistente y un diseño responsive, pero está implementada con widgets Flutter en lugar de una WebView.

## Funciones

- Diseño responsive para escritorio, tableta y móvil.
- Sidebar de ruta de aprendizaje en pantallas grandes.
- Búsqueda por título, categoría, nivel y palabras clave.
- Filtros por categoría y vista de solo favoritos.
- Favoritos persistentes con `shared_preferences`.
- Progreso persistente y restauración de la última sección abierta.
- 12 módulos progresivos de Dart y Flutter.
- Vista de detalle con explicación, pasos, código y reto.
- Navegación anterior/siguiente entre módulos.
- Pruebas del catálogo y análisis estático en GitHub Actions.
- Entrada web preparada en `web/`.

## Ruta actual

1. Dart desde cero.
2. Introducción a Flutter.
3. Widgets y layouts responsive.
4. Estado y reactividad.
5. Rutas y navegación.
6. Formularios y validación.
7. Async, HTTP y APIs.
8. Persistencia local.
9. Arquitectura por features.
10. Testing y análisis estático.
11. Rendimiento y reconstrucciones.
12. Accesibilidad y UX.

## Estructura

```text
lib/
  data/
    course_catalog.dart
  models/
    course_section.dart
  screens/
    library_home_page.dart
  services/
    library_controller.dart
    progress_store.dart
  widgets/
    library_filters.dart
    library_sidebar.dart
    section_card.dart
    section_detail.dart
  app.dart
  main.dart
```

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

GitHub Actions ejecuta ambas verificaciones en cada push a `main` y en cada pull request.
