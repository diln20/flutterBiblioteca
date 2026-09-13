# Flutter Biblioteca

Versión Flutter de la biblioteca interactiva de desarrollo web. Conserva la idea principal del proyecto HTML original: navegación por áreas, filtros, búsqueda, favoritos, progreso persistente, niveles y tarjetas educativas con código y ruta guiada.

## Incluye

- UI responsive para escritorio, tablet y móvil.
- Sidebar de ruta de aprendizaje en pantallas grandes.
- Búsqueda y filtros por categoría.
- Favoritos persistentes.
- Progreso persistente con `shared_preferences`.
- Tarjetas por tema y nivel.
- Vista de detalle con pasos, código y ejercicio.
- Tema oscuro inspirado en la biblioteca HTML original.

## Ejecutar

```bash
flutter pub get
flutter run
```

## Estructura inicial

- `lib/main.dart`: aplicación completa inicial.
- `pubspec.yaml`: dependencias Flutter.
- `analysis_options.yaml`: reglas de lint.

La siguiente evolución recomendada es dividir `main.dart` por features (`models`, `data`, `screens`, `widgets`, `services`) y portar más contenido de la biblioteca HTML original.
