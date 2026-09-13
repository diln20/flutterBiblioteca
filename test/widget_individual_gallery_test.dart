import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_biblioteca/data/catalog/flutter_catalog.dart';
import 'package:flutter_biblioteca/data/catalog/flutter_extended_catalog.dart';
import 'package:flutter_biblioteca/widgets/widget_individual_gallery.dart';

void main() {
  test('cada lección Flutter tiene imágenes individuales de widgets', () {
    final sections = [...flutterCatalog, ...flutterExtendedCatalog];

    for (final section in sections) {
      final visuals = WidgetIndividualGallery.visualsFor(section.id);
      expect(
        visuals,
        isNotEmpty,
        reason: '${section.id} debe tener al menos una imagen individual de widget',
      );
    }
  });

  test('las lecciones visuales principales muestran varios widgets', () {
    expect(WidgetIndividualGallery.visualsFor('flutter-intro').length, greaterThanOrEqualTo(4));
    expect(WidgetIndividualGallery.visualsFor('widgets-layout').length, greaterThanOrEqualTo(5));
    expect(WidgetIndividualGallery.visualsFor('formularios').length, greaterThanOrEqualTo(4));
    expect(WidgetIndividualGallery.visualsFor('flutter-lists-grids').length, greaterThanOrEqualTo(4));
    expect(WidgetIndividualGallery.visualsFor('flutter-feedback-overlays').length, greaterThanOrEqualTo(3));
  });
}
