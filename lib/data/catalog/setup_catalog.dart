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
    code: r'''# RECOMENDADO SI VAS A USAR FLUTTER
# Flutter ya incluye Dart. Comprueba ambos:
flutter --version
dart --version

# SOLO SI QUIERES DART INDEPENDIENTE

# Windows · PowerShell como administrador + Chocolatey
choco install dart-sdk
dart --version

# macOS · Homebrew
brew tap dart-lang/dart
brew trust dart-lang/dart
brew install dart
dart --version

# Ubuntu / Debian
sudo apt-get update
sudo apt-get install apt-transport-https gpg
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub \
  | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg

echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
  | sudo tee /etc/apt/sources.list.d/dart_stable.list

sudo apt-get update
sudo apt-get install dart
dart --version

# PRUEBA FINAL DEL ENTORNO
dart create -t console-simple hola_dart
cd hola_dart
dart run
dart format .
dart analyze''',
    steps: [
      'Si estudiarás Flutter, instala Flutter y usa el Dart incluido. Solo instala Dart independiente si realmente lo necesitas.',
      'Windows: usa Chocolatey para Dart independiente. macOS: Homebrew. Ubuntu/Debian: repositorio oficial + apt.',
      'Comprueba PATH con dart --version desde una terminal nueva. Si el comando no existe, revisa la ruta del SDK y reinicia terminal/VS Code.',
      'Instala VS Code y la extensión Dart para autocompletado, análisis y ejecución desde el editor.',
      'Crea hola_dart, ejecútalo, modifícalo y comprueba dart format . y dart analyze antes de continuar.',
    ],
    challenge:
        'Crea un proyecto de consola desde cero, ejecútalo, modifícalo y verifica que dart analyze termine sin errores.',
    keywords: [
      'instalacion',
      'dart sdk',
      'path',
      'vscode',
      'terminal',
      'windows',
      'macos',
      'linux',
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
    code: r'''# 1. COMPROBAR SDK Y PATH
flutter --version
dart --version
flutter doctor -v

# 2. OPCIÓN RÁPIDA: FLUTTER WEB
flutter devices
flutter create hola_flutter
cd hola_flutter
flutter run -d chrome

# 3. ANDROID
# Instala Android Studio, Android SDK y crea/inicia un emulador.
flutter doctor --android-licenses
flutter emulators
flutter devices
flutter run

# 4. macOS / iOS · solo en Mac
xcode-select --install
flutter doctor -v

# 5. COMPROBACIÓN FINAL
flutter analyze
flutter test''',
    steps: [
      'Instala Git y VS Code. Añade la extensión Flutter; el soporte Dart se instala junto con ella.',
      'Instala Flutter estable y agrega la carpeta flutter/bin al PATH. Cierra y vuelve a abrir terminales y VS Code.',
      'Ejecuta flutter doctor -v. Corrige solo lo que necesites para tu destino: no hace falta configurar Android, iOS y desktop todos a la vez.',
      'Para empezar rápido usa Web: confirma Chrome en flutter devices y ejecuta flutter run -d chrome.',
      'Para Android instala Android Studio, Android SDK, crea un emulador o conecta un teléfono y acepta licencias con flutter doctor --android-licenses.',
      'Para iOS necesitas macOS y Xcode. Ejecuta xcode-select --install y vuelve a revisar flutter doctor.',
      'Crea hola_flutter, modifica lib/main.dart y verifica Hot Reload antes de entrar a las lecciones de Flutter.',
    ],
    challenge:
        'Consigue ejecutar la app de ejemplo en Chrome o en un dispositivo/emulador y deja flutter doctor sin errores relacionados con ese destino.',
    keywords: [
      'instalacion flutter',
      'flutter sdk',
      'flutter doctor',
      'android studio',
      'android sdk',
      'emulador',
      'vscode',
      'path',
      'chrome',
      'xcode',
      'hot reload',
    ],
    accentValue: 0xFF38BDF8,
  ),
];
