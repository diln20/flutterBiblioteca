import 'package:flutter_biblioteca/data/catalog/dart_basics_catalog.dart';
import 'package:flutter_biblioteca/data/dart_progressive_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('cada lección Dart tiene un paso práctico progresivo', () {
    expect(dartBasicsCatalog, hasLength(19));
    expect(dartProgressivePlan, hasLength(19));

    for (var index = 0; index < dartBasicsCatalog.length; index++) {
      final section = dartBasicsCatalog[index];
      final step = dartProgressivePlan[section.id];

      expect(step, isNotNull, reason: 'Falta guía para ${section.id}');
      expect(step!.number, index + 1);
      expect(step.total, 19);
      expect(step.tasks, isNotEmpty);
      expect(
        step.codePlacement,
        isNotEmpty,
        reason: '${section.id} debe indicar dónde poner el código',
      );
      expect(
        step.createFiles.isNotEmpty || step.modifyFiles.isNotEmpty,
        isTrue,
        reason: '${section.id} debe indicar archivos a crear o modificar',
      );
    }
  });

  test('el proyecto Dart evoluciona hacia una estructura modular', () {
    final finalStep = dartProgressivePlan['dart-19-proyecto-integrador']!;

    expect(finalStep.createFiles, contains('lib/models/usuario.dart'));
    expect(finalStep.modifyFiles, contains('lib/services/biblioteca_service.dart'));
    expect(finalStep.codePlacement.keys, contains('test/biblioteca_service_test.dart'));
  });
}
