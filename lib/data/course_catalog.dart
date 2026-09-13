import '../models/course_section.dart';
import 'catalog/dart_basics_catalog.dart';
import 'catalog/flutter_catalog.dart';
import 'catalog/project_catalog.dart';

/// Ruta completa de aprendizaje.
///
/// El orden es intencional: primero fundamentos de Dart, despues Flutter
/// y al final proyectos completos para integrar lo aprendido.
const courseCatalog = <CourseSection>[
  ...dartBasicsCatalog,
  ...flutterCatalog,
  ...projectCatalog,
];
