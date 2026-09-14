import 'package:flutter_biblioteca/widgets/svg_compat.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('convierte estilos CSS por clase a atributos SVG inline', () {
    const source = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <style>
    .bg{fill:#f8fafc}
    .title{font:700 22px Arial;fill:#0f172a}
    .white{fill:#fff;font:700 18px Arial}
    .white.big{font-size:30px}
  </style>
  <rect class="bg" width="100" height="100"/>
  <text class="title" x="10" y="20">Título</text>
  <text class="white big" x="10" y="50">+</text>
</svg>
''';

    final normalized = normalizeSvgCssForFlutter(source);

    expect(normalized, isNot(contains('<style')));
    expect(normalized, isNot(contains('class="')));
    expect(normalized, contains('fill="#f8fafc"'));
    expect(normalized, contains('font-weight="700"'));
    expect(normalized, contains('font-size="22"'));
    expect(normalized, contains('font-family="Arial"'));
    expect(normalized, contains('font-size="30"'));
  });

  test('un atributo directo del SVG tiene prioridad sobre la clase CSS', () {
    const source = '''
<svg xmlns="http://www.w3.org/2000/svg">
  <style>.label{fill:#111827;font-size:18px}</style>
  <text class="label" fill="#7c3aed">Label</text>
</svg>
''';

    final normalized = normalizeSvgCssForFlutter(source);

    expect(normalized, contains('fill="#7c3aed"'));
    expect(normalized, isNot(contains('fill="#111827" fill="#7c3aed"')));
    expect(normalized, contains('font-size="18"'));
  });
}
