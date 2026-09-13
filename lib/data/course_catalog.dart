import '../models/course_section.dart';
import 'catalog/dart_basics_catalog.dart';
import 'catalog/flutter_catalog.dart';

/// Ruta completa de aprendizaje.
///
/// El orden es intencional: primero fundamentos de Dart y después Flutter.
const courseCatalog = <CourseSection>[
  ...dartBasicsCatalog,
  ...flutterCatalog,
];
