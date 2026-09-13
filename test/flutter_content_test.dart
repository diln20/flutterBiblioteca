import 'package:flutter_biblioteca/data/catalog/flutter_catalog.dart';
import 'package:flutter_biblioteca/data/catalog/flutter_lesson_content.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Flutter modules have extended content', () {
    for (final section in flutterCatalog) {
      final content = flutterLessonContent[section.id];
      expect(content, isNotNull);
      expect(content!.syntax.trim(), isNotEmpty);
      expect(content.concepts.length, greaterThanOrEqualTo(3));
      expect(content.examples.length, greaterThanOrEqualTo(2));
      expect(content.commonMistakes.length, greaterThanOrEqualTo(3));
      expect(content.exercises.length, greaterThanOrEqualTo(3));
    }
  });
}
