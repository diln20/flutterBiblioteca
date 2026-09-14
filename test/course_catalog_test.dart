import 'package:flutter_biblioteca/data/catalog/dart_lesson_content.dart';
import 'package:flutter_biblioteca/data/catalog/setup_catalog.dart';
import 'package:flutter_biblioteca/data/catalog/setup_lesson_content.dart';
import 'package:flutter_biblioteca/data/course_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('course catalog has unique ids', () {
    final ids = courseCatalog.map((section) => section.id).toList();
    expect(ids.toSet().length, ids.length);
  });

  test('every course has learning material', () {
    for (final section in courseCatalog) {
      expect(section.title.trim(), isNotEmpty);
      expect(section.description.trim(), isNotEmpty);
      expect(section.whyItMatters.trim(), isNotEmpty);
      expect(section.code.trim(), isNotEmpty);
      expect(section.steps.length, greaterThanOrEqualTo(3));
      expect(section.challenge.trim(), isNotEmpty);
      expect(section.keywords, isNotEmpty);
    }
  });

  test('the learning route starts with environment setup', () {
    expect(setupCatalog.map((item) => item.id).toList(), [
      'setup-dart',
      'setup-flutter',
    ]);
    expect(courseCatalog.take(2).map((item) => item.id).toList(), [
      'setup-dart',
      'setup-flutter',
    ]);

    for (final section in setupCatalog) {
      final content = setupLessonContent[section.id];
      expect(content, isNotNull);
      expect(content!.concepts.length, greaterThanOrEqualTo(4));
      expect(content.examples.length, greaterThanOrEqualTo(4));
      expect(content.commonMistakes.length, greaterThanOrEqualTo(4));
      expect(content.exercises.length, greaterThanOrEqualTo(3));
    }
  });

  test('the complete Dart basics stage follows setup', () {
    const expectedDartIds = <String>[
      'dart-01-introduccion',
      'dart-02-variables-constantes',
      'dart-03-tipos-datos',
      'dart-04-operadores',
      'dart-05-strings',
      'dart-06-conversion-entrada',
      'dart-07-condicionales',
      'dart-08-switch',
      'dart-09-bucles',
      'dart-10-colecciones',
      'dart-11-funciones',
      'dart-12-scope-callbacks',
      'dart-13-null-safety',
      'dart-14-clases-objetos',
      'dart-15-poo',
      'dart-16-excepciones',
      'dart-17-async',
      'dart-18-imports-paquetes',
      'dart-19-proyecto-integrador',
    ];

    final dartStart = setupCatalog.length;
    final dartIds = courseCatalog
        .skip(dartStart)
        .take(expectedDartIds.length)
        .map((section) => section.id)
        .toList();

    expect(dartIds, expectedDartIds);
    expect(
      courseCatalog
          .skip(dartStart)
          .take(expectedDartIds.length)
          .every((section) => section.group == 'Dart básico'),
      isTrue,
    );
    expect(
      courseCatalog[dartStart + expectedDartIds.length].id,
      'flutter-intro',
    );
  });

  test('Dart basics covers the essential language concepts', () {
    final dartKeywords = courseCatalog
        .where((section) => section.group == 'Dart básico')
        .expand((section) => section.keywords)
        .map((keyword) => keyword.toLowerCase())
        .toSet();

    for (final concept in <String>[
      'variables',
      'operadores',
      'if',
      'switch',
      'for',
      'list',
      'funciones',
      'null safety',
      'clases',
      'try',
      'future',
      'import',
    ]) {
      expect(dartKeywords, contains(concept));
    }
  });

  test('every Dart lesson has rich examples, mistakes and exercises', () {
    final dartSections = courseCatalog.where(
      (section) => section.group == 'Dart básico',
    );

    for (final section in dartSections) {
      final content = dartLessonContent[section.id];
      expect(content, isNotNull, reason: 'Missing rich content for ${section.id}');
      expect(content!.syntax.trim(), isNotEmpty);
      expect(content.concepts.length, greaterThanOrEqualTo(3));
      expect(content.examples.length, greaterThanOrEqualTo(2));
      expect(content.commonMistakes.length, greaterThanOrEqualTo(3));
      expect(content.exercises.length, greaterThanOrEqualTo(3));
    }
  });
}
