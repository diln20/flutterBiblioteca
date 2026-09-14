import 'package:flutter_biblioteca/data/catalog/project_catalog.dart';
import 'package:flutter_biblioteca/widgets/lesson_visual_poster.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('project route contains progressive complete projects', () {
    expect(projectCatalog.length, 4);

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

  test('every final project has files, code placement and checkpoints', () {
    expect(projectBuildPlan.length, projectCatalog.length);

    for (final project in projectCatalog) {
      final plan = projectBuildPlan[project.id];
      expect(plan, isNotNull, reason: 'Missing build plan for ${project.id}');
      expect(plan!.createFiles, isNotEmpty);
      expect(plan.codePlacement, isNotEmpty);
      expect(plan.tasks.length, greaterThanOrEqualTo(5));
      expect(plan.expectedResult.trim(), isNotEmpty);
      expect(plan.checkpoint.trim(), isNotEmpty);
      expect(plan.commands, isNotEmpty);
    }
  });

  test('every final project has rich learning content', () {
    expect(projectLessonContent.length, projectCatalog.length);

    for (final project in projectCatalog) {
      final content = projectLessonContent[project.id];
      expect(content, isNotNull, reason: 'Missing content for ${project.id}');
      expect(content!.syntax.trim(), isNotEmpty);
      expect(content.concepts.length, greaterThanOrEqualTo(3));
      expect(content.examples.length, greaterThanOrEqualTo(2));
      expect(content.commonMistakes.length, greaterThanOrEqualTo(3));
      expect(content.exercises.length, greaterThanOrEqualTo(3));
    }
  });

  test('every final project has a representative visual poster', () {
    for (final project in projectCatalog) {
      expect(
        LessonVisualPoster.supports(project),
        isTrue,
        reason: 'Missing poster for ${project.id}',
      );
    }
  });
}
