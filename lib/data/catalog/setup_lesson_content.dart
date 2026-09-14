import '../../models/lesson_content.dart';

const setupLessonContent = <String, LessonContent>{
  'setup-dart': LessonContent(
    syntax: r'''dart --version

dart create -t console-simple hola_dart
cd hola_dart
dart run

dart format .
dart analyze''',
    concepts: [
      'Si vas a instalar Flutter, no instales Dart dos veces: Flutter incluye el SDK completo de Dart.',
      'PATH es la lista de carpetas donde el sistema busca comandos como dart y flutter.',
      'Después de cambiar PATH, cierra y vuelve a abrir terminales y VS Code.',
      'La prueba real de una instalación correcta es crear, ejecutar y analizar un proyecto pequeño.',
      'Usa el canal estable para aprender y desarrollar proyectos normales.',
    ],
    examples: [
      LessonExample(
        title: 'Opción recomendada si estudiarás Flutter',
        explanation:
            'Instala Flutter y utiliza el Dart que viene incluido. Comprueba ambos comandos antes de seguir.',
        code: r'''flutter --version
dart --version''',
        output: 'Debe aparecer una versión de Flutter y una versión de Dart, sin "command not found".',
      ),
      LessonExample(
        title: 'Windows · Dart independiente',
        explanation:
            'Si solo necesitas Dart y no vas a instalar Flutter todavía, la documentación oficial permite instalarlo con Chocolatey desde PowerShell con permisos de administrador.',
        code: r'''choco install dart-sdk
dart --version''',
        output: 'Dart SDK version: ... (stable)',
      ),
      LessonExample(
        title: 'macOS · Dart independiente',
        explanation:
            'Con Homebrew puedes instalar el SDK oficial. Si ya usarás Flutter, este paso no es necesario.',
        code: r'''brew tap dart-lang/dart
brew trust dart-lang/dart
brew install dart
dart --version''',
      ),
      LessonExample(
        title: 'Ubuntu/Debian · Dart independiente',
        explanation:
            'Configura una vez el repositorio oficial y luego instala Dart con apt.',
        code: r'''sudo apt-get update
sudo apt-get install apt-transport-https gpg
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub \
  | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg

echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
  | sudo tee /etc/apt/sources.list.d/dart_stable.list

sudo apt-get update
sudo apt-get install dart
dart --version''',
      ),
      LessonExample(
        title: 'Configura VS Code',
        explanation:
            'Instala VS Code y la extensión Dart. Después abre una terminal integrada y verifica el SDK desde el mismo editor.',
        code: r'''dart --version
dart create -t console-simple hola_dart
cd hola_dart
dart run''',
      ),
    ],
    commonMistakes: [
      'Instalar Dart por separado aunque Flutter ya está instalado y terminar con dos versiones diferentes en PATH.',
      'Modificar PATH y probar en una terminal que estaba abierta antes del cambio.',
      'Copiar el SDK dentro de una carpeta temporal o de Descargas y luego moverla, rompiendo la ruta configurada.',
      'Dar por terminada la instalación solo porque el editor reconoce .dart, sin probar dart --version y dart run.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Comprueba el SDK',
        prompt: 'Abre una terminal nueva y ejecuta dart --version. Anota si el comando viene de Flutter o de una instalación independiente.',
        hint: 'Si instalaste Flutter, normalmente usarás el dart que está junto a flutter/bin.',
      ),
      PracticeExercise(
        title: 'Crea el proyecto de prueba',
        prompt: 'Crea hola_dart, cambia el mensaje del programa y ejecútalo con dart run.',
        hint: 'Usa dart create -t console-simple hola_dart.',
      ),
      PracticeExercise(
        title: 'Verifica calidad básica',
        prompt: 'Ejecuta dart format . y dart analyze dentro del proyecto y corrige cualquier problema antes de continuar.',
      ),
    ],
  ),
  'setup-flutter': LessonContent(
    syntax: r'''flutter --version
dart --version
flutter doctor -v
flutter devices

flutter create hola_flutter
cd hola_flutter
flutter run''',
    concepts: [
      'Flutter incluye Dart: una sola instalación prepara los dos comandos.',
      'PATH debe contener la carpeta bin del SDK de Flutter para usar flutter y dart desde cualquier terminal.',
      'flutter doctor -v es el diagnóstico principal: no necesitas configurar plataformas que no vas a usar.',
      'Para comenzar rápido, Flutter Web requiere menos configuración que Android o iOS.',
      'Android necesita Android Studio/SDK y un dispositivo o emulador; iOS necesita macOS y Xcode.',
    ],
    examples: [
      LessonExample(
        title: 'Ruta sencilla con VS Code',
        explanation:
            'Instala Git y VS Code. Agrega la extensión Flutter; esta instala también soporte Dart. Puedes usar la instalación guiada del SDK desde VS Code o descargar Flutter manualmente y agregar flutter/bin al PATH.',
        code: r'''flutter --version
dart --version
flutter doctor -v''',
        output: 'Flutter doctor debe mostrar el SDK y marcar con ✓ los componentes que ya están listos.',
      ),
      LessonExample(
        title: 'Empieza por Flutter Web',
        explanation:
            'Es una forma rápida de comprobar que SDK, editor y proyecto funcionan antes de configurar Android.',
        code: r'''flutter devices
flutter create hola_flutter
cd hola_flutter
flutter run -d chrome''',
        output: 'La aplicación de ejemplo debe abrirse en Chrome.',
      ),
      LessonExample(
        title: 'Configura Android',
        explanation:
            'Instala Android Studio, desde SDK Manager instala el Android SDK y herramientas necesarias, crea un dispositivo virtual o conecta un teléfono y acepta las licencias.',
        code: r'''flutter doctor --android-licenses
flutter doctor -v
flutter emulators
flutter devices''',
        output: 'Flutter debe detectar al menos un emulador o dispositivo Android cuando esté iniciado/conectado.',
      ),
      LessonExample(
        title: 'macOS e iOS',
        explanation:
            'Para compilar para iPhone/iPad necesitas macOS y Xcode. Instala también las herramientas de línea de comandos y vuelve a ejecutar flutter doctor.',
        code: r'''xcode-select --install
flutter doctor -v''',
      ),
      LessonExample(
        title: 'Prueba Hot Reload',
        explanation:
            'Con la app ejecutándose, cambia un Text de lib/main.dart y guarda. El cambio debe aparecer sin reiniciar completamente la aplicación.',
        code: r'''flutter run
# Edita lib/main.dart y guarda el archivo.''',
      ),
    ],
    commonMistakes: [
      'Instalar solo la extensión de VS Code y asumir que el SDK de Flutter ya está disponible sin verificarlo.',
      'Agregar la carpeta flutter al PATH en vez de la carpeta flutter/bin.',
      'Intentar corregir todas las advertencias de flutter doctor aunque sean de plataformas que no se usarán.',
      'Crear un emulador Android pero no iniciarlo antes de ejecutar flutter devices.',
      'No aceptar las licencias de Android cuando flutter doctor lo solicita.',
    ],
    exercises: [
      PracticeExercise(
        title: 'Diagnóstico',
        prompt: 'Ejecuta flutter doctor -v y separa los resultados en: listo, necesario para tu plataforma y opcional.',
      ),
      PracticeExercise(
        title: 'Primer dispositivo',
        prompt: 'Consigue que flutter devices muestre Chrome, un emulador Android o un teléfono físico.',
        hint: 'Para empezar más rápido puedes usar Chrome.',
      ),
      PracticeExercise(
        title: 'Primera app',
        prompt: 'Crea hola_flutter, ejecútala, cambia el texto principal y comprueba Hot Reload.',
        hint: 'Si usas web: flutter run -d chrome.',
      ),
      PracticeExercise(
        title: 'Checkpoint de entorno',
        prompt: 'Cierra VS Code y la terminal, vuelve a abrirlos y confirma que flutter --version, dart --version y flutter doctor siguen funcionando.',
      ),
    ],
  ),
};
