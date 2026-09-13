import 'package:flutter_biblioteca/data/catalog/flutter_catalog.dart';
import 'package:flutter_biblioteca/data/catalog/flutter_extended_catalog.dart';
import 'package:flutter_biblioteca/widgets/widget_mobile_preview.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every Flutter lesson has a native mobile preview', () {
    final flutterIds = <String>{
      ...flutterCatalog.map((section) => section.id),
      ...flutterExtendedCatalog.map((section) => section.id),
    };

    expect(
      WidgetMobilePreview.supportedIds,
      containsAll(flutterIds),
      reason: 'Cada lección de Flutter debe tener una vista representativa en móvil.',
    );
  });
}
