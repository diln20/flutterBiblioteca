import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_biblioteca/data/course_catalog.dart';

void main() {
  test('course catalog has unique ids', () {
    final ids = courseCatalog.map((section) => section.id).toList();
    expect(ids.toSet().length, ids.length);
  });

  test('every course has learning material', () {
    for (final section in courseCatalog) {
      expect(section.title.trim(), isNotEmpty);
      expect(section.description.trim(), isNotEmpty);
      expect(section.steps.length, greaterThanOrEqualTo(3));
      expect(section.challenge.trim(), isNotEmpty);
      expect(section.keywords, isNotEmpty);
    }
  });
}
