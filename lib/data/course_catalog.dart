import '../models/course_section.dart';
import 'catalog/setup_catalog.dart';
import 'catalog/dart_basics_catalog.dart';
import 'catalog/flutter_catalog.dart';
import 'catalog/flutter_extended_catalog.dart';
import 'catalog/project_catalog.dart';

/// Ruta completa de aprendizaje.
///
/// El orden es intencional: primero se prepara el entorno, luego se estudian
/// los fundamentos de Dart, despues Flutter, una etapa Flutter ampliada y al
/// final proyectos completos para integrar lo aprendido.
const courseCatalog = <CourseSection>[
  ...setupCatalog,
  ...dartBasicsCatalog,
  ...flutterCatalog,
  ...flutterExtendedCatalog,
  ...projectCatalog,
];
