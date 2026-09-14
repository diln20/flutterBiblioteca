import '../../models/course_section.dart';

/// Preparación del entorno antes de comenzar la ruta de programación.
const setupCatalog = <CourseSection>[
  CourseSection(
    id: 'setup-dart',
    group: 'Preparación',
    title: 'Instalación y configuración de Dart',
    level: 'Inicio',
    description:
        'Prepara Dart, la terminal y el editor. Aprende cuándo necesitas instalar Dart por separado y cómo comprobar que todo funciona.',
    whyItMatters:
        'Antes de escribir código necesitas poder ejecutar dart desde cualquier terminal. Si vas a instalar Flutter, recuerda que Flutter ya incluye el SDK completo de Dart y no necesitas duplicar la instalación.',
    code: r'''# 1. Comprueba si Dart ya está disponible
dart --version

# 2. Crea un proyecto de prueba
dart create -t console-simple hola_dart
cd hola_dart

# 3. Ejecuta el proyecto
dart run

# 4. Revisa herramientas básicas
dart format .
dart analyze''',
    steps: [
      'Decide si usarás el Dart incluido con Flutter o un SDK de Dart independiente.',
      'Instala o verifica Dart y confirma que dart --version funciona en una terminal nueva.',
      'Configura VS Code con la extensión Dart o el editor que prefieras.',
      'Crea y ejecuta un proyecto de consola para comprobar PATH, SDK y editor.',
    ],
    challenge:
        'Crea un proyecto de consola desde cero, ejecútalo, modifícalo y verifica que dart analyze termine sin errores.',
    keywords: [
      'instalacion',
      'dart sdk',
      'path',
      'vscode',
      'terminal',
      'dart create',
      'dart run',
    ],
    accentValue: 0xFF0EA5E9,
  ),
  CourseSection(
    id: 'setup-flutter',
    group: 'Preparación',
    title: 'Instalación y configuración de Flutter',
    level: 'Inicio',
    description:
        'Instala Flutter, configura PATH, VS Code y un destino de ejecución. Después deja flutter doctor sin problemas importantes.',
    whyItMatters:
        'Una configuración correcta evita errores que parecen de código pero en realidad vienen del SDK, Android Studio, licencias, PATH o dispositivos. Flutter incluye Dart automáticamente.',
    code: r'''# Comprueba Flutter y Dart
flutter --version
dart --version

# Diagnóstico completo
flutter doctor -v

# Comprueba dispositivos disponibles
flutter devices

# Crea una app de prueba
flutter create hola_flutter
cd hola_flutter
flutter run''',
    steps: [
      'Instala Git y un editor. Para principiantes, VS Code con la extensión Flutter es una ruta sencilla.',
      'Instala Flutter estable, agrega flutter/bin al PATH y reinicia las terminales abiertas.',
      'Ejecuta flutter doctor -v y corrige únicamente los componentes necesarios para la plataforma que usarás.',
      'Empieza por Flutter Web si quieres validar el entorno rápido; configura Android Studio y un emulador cuando vayas a desarrollar para Android.',
      'Crea hola_flutter, ejecútalo y prueba Hot Reload antes de continuar a las lecciones.',
    ],
    challenge:
        'Consigue ejecutar la misma app de ejemplo al menos en Chrome o en un dispositivo/emulador y deja flutter doctor sin errores relacionados con ese destino.',
    keywords: [
      'instalacion flutter',
      'flutter sdk',
      'flutter doctor',
      'android studio',
      'emulador',
      'vscode',
      'path',
      'hot reload',
    ],
    accentValue: 0xFF38BDF8,
  ),
];
