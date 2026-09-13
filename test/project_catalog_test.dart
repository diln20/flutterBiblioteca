import 'package:flutter_biblioteca/data/catalog/project_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('project route contains progressive complete projects', () {
    expect(projectCatalog.length, greaterThanOrEqualTo(4));

    final ids = projectCatalog.map((item) => item.id).toSet();
    expect(ids.length, projectCatalog.length);

    for (final project in projectCatalog) {
      expect(project.group, 'Proyectos Flutter');
      expect(project.title.trim(), isNotEmpty);
      expect(project.description.trim(), isNotEmpty);
      expect(project.steps.length, greaterThanOrEqualTo(5));
      expect(project.code.trim(), isNotEmpty);
      expect(project.challenge.trim(), isNotEmpty);
    }
  });
}
