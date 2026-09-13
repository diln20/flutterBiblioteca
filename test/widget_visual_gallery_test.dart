import 'package:flutter_biblioteca/data/catalog/flutter_catalog.dart';
import 'package:flutter_biblioteca/data/catalog/flutter_extended_catalog.dart';
import 'package:flutter_biblioteca/widgets/widget_svg_gallery.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every Flutter lesson has SVG widget visuals', () {
    final sections = <dynamic>[
      ...flutterCatalog,
      ...flutterExtendedCatalog,
    ];

    for (final section in sections) {
      expect(
        WidgetSvgGallery.supports(section),
        isTrue,
        reason: 'Missing SVG widget visuals for ${section.id}',
      );
    }
  });
}
