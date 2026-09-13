import 'package:flutter_biblioteca/data/catalog/flutter_catalog.dart';
import 'package:flutter_biblioteca/data/catalog/flutter_extended_catalog.dart';
import 'package:flutter_biblioteca/data/progressive_app_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every Flutter lesson advances the same guided project', () {
    final flutterSections = [...flutterCatalog, ...flutterExtendedCatalog];

    expect(progressiveAppPlan.length, flutterSections.length);

    for (final section in flutterSections) {
      final step = progressiveAppPlan[section.id];
      expect(step, isNotNull, reason: 'Missing guided build step for ${section.id}');
      expect(step!.goal.trim(), isNotEmpty);
      expect(step.tasks.length, greaterThanOrEqualTo(4));
      expect(step.expectedResult.trim(), isNotEmpty);
      expect(step.checkpoint.trim(), isNotEmpty);
    }
  });

  test('guided project steps are sequential', () {
    final steps = progressiveAppPlan.values.toList()
      ..sort((a, b) => a.number.compareTo(b.number));

    expect(steps.length, 19);
    expect(steps.map((step) => step.number).toList(), List<int>.generate(19, (index) => index + 1));
    expect(steps.every((step) => step.total == 19), isTrue);
  });
}
