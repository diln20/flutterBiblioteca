import 'package:flutter_biblioteca/data/catalog/flutter_extended_catalog.dart';
import 'package:flutter_biblioteca/data/catalog/flutter_extended_lesson_content.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('extended Flutter stage is complete and rich', () {
    expect(flutterExtendedCatalog.length, greaterThanOrEqualTo(8));

    for (final section in flutterExtendedCatalog) {
      final content = flutterExtendedLessonContent[section.id];
      expect(content, isNotNull, reason: 'Missing rich content for ${section.id}');
      expect(section.steps.length, greaterThanOrEqualTo(4));
      expect(content!.syntax.trim(), isNotEmpty);
      expect(content.concepts.length, greaterThanOrEqualTo(4));
      expect(content.examples.length, greaterThanOrEqualTo(2));
      expect(content.commonMistakes.length, greaterThanOrEqualTo(3));
      expect(content.exercises.length, greaterThanOrEqualTo(3));
    }
  });
}
