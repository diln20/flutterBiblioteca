import '../../models/course_section.dart';

/// Primera etapa de la ruta: dominar Dart antes de comenzar con Flutter.
const dartBasicsCatalog = <CourseSection>[
  CourseSection(
    id: 'dart-01-introduccion',
    group: 'Dart básico',
    title: '01 · Qué es Dart y primer programa',
    level: 'Principiante',
    description: 'Conoce Dart, la función main(), las sentencias, los bloques, los comentarios y print().',
    whyItMatters: 'Flutter se programa con Dart. Primero hay que entender cómo se escribe y ejecuta el lenguaje.',
    code: r"""void main() {
  // Comentario de una línea
  print('Hola, Dart');

  /* Comentario de
     varias líneas */
  print('Mi primer programa');
}""",
    steps: [
      'Identifica main() como punto de entrada.',
      'Usa print() para mostrar información.',
      'Diferencia sentencias, bloques y comentarios.',
      'Usa lowerCamelCase para variables y funciones.',
    ],
    challenge: 'Imprime tu nombre, ciudad y tres tecnologías que quieras aprender.',
    keywords: ['dart', 'main', 'print', 'comentarios', 'sintaxis'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-02-variables-constantes',
    group: 'Dart básico',
    title: '02 · Variables, final y const',
    level: 'Principiante',
    description: 'Declara datos con tipos explícitos, var, final y const y aprende cuándo usar cada uno.',
    whyItMatters: 'La declaración comunica si un dato puede cambiar y permite que Dart detecte errores temprano.',
    code: r"""void main() {
  String nombre = 'Ana';
  var edad = 20;
  double altura = 1.68;

  final fechaActual = DateTime.now();
  const pi = 3.141592;

  edad = 21;
  print('$nombre tiene $edad años');
  print(fechaActual);
  print(pi);
}""",
    steps: [
      'Declara variables con tipo explícito.',
      'Usa var cuando el tipo sea evidente.',
      'Usa final para un valor asignado una sola vez.',
      'Usa const para constantes de tiempo de compilación.',
    ],
    challenge: 'Declara nombre, precio, cantidad e IVA de un producto y calcula el subtotal.',
    keywords: ['variables', 'var', 'final', 'const', 'inferencia'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-03-tipos-datos',
    group: 'Dart básico',
    title: '03 · Tipos de datos básicos',
    level: 'Principiante',
    description: 'Trabaja con int, double, num, String, bool, Object y dynamic.',
    whyItMatters: 'Un tipo correcto documenta el código y evita operaciones inválidas.',
    code: r"""void main() {
  int unidades = 4;
  double precio = 19.95;
  num descuento = 5;
  String categoria = 'Libros';
  bool disponible = true;
  Object dato = 'texto seguro';
  dynamic flexible = 10;

  print(unidades.runtimeType);
  print('$categoria - $disponible');
  print(dato);
  print(flexible);
}""",
    steps: [
      'Usa int para enteros y double para decimales.',
      'Usa num cuando aceptes int o double.',
      'Representa texto con String y estados con bool.',
      'Prefiere tipos concretos u Object antes que dynamic.',
    ],
    challenge: 'Representa un estudiante con nombre, edad, promedio, estado activo y código.',
    keywords: ['int', 'double', 'num', 'string', 'bool', 'object', 'dynamic'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-04-operadores',
    group: 'Dart básico',
    title: '04 · Operadores',
    level: 'Principiante',
    description: 'Practica operadores aritméticos, de asignación, comparación, lógicos e incremento.',
    whyItMatters: 'Los operadores forman expresiones para calcular, comparar y decidir.',
    code: r"""void main() {
  var a = 10;
  var b = 3;

  print(a + b);
  print(a - b);
  print(a * b);
  print(a / b);
  print(a ~/ b);
  print(a % b);

  final esMayor = a > b;
  final cumple = a >= 10 && b != 0;
  final mensaje = cumple ? 'Válido' : 'No válido';

  print(esMayor);
  print(mensaje);
}""",
    steps: [
      'Usa +, -, *, /, ~/ y %.',
      'Compara con ==, !=, >, <, >= y <=.',
      'Combina condiciones con &&, || y !.',
      'Usa el operador ternario para decisiones pequeñas.',
    ],
    challenge: 'Determina si una persona puede entrar a un evento según edad y entrada válida.',
    keywords: ['operadores', 'aritmetica', 'comparacion', 'logicos', 'ternario'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-05-strings',
    group: 'Dart básico',
    title: '05 · Strings e interpolación',
    level: 'Principiante',
    description: 'Aprende comillas, interpolación, texto multilínea, raw strings y métodos comunes.',
    whyItMatters: 'Las apps muestran, reciben, buscan y transforman texto constantemente.',
    code: r"""void main() {
  const nombre = 'Laura';
  const lenguaje = 'Dart';
  final mensaje = 'Hola $nombre, aprendes $lenguaje';
  final detalle = 'Curso: Dart básico\nEstado: En progreso';
  final ruta = r'C:\proyectos\flutter';

  print(mensaje);
  print(detalle);
  print(ruta);
  print(nombre.toUpperCase());
  print(mensaje.contains('Dart'));
}""",
    steps: [
      'Crea String con comillas simples o dobles.',
      'Interpola con $variable y ${expresion}.',
      'Representa saltos de línea con \n cuando corresponda.',
      'Practica trim(), contains(), toUpperCase() y split().',
    ],
    challenge: 'Construye una ficha de usuario con nombre, edad, profesión y ciudad usando interpolación.',
    keywords: ['string', 'interpolacion', 'texto', 'metodos'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-06-conversion-entrada',
    group: 'Dart básico',
    title: '06 · Conversión de tipos y entrada por consola',
    level: 'Principiante',
    description: 'Convierte texto a números con parse y tryParse, y conoce stdin en programas de consola.',
    whyItMatters: 'La entrada externa suele ser texto y debe validarse antes de usarla.',
    code: r"""import 'dart:io';

void main() {
  stdout.write('Escribe tu edad: ');
  final texto = stdin.readLineSync();
  final edad = int.tryParse(texto ?? '');

  if (edad == null) {
    print('Edad inválida');
    return;
  }

  print('El próximo año tendrás ${edad + 1} años');
  print(edad.toString());
}""",
    steps: [
      'Usa int.parse() o double.parse() si el formato está garantizado.',
      'Usa tryParse() cuando la entrada pueda ser inválida.',
      'Convierte valores a texto con toString().',
      'Usa stdin.readLineSync() solo en programas Dart de consola.',
    ],
    challenge: 'Pide dos números, valida ambos y muestra suma, resta, multiplicación y división.',
    keywords: ['parse', 'tryparse', 'tostring', 'stdin', 'conversion'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-07-condicionales',
    group: 'Dart básico',
    title: '07 · Condicionales: if, else if y else',
    level: 'Principiante',
    description: 'Decide qué código se ejecuta usando condiciones simples y compuestas.',
    whyItMatters: 'Las apps validan permisos, formularios, estados y reglas de negocio con condiciones.',
    code: r"""void main() {
  const nota = 4.2;

  if (nota >= 4.5) {
    print('Excelente');
  } else if (nota >= 3.0) {
    print('Aprobado');
  } else {
    print('Reprobado');
  }
}""",
    steps: [
      'Escribe condiciones booleanas en if.',
      'Añade alternativas con else if.',
      'Usa else para el caso restante.',
      'Combina condiciones sin anidamiento innecesario.',
    ],
    challenge: 'Clasifica una compra como pequeña, mediana o grande y aplica un descuento distinto.',
    keywords: ['if', 'else', 'else if', 'condicionales'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'dart-08-switch',
    group: 'Dart básico',
    title: '08 · switch y enum',
    level: 'Principiante',
    description: 'Modela opciones conocidas con enum y decide entre casos mediante switch.',
    whyItMatters: 'Los estados cerrados son más seguros como enum que como cadenas de texto libres.',
    code: r"""enum EstadoPedido { creado, enviado, entregado, cancelado }

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
}""",
    steps: [
      'Crea un enum para un conjunto cerrado.',
      'Evalúa el valor con switch.',
      'Cubre todos los casos.',
      'Evita cadenas mágicas para estados conocidos.',
    ],
    challenge: 'Crea DiaSemana y usa switch para indicar si es laboral o fin de semana.',
    keywords: ['switch', 'enum', 'case', 'estados'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'dart-09-bucles',
    group: 'Dart básico',
    title: '09 · Bucles: for, for-in, while y do-while',
    level: 'Principiante',
    description: 'Repite tareas y controla iteraciones con break y continue.',
    whyItMatters: 'Recorrer colecciones y repetir validaciones es parte del trabajo diario con datos.',
    code: r"""void main() {
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
}""",
    steps: [
      'Usa for cuando necesites un índice.',
      'Usa for-in para recorrer elementos.',
      'Usa while o do-while cuando dependa de una condición.',
      'Usa break para salir y continue para saltar.',
    ],
    challenge: 'Recorre del 1 al 100 y muestra solo los múltiplos de 3.',
    keywords: ['for', 'for-in', 'while', 'do-while', 'break', 'continue'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'dart-10-colecciones',
    group: 'Dart básico',
    title: '10 · Colecciones: List, Set y Map',
    level: 'Principiante',
    description: 'Guarda secuencias con List, valores únicos con Set y pares clave-valor con Map.',
    whyItMatters: 'Usuarios, productos, cursos y respuestas de APIs se representan mediante colecciones.',
    code: r"""void main() {
  final nombres = <String>['Ana', 'Luis'];
  nombres.add('Marta');

  final etiquetas = <String>{'dart', 'flutter', 'dart'};

  final usuario = <String, Object>{
    'nombre': 'Ana',
    'edad': 22,
    'activo': true,
  };

  print(nombres);
  print(etiquetas);
  print(usuario['nombre']);
}""",
    steps: [
      'Usa List cuando importe el orden.',
      'Usa Set para valores únicos.',
      'Usa Map para relacionar claves con valores.',
      'Practica add, remove, contains, where y map.',
    ],
    challenge: 'Crea una lista de productos, un Set de categorías y un Map para un producto seleccionado.',
    keywords: ['list', 'set', 'map', 'colecciones'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'dart-11-funciones',
    group: 'Dart básico',
    title: '11 · Funciones y parámetros',
    level: 'Principiante',
    description: 'Crea funciones con retorno, parámetros posicionales, nombrados, opcionales y valores por defecto.',
    whyItMatters: 'Funciones pequeñas eliminan repetición y permiten probar la lógica de forma independiente.',
    code: r"""double calcularTotal(
  double precio, {
  int cantidad = 1,
  double descuento = 0,
}) {
  final subtotal = precio * cantidad;
  return subtotal - descuento;
}

String formatearPrecio(double valor) =>
    '\$${valor.toStringAsFixed(2)}';

void main() {
  final total = calcularTotal(25, cantidad: 3, descuento: 5);
  print(formatearPrecio(total));
}""",
    steps: [
      'Define el tipo de retorno.',
      'Usa parámetros nombrados para mejorar legibilidad.',
      'Añade valores por defecto cuando tenga sentido.',
      'Usa => para una sola expresión.',
    ],
    challenge: 'Crea funciones separadas para subtotal, impuesto y total de una factura.',
    keywords: ['funciones', 'parametros', 'return', 'named parameters'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'dart-12-scope-callbacks',
    group: 'Dart básico',
    title: '12 · Scope, callbacks y funciones anónimas',
    level: 'Principiante',
    description: 'Comprende el alcance de variables y pasa funciones como argumentos usando callbacks.',
    whyItMatters: 'Flutter usa callbacks constantemente para botones, formularios, listas y eventos.',
    code: r"""void main() {
  const minimo = 3;
  final numeros = [1, 2, 3, 4, 5];

  final filtrados = numeros.where((numero) {
    return numero >= minimo;
  }).toList();

  final dobles = filtrados.map((numero) => numero * 2).toList();
  print(dobles);
}""",
    steps: [
      'Distingue variables locales y externas.',
      'Pasa funciones como argumentos.',
      'Escribe funciones anónimas.',
      'Practica where(), map() y forEach().',
    ],
    challenge: 'Filtra notas aprobadas y transforma cada una a un texto descriptivo.',
    keywords: ['scope', 'callback', 'funcion anonima', 'where', 'map'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'dart-13-null-safety',
    group: 'Dart básico',
    title: '13 · Null safety',
    level: 'Principiante',
    description: 'Diferencia tipos no-null y nullable y usa ?, ??, ??=, ?. y !.',
    whyItMatters: 'Null safety evita fallos comunes al trabajar con formularios, red, navegación y datos opcionales.',
    code: r"""void main() {
  String nombre = 'Dart';
  String? apodo;

  final texto = apodo ?? nombre;
  print(texto.toUpperCase());
  print(apodo?.length);

  apodo ??= 'Sin apodo';
  print(apodo);
}""",
    steps: [
      'Usa Tipo? solo si null es válido.',
      'Proporciona alternativas con ??.',
      'Accede de forma segura con ?..',
      'Evita ! salvo que puedas garantizar el valor.',
    ],
    challenge: 'Crea un perfil con segundoNombre y teléfono opcionales y valores alternativos.',
    keywords: ['null safety', 'nullable', 'null', '??', '?.'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'dart-14-clases-objetos',
    group: 'Dart básico',
    title: '14 · Clases, objetos y constructores',
    level: 'Principiante',
    description: 'Modela datos con clases, propiedades, constructores, métodos y getters.',
    whyItMatters: 'Los modelos tipados son la base para representar datos de una app Flutter.',
    code: r"""class Libro {
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
}""",
    steps: [
      'Define propiedades con tipos concretos.',
      'Inicializa objetos con constructores.',
      'Usa required para datos obligatorios.',
      'Añade métodos y getters al modelo correcto.',
    ],
    challenge: 'Crea CuentaBancaria con titular, saldo, depositar(), retirar() y un getter de fondos.',
    keywords: ['clases', 'objetos', 'constructor', 'required', 'getter'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'dart-15-poo',
    group: 'Dart básico',
    title: '15 · POO: abstracción, herencia, interfaces y mixins',
    level: 'Intermedio',
    description: 'Conoce abstract, extends, implements, @override y mixins para reutilizar y especializar comportamiento.',
    whyItMatters: 'Estas herramientas aparecen al leer APIs de Dart y Flutter y al diseñar modelos extensibles.',
    code: r"""abstract class Notificable {
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
}""",
    steps: [
      'Usa abstract para contratos incompletos.',
      'Sobrescribe comportamiento con @override.',
      'Usa implements para cumplir una interfaz.',
      'Usa mixins para compartir comportamiento.',
    ],
    challenge: 'Crea una interfaz Exportable y dos implementaciones: ReportePdf y ReporteCsv.',
    keywords: ['poo', 'herencia', 'implements', 'abstract', 'mixin'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'dart-16-excepciones',
    group: 'Dart básico',
    title: '16 · Errores y excepciones',
    level: 'Principiante',
    description: 'Controla situaciones excepcionales con try, catch, on, finally y throw.',
    whyItMatters: 'Entradas, archivos, red y servicios pueden fallar y la app debe reaccionar de manera controlada.',
    code: r"""double dividir(double a, double b) {
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
}""",
    steps: [
      'Usa throw cuando una función no pueda cumplir su contrato.',
      'Captura errores esperados de forma específica.',
      'Usa catch para inspeccionar el error.',
      'Usa finally para limpieza obligatoria.',
    ],
    challenge: 'Crea retirar(saldo, valor) y lanza una excepción ante valores inválidos.',
    keywords: ['try', 'catch', 'throw', 'finally', 'exception'],
    accentValue: 0xFFF97316,
  ),
  CourseSection(
    id: 'dart-17-async',
    group: 'Dart básico',
    title: '17 · Future, async y await',
    level: 'Intermedio',
    description: 'Introduce operaciones asíncronas con Future, async y await.',
    whyItMatters: 'Flutter usa asincronía para HTTP, almacenamiento, archivos y APIs de plataforma.',
    code: r"""Future<String> cargarUsuario() async {
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
}""",
    steps: [
      'Interpreta Future<T> como un valor futuro.',
      'Marca con async una función que necesite await.',
      'Espera resultados con await.',
      'Maneja errores de operaciones asíncronas.',
    ],
    challenge: 'Simula la carga de libros con Future.delayed y muestra estados antes y después.',
    keywords: ['future', 'async', 'await', 'asincronia'],
    accentValue: 0xFF22D3EE,
  ),
  CourseSection(
    id: 'dart-18-imports-paquetes',
    group: 'Dart básico',
    title: '18 · Archivos, imports y paquetes',
    level: 'Principiante',
    description: 'Divide el programa en archivos y entiende import, pubspec.yaml y dart pub.',
    whyItMatters: 'Un proyecto real no debe vivir en un único archivo y Flutter depende de esta organización.',
    code: r"""// lib/modelo/libro.dart
class Libro {
  final String titulo;
  const Libro(this.titulo);
}

// bin/main.dart
import '../lib/modelo/libro.dart';

void main() {
  const libro = Libro('Dart organizado');
  print(libro.titulo);
}""",
    steps: [
      'Mueve clases a archivos separados.',
      'Importa solo las dependencias necesarias.',
      'Reconoce pubspec.yaml como manifiesto.',
      'Usa dart pub get para descargar dependencias.',
    ],
    challenge: 'Separa una app en main.dart, models/libro.dart y services/biblioteca_service.dart.',
    keywords: ['import', 'archivos', 'paquetes', 'pubspec', 'dart pub'],
    accentValue: 0xFFFACC15,
  ),
  CourseSection(
    id: 'dart-19-proyecto-integrador',
    group: 'Dart básico',
    title: '19 · Proyecto: biblioteca de consola',
    level: 'Principiante',
    description: 'Integra variables, colecciones, funciones, control de flujo, clases, null safety y errores en un proyecto de consola.',
    whyItMatters: 'Un proyecto integrador confirma que la base de Dart está lista antes de empezar con widgets y Flutter.',
    code: r"""class Libro {
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
}""",
    steps: [
      'Modela Libro y Usuario con clases.',
      'Guarda objetos en colecciones tipadas.',
      'Crea funciones para listar, buscar, prestar y devolver.',
      'Añade un menú con switch dentro de un while.',
      'Valida entradas y maneja errores.',
    ],
    challenge: 'Completa una biblioteca de consola con listar, buscar, agregar, prestar, devolver y salir, dividida en varios archivos.',
    keywords: ['proyecto', 'biblioteca', 'dart', 'integracion', 'consola'],
    accentValue: 0xFFFB7185,
  ),
];
