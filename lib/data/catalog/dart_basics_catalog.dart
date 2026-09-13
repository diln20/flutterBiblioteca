import '../../models/course_section.dart';

/// Ruta inicial de la biblioteca. Antes de entrar a Flutter, el estudiante
/// recorre los fundamentos del lenguaje que usará en toda la aplicación.
const dartBasicsCatalog = <CourseSection>[
  CourseSection(
    id: 'dart-01-introduccion',
    group: 'Dart básico',
    title: '01 · Qué es Dart y primer programa',
    level: 'Principiante',
    description: 'Conoce para qué sirve Dart, la función main(), las sentencias, los comentarios, print() y las reglas básicas para escribir código legible.',
    whyItMatters: 'Flutter está escrito y se programa con Dart. Entender primero cómo se ejecuta un programa evita aprender widgets sin comprender el lenguaje.',
    code: r'''void main() {
  // Comentario de una línea
  print('Hola, Dart');

  /* Comentario
     de varias líneas */
  print('Mi primer programa');
}''',
    steps: [
      'Identifica main() como punto de entrada del programa.',
      'Usa print() para mostrar información en consola.',
      'Diferencia una sentencia, un bloque y un comentario.',
      'Practica nombres claros usando lowerCamelCase para variables y funciones.',
    ],
    challenge: 'Crea un programa que imprima tu nombre, tu ciudad y tres tecnologías que quieras aprender.',
    keywords: ['dart', 'main', 'print', 'comentarios', 'sintaxis', 'sentencias'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-02-variables-constantes',
    group: 'Dart básico',
    title: '02 · Variables, final y const',
    level: 'Principiante',
    description: 'Aprende a declarar datos con tipos explícitos, var, final y const, y cuándo conviene usar cada opción.',
    whyItMatters: 'La forma en que declaras un dato expresa si puede cambiar y ayuda al compilador a detectar errores antes de ejecutar la app.',
    code: r'''void main() {
  String nombre = 'Ana';
  var edad = 20;          // Dart infiere int
  double altura = 1.68;

  final fechaActual = DateTime.now();
  const pi = 3.141592;

  edad = 21;
  print('$nombre tiene $edad años');
  print(fechaActual);
  print(pi);
}''',
    steps: [
      'Declara variables con un tipo explícito.',
      'Usa var cuando el tipo sea evidente por el valor inicial.',
      'Usa final cuando el valor se asigne una sola vez en ejecución.',
      'Usa const para valores conocidos y constantes en tiempo de compilación.',
    ],
    challenge: 'Declara datos de un producto: nombre, precio, cantidad y un IVA constante. Calcula el subtotal.',
    keywords: ['variables', 'var', 'final', 'const', 'tipado', 'inferencia'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-03-tipos-datos',
    group: 'Dart básico',
    title: '03 · Tipos de datos básicos',
    level: 'Principiante',
    description: 'Trabaja con int, double, num, String, bool, Object y dynamic, y aprende la diferencia entre tipado seguro y valores dinámicos.',
    whyItMatters: 'Elegir el tipo correcto documenta la intención del código y evita operaciones inválidas durante el desarrollo.',
    code: r'''void main() {
  int unidades = 4;
  double precio = 19.95;
  num descuento = 5;
  String categoria = 'Libros';
  bool disponible = true;
  Object datoSeguro = 'Puede guardar distintos tipos';
  dynamic datoDinamico = 10;

  print(unidades.runtimeType);
  print(precio.runtimeType);
  print('$categoria - disponible: $disponible');
  print(datoSeguro);
  print(datoDinamico);
}''',
    steps: [
      'Usa int para enteros y double para números decimales.',
      'Usa num cuando aceptes tanto int como double.',
      'Representa texto con String y estados lógicos con bool.',
      'Prefiere tipos concretos u Object antes que dynamic cuando sea posible.',
    ],
    challenge: 'Crea variables para representar un estudiante: nombre, edad, promedio, activo y código de identificación.',
    keywords: ['int', 'double', 'num', 'string', 'bool', 'object', 'dynamic'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-04-operadores',
    group: 'Dart básico',
    title: '04 · Operadores',
    level: 'Principiante',
    description: 'Practica operadores aritméticos, de asignación, comparación, lógicos, incremento, decremento y el operador ternario.',
    whyItMatters: 'Las expresiones combinan datos y condiciones. Son la base de cálculos, validaciones y decisiones en cualquier programa.',
    code: r'''void main() {
  var a = 10;
  var b = 3;

  print(a + b);
  print(a - b);
  print(a * b);
  print(a / b);
  print(a ~/ b); // división entera
  print(a % b);  // residuo

  final esMayor = a > b;
  final cumple = a >= 10 && b != 0;
  final mensaje = cumple ? 'Válido' : 'No válido';

  print(esMayor);
  print(mensaje);
}''',
    steps: [
      'Realiza operaciones aritméticas con +, -, *, /, ~/ y %.',
      'Compara valores con ==, !=, >, <, >= y <=.',
      'Combina condiciones con &&, || y !.',
      'Usa el ternario condicion ? valorA : valorB para decisiones simples.',
    ],
    challenge: 'Calcula si una persona puede entrar a un evento según su edad y si tiene una entrada válida.',
    keywords: ['operadores', 'aritmetica', 'comparacion', 'logicos', 'ternario'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-05-strings',
    group: 'Dart básico',
    title: '05 · Strings e interpolación',
    level: 'Principiante',
    description: 'Aprende comillas simples y dobles, interpolación, cadenas multilínea, cadenas raw y operaciones comunes sobre texto.',
    whyItMatters: 'Las aplicaciones muestran, reciben y transforman texto constantemente: títulos, mensajes, formularios, búsquedas y datos de APIs.',
    code: r'''void main() {
  const nombre = 'Laura';
  const lenguaje = "Dart";
  final mensaje = 'Hola $nombre, estás aprendiendo $lenguaje';
  final detalle = '''
Curso: Dart básico
Estado: En progreso
''';
  final ruta = r'C:\proyectos\flutter';

  print(mensaje);
  print(detalle.trim());
  print(ruta);
  print(nombre.toUpperCase());
  print(mensaje.contains('Dart'));
}''',
    steps: [
      'Crea String con comillas simples y dobles.',
      'Inserta variables con $variable y expresiones con ${expresion}.',
      'Usa cadenas multilínea para textos largos.',
      'Practica métodos como trim(), contains(), toUpperCase() y split().',
    ],
    challenge: 'Construye una ficha de usuario en texto usando nombre, edad, profesión y ciudad mediante interpolación.',
    keywords: ['string', 'interpolacion', 'texto', 'metodos', 'raw string'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-06-conversion-entrada',
    group: 'Dart básico',
    title: '06 · Conversión de tipos y entrada por consola',
    level: 'Principiante',
    description: 'Convierte texto a números y números a texto con parse, tryParse y toString. Conoce stdin para programas Dart de consola.',
    whyItMatters: 'Los datos externos suelen llegar como texto. Validar y convertir correctamente evita errores cuando el usuario escribe valores inválidos.',
    code: r'''import 'dart:io';

void main() {
  stdout.write('Escribe tu edad: ');
  final texto = stdin.readLineSync();
  final edad = int.tryParse(texto ?? '');

  if (edad == null) {
    print('Edad inválida');
    return;
  }

  print('El próximo año tendrás ${edad + 1} años');
  print('Edad como texto: ${edad.toString()}');
}''',
    steps: [
      'Convierte con int.parse() y double.parse() cuando el formato esté garantizado.',
      'Prefiere tryParse() cuando el dato pueda ser inválido.',
      'Convierte valores a texto con toString().',
      'Usa stdin.readLineSync() únicamente en programas Dart de consola.',
    ],
    challenge: 'Pide dos números por consola, valida ambos y muestra suma, resta, multiplicación y división.',
    keywords: ['parse', 'tryparse', 'tostring', 'stdin', 'conversion'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-07-condicionales',
    group: 'Dart básico',
    title: '07 · Condicionales: if, else if y else',
    level: 'Principiante',
    description: 'Controla qué código se ejecuta según una o varias condiciones usando if, else if, else y condiciones compuestas.',
    whyItMatters: 'Las aplicaciones toman decisiones todo el tiempo: validar permisos, mostrar estados, aceptar formularios o reaccionar a datos.',
    code: r'''void main() {
  const nota = 4.2;

  if (nota >= 4.5) {
    print('Excelente');
  } else if (nota >= 3.0) {
    print('Aprobado');
  } else {
    print('Reprobado');
  }
}''',
    steps: [
      'Escribe una condición booleana dentro de if.',
      'Añade alternativas con else if.',
      'Usa else para el caso restante.',
      'Combina condiciones sin crear bloques anidados innecesarios.',
    ],
    challenge: 'Clasifica una compra como pequeña, mediana o grande según su valor y aplica un descuento distinto.',
    keywords: ['if', 'else', 'else if', 'condicionales', 'decisiones'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'dart-08-switch',
    group: 'Dart básico',
    title: '08 · switch y enum',
    level: 'Principiante',
    description: 'Usa switch cuando una variable puede tomar un conjunto conocido de casos y representa estados cerrados con enum.',
    whyItMatters: 'Los estados de una pantalla, un pedido o una tarea son más seguros cuando se modelan como opciones conocidas en vez de textos libres.',
    code: r'''enum EstadoPedido { creado, enviado, entregado, cancelado }

void main() {
  const estado = EstadoPedido.enviado;

  switch (estado) {
    case EstadoPedido.creado:
      print('Preparando pedido');
    case EstadoPedido.enviado:
      print('Pedido en camino');
    case EstadoPedido.entregado:
      print('Pedido entregado');
    case EstadoPedido.cancelado:
      print('Pedido cancelado');
  }
}''',
    steps: [
      'Crea un enum para un conjunto cerrado de estados.',
      'Evalúa el valor con switch.',
      'Cubre todos los casos para mantener el código exhaustivo.',
      'Prefiere enum frente a cadenas como "activo" o "inactivo" cuando el dominio sea cerrado.',
    ],
    challenge: 'Crea un enum DiaSemana y usa switch para indicar si el día seleccionado es laboral o fin de semana.',
    keywords: ['switch', 'enum', 'case', 'estados', 'control de flujo'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'dart-09-bucles',
    group: 'Dart básico',
    title: '09 · Bucles: for, for-in, while y do-while',
    level: 'Principiante',
    description: 'Repite tareas con for, for-in, while y do-while, y controla la iteración con break y continue.',
    whyItMatters: 'Recorrer listas, repetir validaciones y procesar conjuntos de datos son operaciones esenciales tanto en Dart como en Flutter.',
    code: r'''void main() {
  final cursos = ['Dart', 'Flutter', 'Git'];

  for (var i = 0; i < cursos.length; i++) {
    print('$i: ${cursos[i]}');
  }

  for (final curso in cursos) {
    if (curso == 'Flutter') continue;
    print(curso);
  }

  var contador = 3;
  while (contador > 0) {
    print(contador);
    contador--;
  }
}''',
    steps: [
      'Usa for cuando necesites controlar un índice.',
      'Usa for-in para recorrer elementos directamente.',
      'Usa while cuando no conozcas de antemano el número de repeticiones.',
      'Aplica break para salir y continue para saltar una iteración.',
    ],
    challenge: 'Recorre los números del 1 al 100 y muestra solo los que sean múltiplos de 3.',
    keywords: ['for', 'for-in', 'while', 'do-while', 'break', 'continue', 'bucles'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'dart-10-colecciones',
    group: 'Dart básico',
    title: '10 · Colecciones: List, Set y Map',
    level: 'Principiante',
    description: 'Guarda grupos de valores con List, elimina duplicados con Set y representa pares clave-valor con Map.',
    whyItMatters: 'Casi toda aplicación trabaja con colecciones: usuarios, productos, cursos, respuestas de APIs y estados de selección.',
    code: r'''void main() {
  final nombres = <String>['Ana', 'Luis'];
  nombres.add('Marta');

  final etiquetas = <String>{'dart', 'flutter', 'dart'};

  final usuario = <String, Object>{
    'nombre': 'Ana',
    'edad': 22,
    'activo': true,
  };

  print(nombres);
  print(etiquetas); // no repite dart
  print(usuario['nombre']);
}''',
    steps: [
      'Usa List cuando importe el orden y puedan existir repetidos.',
      'Usa Set cuando necesites valores únicos.',
      'Usa Map para relacionar claves con valores.',
      'Practica add, remove, contains, where, map y acceso por clave.',
    ],
    challenge: 'Crea una lista de productos, un Set de categorías y un Map con los datos de un producto seleccionado.',
    keywords: ['list', 'set', 'map', 'colecciones', 'where', 'map metodo'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'dart-11-funciones',
    group: 'Dart básico',
    title: '11 · Funciones y parámetros',
    level: 'Principiante',
    description: 'Crea funciones reutilizables con retorno, parámetros posicionales, opcionales, nombrados, valores por defecto y sintaxis de flecha.',
    whyItMatters: 'Separar tareas en funciones pequeñas reduce repetición y permite probar la lógica de forma independiente.',
    code: r'''double calcularTotal(
  double precio, {
  int cantidad = 1,
  double descuento = 0,
}) {
  final subtotal = precio * cantidad;
  return subtotal - descuento;
}

String formatearPrecio(double valor) => '\$${valor.toStringAsFixed(2)}';

void main() {
  final total = calcularTotal(25, cantidad: 3, descuento: 5);
  print(formatearPrecio(total));
}''',
    steps: [
      'Define el tipo de retorno y los tipos de parámetros.',
      'Usa parámetros nombrados para llamadas más legibles.',
      'Añade valores por defecto cuando tenga sentido.',
      'Usa => únicamente para funciones de una sola expresión.',
    ],
    challenge: 'Crea funciones para calcular subtotal, impuesto y total de una factura sin repetir fórmulas.',
    keywords: ['funciones', 'parametros', 'return', 'named parameters', 'arrow function'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'dart-12-scope',
    group: 'Dart básico',
    title: '12 · Alcance de variables y funciones anónimas',
    level: 'Principiante',
    description: 'Comprende scope local, variables externas, callbacks y funciones anónimas usadas con métodos como map, where y forEach.',
    whyItMatters: 'Flutter usa callbacks de forma constante. Entender qué variables puede ver una función evita errores y efectos inesperados.',
    code: r'''void main() {
  const minimo = 3;
  final numeros = [1, 2, 3, 4, 5];

  final filtrados = numeros.where((numero) {
    return numero >= minimo;
  }).toList();

  final dobles = filtrados.map((numero) => numero * 2).toList();
  print(dobles);
}''',
    steps: [
      'Distingue variables locales de valores definidos fuera de una función.',
      'Pasa una función como argumento de otra función.',
      'Escribe callbacks anónimos con (valor) { ... }.',
      'Combina where(), map() y toList() sin modificar la colección original.',
    ],
    challenge: 'Dada una lista de notas, filtra las aprobadas y transforma cada una a un texto como "Nota: 4.2".',
    keywords: ['scope', 'callback', 'funcion anonima', 'where', 'map', 'foreach'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'dart-13-null-safety',
    group: 'Dart básico',
    title: '13 · Null safety',
    level: 'Principiante',
    description: 'Diferencia tipos no-null y nullable, y usa ?, ??, ??=, ?. y ! de manera consciente.',
    whyItMatters: 'Null safety evita una gran clase de fallos. En Flutter aparece al trabajar con formularios, navegación, datos remotos y estado opcional.',
    code: r'''void main() {
  String nombre = 'Dart';
  String? apodo;

  final texto = apodo ?? nombre;
  print(texto.toUpperCase());
  print(apodo?.length);

  apodo ??= 'Sin apodo';
  print(apodo);
}''',
    steps: [
      'Usa Tipo? únicamente cuando null sea un estado válido.',
      'Proporciona valores alternativos con ??.',
      'Accede de forma segura con ?. cuando el receptor pueda ser null.',
      'Evita ! salvo que puedas demostrar que el valor no es null.',
    ],
    challenge: 'Modela un perfil con segundoNombre y telefono opcionales y muestra valores alternativos cuando no existan.',
    keywords: ['null safety', 'nullable', '??', '?.', 'null'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'dart-14-clases-objetos',
    group: 'Dart básico',
    title: '14 · Clases, objetos y constructores',
    level: 'Principiante',
    description: 'Modela información con clases, propiedades, constructores, parámetros nombrados, métodos, getters y objetos inmutables.',
    whyItMatters: 'En Flutter los datos suelen representarse como modelos tipados. Una buena clase concentra reglas y evita Maps sin estructura.',
    code: r'''class Libro {
  final String titulo;
  final String autor;
  bool prestado;

  Libro({
    required this.titulo,
    required this.autor,
    this.prestado = false,
  });

  String get estado => prestado ? 'Prestado' : 'Disponible';

  void prestar() {
    prestado = true;
  }
}

void main() {
  final libro = Libro(titulo: 'Dart desde cero', autor: 'Ana');
  libro.prestar();
  print(libro.estado);
}''',
    steps: [
      'Define propiedades con tipos concretos.',
      'Inicializa objetos mediante un constructor.',
      'Usa required para parámetros nombrados obligatorios.',
      'Añade métodos y getters cuando el comportamiento pertenezca al modelo.',
    ],
    challenge: 'Crea una clase CuentaBancaria con titular, saldo, depositar(), retirar() y un getter que indique si tiene fondos.',
    keywords: ['clases', 'objetos', 'constructor', 'required', 'getter', 'metodos'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'dart-15-poo',
    group: 'Dart básico',
    title: '15 · POO: herencia, interfaces y mixins',
    level: 'Intermedio',
    description: 'Introduce abstracción, herencia, sobrescritura, contratos con implements y reutilización de comportamiento con mixins.',
    whyItMatters: 'No todo debe resolverse con herencia, pero reconocer estas herramientas ayuda a leer APIs de Flutter y diseñar modelos extensibles.',
    code: r'''abstract class Notificable {
  void enviar();
}

mixin ConRegistro {
  void registrar(String mensaje) => print('LOG: $mensaje');
}

class NotificacionEmail with ConRegistro implements Notificable {
  @override
  void enviar() {
    registrar('Enviando correo');
    print('Correo enviado');
  }
}

void main() {
  final servicio = NotificacionEmail();
  servicio.enviar();
}''',
    steps: [
      'Usa abstract cuando una clase defina un contrato incompleto.',
      'Sobrescribe comportamiento con @override.',
      'Usa implements cuando quieras cumplir explícitamente una interfaz.',
      'Usa mixins para compartir comportamiento sin crear una jerarquía artificial.',
    ],
    challenge: 'Crea una interfaz Exportable y dos implementaciones: ReportePdf y ReporteCsv.',
    keywords: ['poo', 'herencia', 'implements', 'abstract', 'mixin', 'override'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'dart-16-excepciones',
    group: 'Dart básico',
    title: '16 · Errores y excepciones',
    level: 'Principiante',
    description: 'Maneja situaciones excepcionales con try, catch, on, finally y throw sin ocultar errores importantes.',
    whyItMatters: 'Datos inválidos, archivos, red y servicios externos pueden fallar. El programa debe responder de forma controlada.',
    code: r'''double dividir(double a, double b) {
  if (b == 0) {
    throw ArgumentError('El divisor no puede ser cero');
  }
  return a / b;
}

void main() {
  try {
    print(dividir(10, 0));
  } on ArgumentError catch (error) {
    print('Dato inválido: $error');
  } catch (error) {
    print('Error inesperado: $error');
  } finally {
    print('Proceso finalizado');
  }
}''',
    steps: [
      'Usa throw cuando una función no pueda cumplir su contrato.',
      'Captura errores esperados de forma específica con on.',
      'Usa catch para acceder al objeto de error.',
      'Reserva finally para limpieza que deba ejecutarse siempre.',
    ],
    challenge: 'Crea una función retirar(saldo, valor) que lance una excepción si el valor es inválido o supera el saldo.',
    keywords: ['try', 'catch', 'throw', 'finally', 'exception', 'errores'],
    accentValue: 0xFFF97316,
  ),
  CourseSection(
    id: 'dart-17-async',
    group: 'Dart básico',
    title: '17 · Future, async y await',
    level: 'Intermedio',
    description: 'Comprende operaciones asíncronas con Future, async y await, y captura errores de tareas que terminan más adelante.',
    whyItMatters: 'Flutter usa asincronía para HTTP, almacenamiento, archivos, bases de datos y muchas APIs de plataforma.',
    code: r'''Future<String> cargarUsuario() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return 'Laura';
}

Future<void> main() async {
  print('Cargando...');

  try {
    final usuario = await cargarUsuario();
    print('Usuario: $usuario');
  } catch (error) {
    print('No se pudo cargar: $error');
  }
}''',
    steps: [
      'Interpreta Future<T> como un valor que estará disponible después.',
      'Marca una función con async cuando necesite await.',
      'Espera el resultado con await sin bloquear el hilo de interfaz.',
      'Maneja también los errores de operaciones asíncronas.',
    ],
    challenge: 'Simula la carga de una lista de libros con Future.delayed y muestra un mensaje antes y después de esperar.',
    keywords: ['future', 'async', 'await', 'asincronia'],
    accentValue: 0xFF22D3EE,
  ),
  CourseSection(
    id: 'dart-18-imports-paquetes',
    group: 'Dart básico',
    title: '18 · Archivos, imports y paquetes',
    level: 'Principiante',
    description: 'Divide el programa en archivos, reutiliza código con import y entiende el papel de pubspec.yaml y dart pub.',
    whyItMatters: 'Un proyecto real no vive en un solo archivo. La organización modular será esencial cuando la ruta entre a Flutter.',
    code: r'''// lib/modelo/libro.dart
class Libro {
  final String titulo;
  const Libro(this.titulo);
}

// bin/main.dart
import '../lib/modelo/libro.dart';

void main() {
  const libro = Libro('Dart organizado');
  print(libro.titulo);
}''',
    steps: [
      'Mueve clases relacionadas a archivos separados.',
      'Importa únicamente las dependencias que necesita cada archivo.',
      'Conoce pubspec.yaml como manifiesto del proyecto y sus dependencias.',
      'Usa dart pub get para descargar paquetes declarados.',
    ],
    challenge: 'Separa una pequeña aplicación en main.dart, models/libro.dart y services/biblioteca_service.dart.',
    keywords: ['import', 'archivos', 'paquetes', 'pubspec', 'dart pub'],
    accentValue: 0xFFFACC15,
  ),
  CourseSection(
    id: 'dart-19-proyecto-integrador',
    group: 'Dart básico',
    title: '19 · Proyecto: biblioteca de consola',
    level: 'Principiante',
    description: 'Integra variables, colecciones, funciones, control de flujo, clases, null safety y manejo de errores en una biblioteca ejecutada por consola.',
    whyItMatters: 'Un proyecto pequeño obliga a conectar conceptos aislados y confirma que ya existe una base suficiente para empezar Flutter.',
    code: r'''class Libro {
  final int id;
  final String titulo;
  bool prestado;

  Libro({required this.id, required this.titulo, this.prestado = false});
}

void main() {
  final libros = <Libro>[
    Libro(id: 1, titulo: 'Dart básico'),
    Libro(id: 2, titulo: 'Flutter desde cero'),
  ];

  final disponibles = libros.where((libro) => !libro.prestado);

  for (final libro in disponibles) {
    print('${libro.id} - ${libro.titulo}');
  }
}''',
    steps: [
      'Modela Libro y Usuario mediante clases.',
      'Guarda los objetos en colecciones tipadas.',
      'Crea funciones para listar, buscar, prestar y devolver.',
      'Añade un menú con switch y repetición mediante while.',
      'Valida entradas y controla errores sin cerrar inesperadamente el programa.',
    ],
    challenge: 'Completa una biblioteca de consola con menú: listar, buscar, agregar, prestar, devolver y salir. Divide la solución en varios archivos.',
    keywords: ['proyecto', 'biblioteca', 'dart', 'integracion', 'consola'],
    accentValue: 0xFFFB7185,
  ),
];
