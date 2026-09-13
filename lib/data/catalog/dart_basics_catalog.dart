import '../../models/course_section.dart';

/// Primera etapa: fundamentos del lenguaje antes de comenzar con Flutter.
const dartBasicsCatalog = <CourseSection>[
  CourseSection(
    id: 'dart-01-introduccion',
    group: 'Dart básico',
    title: '01 · Qué es Dart y primer programa',
    level: 'Principiante',
    description: 'Conoce Dart, main(), sentencias, bloques, comentarios y print().',
    whyItMatters: 'Flutter se programa con Dart; primero hay que comprender el lenguaje.',
    code: r"""void main() {
  // Comentario de una línea
  print('Hola, Dart');

  /* Comentario de varias líneas */
  print('Mi primer programa');
}""",
    steps: ['Identifica main() como punto de entrada.', 'Usa print() para mostrar datos.', 'Diferencia sentencias, bloques y comentarios.', 'Usa lowerCamelCase para variables y funciones.'],
    challenge: 'Imprime tu nombre, ciudad y tres tecnologías que quieras aprender.',
    keywords: ['dart', 'main', 'print', 'comentarios', 'sintaxis'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-02-variables-constantes',
    group: 'Dart básico',
    title: '02 · Variables, final y const',
    level: 'Principiante',
    description: 'Declara datos con tipos explícitos, var, final y const.',
    whyItMatters: 'La declaración comunica si un dato puede cambiar y ayuda al compilador.',
    code: r"""void main() {
  String nombre = 'Ana';
  var edad = 20;
  double altura = 1.68;
  final fechaActual = DateTime.now();
  const pi = 3.141592;

  edad = 21;
  print('$nombre tiene $edad años y mide $altura m');
  print(fechaActual);
  print(pi);
}""",
    steps: ['Declara variables con tipo explícito.', 'Usa var cuando el tipo sea evidente.', 'Usa final para asignación única.', 'Usa const para constantes de compilación.'],
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
    steps: ['Usa int para enteros y double para decimales.', 'Usa num si aceptas int o double.', 'Usa String para texto y bool para estados.', 'Prefiere tipos concretos antes que dynamic.'],
    challenge: 'Representa un estudiante con nombre, edad, promedio, estado activo y código.',
    keywords: ['int', 'double', 'num', 'string', 'bool', 'object', 'dynamic'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-04-operadores',
    group: 'Dart básico',
    title: '04 · Operadores',
    level: 'Principiante',
    description: 'Practica operadores aritméticos, comparación, asignación, lógicos y ternarios.',
    whyItMatters: 'Los operadores permiten calcular, comparar y construir condiciones.',
    code: r"""void main() {
  var a = 10;
  var b = 3;
  print(a + b);
  print(a - b);
  print(a * b);
  print(a / b);
  print(a ~/ b);
  print(a % b);

  final cumple = a >= 10 && b != 0;
  final mensaje = cumple ? 'Válido' : 'No válido';
  print(mensaje);
}""",
    steps: ['Usa +, -, *, /, ~/ y %.', 'Compara con ==, !=, >, <, >= y <=.', 'Combina con &&, || y !.', 'Usa el ternario para decisiones pequeñas.'],
    challenge: 'Determina si una persona puede entrar a un evento según edad y entrada válida.',
    keywords: ['operadores', 'aritmetica', 'comparacion', 'logicos', 'ternario'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-05-strings',
    group: 'Dart básico',
    title: '05 · Strings e interpolación',
    level: 'Principiante',
    description: 'Aprende comillas, interpolación, saltos de línea, raw strings y métodos comunes.',
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
    steps: ['Crea String con comillas simples o dobles.', r'Interpola con $variable y ${expresion}.', r'Usa \n para un salto de línea.', 'Practica trim(), contains(), toUpperCase() y split().'],
    challenge: 'Construye una ficha de usuario con nombre, edad, profesión y ciudad.',
    keywords: ['string', 'interpolacion', 'texto', 'metodos'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-06-conversion-entrada',
    group: 'Dart básico',
    title: '06 · Conversión de tipos y entrada por consola',
    level: 'Principiante',
    description: 'Convierte texto con parse, tryParse y toString y conoce stdin para consola.',
    whyItMatters: 'La entrada externa suele llegar como texto y debe validarse.',
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
}""",
    steps: ['Usa parse() si el formato está garantizado.', 'Usa tryParse() para entradas inciertas.', 'Convierte a texto con toString().', 'Usa stdin.readLineSync() en programas de consola.'],
    challenge: 'Pide dos números, valídalos y muestra las cuatro operaciones básicas.',
    keywords: ['parse', 'tryparse', 'tostring', 'stdin', 'conversion'],
    accentValue: 0xFF60A5FA,
  ),
  CourseSection(
    id: 'dart-07-condicionales',
    group: 'Dart básico',
    title: '07 · if, else if y else',
    level: 'Principiante',
    description: 'Controla qué código se ejecuta según una o varias condiciones.',
    whyItMatters: 'Las apps toman decisiones para permisos, formularios y reglas de negocio.',
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
    steps: ['Escribe una condición booleana en if.', 'Añade alternativas con else if.', 'Usa else para el caso restante.', 'Evita anidamiento innecesario.'],
    challenge: 'Clasifica una compra por valor y aplica descuentos distintos.',
    keywords: ['if', 'else', 'else if', 'condicionales'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'dart-08-switch',
    group: 'Dart básico',
    title: '08 · switch y enum',
    level: 'Principiante',
    description: 'Representa opciones conocidas con enum y decide entre casos con switch.',
    whyItMatters: 'Los estados cerrados son más seguros como enum que como texto libre.',
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
    steps: ['Crea un enum para un conjunto cerrado.', 'Evalúa el valor con switch.', 'Cubre todos los casos.', 'Evita cadenas mágicas para estados.'],
    challenge: 'Crea DiaSemana y determina si es laboral o fin de semana.',
    keywords: ['switch', 'enum', 'case', 'estados'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'dart-09-bucles',
    group: 'Dart básico',
    title: '09 · for, for-in, while y do-while',
    level: 'Principiante',
    description: 'Repite tareas y controla iteraciones con break y continue.',
    whyItMatters: 'Recorrer colecciones y repetir validaciones es trabajo cotidiano.',
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
    steps: ['Usa for cuando necesites índice.', 'Usa for-in para elementos.', 'Usa while o do-while según la condición.', 'Usa break y continue para controlar el ciclo.'],
    challenge: 'Recorre del 1 al 100 y muestra solo los múltiplos de 3.',
    keywords: ['for', 'for-in', 'while', 'do-while', 'break', 'continue'],
    accentValue: 0xFF34D399,
  ),
  CourseSection(
    id: 'dart-10-colecciones',
    group: 'Dart básico',
    title: '10 · List, Set y Map',
    level: 'Principiante',
    description: 'Usa List para secuencias, Set para únicos y Map para clave-valor.',
    whyItMatters: 'La mayoría de datos de una app se manipulan como colecciones.',
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
    steps: ['Usa List cuando importe el orden.', 'Usa Set para valores únicos.', 'Usa Map para relacionar claves y valores.', 'Practica add, remove, contains, where y map.'],
    challenge: 'Crea productos en una List, categorías en un Set y un producto en un Map.',
    keywords: ['list', 'set', 'map', 'colecciones'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'dart-11-funciones',
    group: 'Dart básico',
    title: '11 · Funciones y parámetros',
    level: 'Principiante',
    description: 'Crea funciones con retorno, parámetros posicionales, nombrados y valores por defecto.',
    whyItMatters: 'Funciones pequeñas reducen repetición y facilitan pruebas.',
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
    steps: ['Define el tipo de retorno.', 'Usa parámetros nombrados.', 'Añade valores por defecto.', 'Usa => para una sola expresión.'],
    challenge: 'Separa subtotal, impuesto y total de una factura en funciones.',
    keywords: ['funciones', 'parametros', 'return', 'named parameters'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'dart-12-scope-callbacks',
    group: 'Dart básico',
    title: '12 · Scope, callbacks y funciones anónimas',
    level: 'Principiante',
    description: 'Comprende el alcance de variables y pasa funciones como argumentos.',
    whyItMatters: 'Flutter usa callbacks constantemente en eventos y widgets.',
    code: r"""void main() {
  const minimo = 3;
  final numeros = [1, 2, 3, 4, 5];

  final filtrados = numeros.where((numero) => numero >= minimo).toList();
  final dobles = filtrados.map((numero) => numero * 2).toList();

  print(dobles);
}""",
    steps: ['Distingue scope local y externo.', 'Pasa funciones como argumentos.', 'Escribe funciones anónimas.', 'Practica where(), map() y forEach().'],
    challenge: 'Filtra notas aprobadas y conviértelas a textos descriptivos.',
    keywords: ['scope', 'callback', 'funcion anonima', 'where', 'map'],
    accentValue: 0xFF2DD4BF,
  ),
  CourseSection(
    id: 'dart-13-null-safety',
    group: 'Dart básico',
    title: '13 · Null safety',
    level: 'Principiante',
    description: 'Diferencia tipos no-null y nullable y usa ?, ??, ??=, ?. y !.',
    whyItMatters: 'Null safety evita fallos comunes con datos opcionales.',
    code: r"""void main() {
  String nombre = 'Dart';
  String? apodo;

  final texto = apodo ?? nombre;
  print(texto.toUpperCase());
  print(apodo?.length);

  apodo ??= 'Sin apodo';
  print(apodo);
}""",
    steps: ['Usa Tipo? solo si null es válido.', 'Proporciona alternativas con ??.', 'Accede de forma segura con ?..', 'Evita ! salvo que puedas garantizar el valor.'],
    challenge: 'Modela un perfil con segundo nombre y teléfono opcionales.',
    keywords: ['null safety', 'nullable', 'null', '??', '?.'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'dart-14-clases-objetos',
    group: 'Dart básico',
    title: '14 · Clases, objetos y constructores',
    level: 'Principiante',
    description: 'Modela datos con clases, propiedades, constructores, métodos y getters.',
    whyItMatters: 'Los modelos tipados serán la base de los datos en Flutter.',
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

  void prestar() => prestado = true;
}

void main() {
  final libro = Libro(titulo: 'Dart desde cero', autor: 'Ana');
  libro.prestar();
  print(libro.estado);
}""",
    steps: ['Define propiedades tipadas.', 'Inicializa con constructores.', 'Usa required para datos obligatorios.', 'Añade métodos y getters al modelo.'],
    challenge: 'Crea CuentaBancaria con depositar(), retirar() y un getter de fondos.',
    keywords: ['clases', 'objetos', 'constructor', 'required', 'getter'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'dart-15-poo',
    group: 'Dart básico',
    title: '15 · POO: abstracción, herencia, interfaces y mixins',
    level: 'Intermedio',
    description: 'Conoce abstract, extends, implements, @override y mixins.',
    whyItMatters: 'Estas herramientas aparecen en APIs de Dart y Flutter.',
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
}""",
    steps: ['Usa abstract para contratos incompletos.', 'Sobrescribe con @override.', 'Usa implements para una interfaz.', 'Usa mixins para compartir comportamiento.'],
    challenge: 'Crea Exportable con implementaciones ReportePdf y ReporteCsv.',
    keywords: ['poo', 'herencia', 'implements', 'abstract', 'mixin'],
    accentValue: 0xFFA78BFA,
  ),
  CourseSection(
    id: 'dart-16-excepciones',
    group: 'Dart básico',
    title: '16 · Errores y excepciones',
    level: 'Principiante',
    description: 'Controla errores con try, catch, on, finally y throw.',
    whyItMatters: 'Entradas, archivos y servicios pueden fallar de forma esperable.',
    code: r"""double dividir(double a, double b) {
  if (b == 0) throw ArgumentError('El divisor no puede ser cero');
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
    steps: ['Usa throw cuando no puedas cumplir un contrato.', 'Captura errores específicos con on.', 'Inspecciona el error con catch.', 'Usa finally para limpieza obligatoria.'],
    challenge: 'Crea retirar(saldo, valor) y lanza errores para operaciones inválidas.',
    keywords: ['try', 'catch', 'throw', 'finally', 'exception'],
    accentValue: 0xFFF97316,
  ),
  CourseSection(
    id: 'dart-17-async',
    group: 'Dart básico',
    title: '17 · Future, async y await',
    level: 'Intermedio',
    description: 'Introduce operaciones asíncronas con Future, async y await.',
    whyItMatters: 'Flutter usa asincronía para red, almacenamiento y APIs de plataforma.',
    code: r"""Future<String> cargarUsuario() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return 'Laura';
}

Future<void> main() async {
  print('Cargando...');
  final usuario = await cargarUsuario();
  print('Usuario: $usuario');
}""",
    steps: ['Interpreta Future<T> como un valor futuro.', 'Marca funciones asíncronas con async.', 'Espera resultados con await.', 'Maneja errores asíncronos con try/catch.'],
    challenge: 'Simula la carga de una lista de libros con Future.delayed.',
    keywords: ['future', 'async', 'await', 'asincronia'],
    accentValue: 0xFF22D3EE,
  ),
  CourseSection(
    id: 'dart-18-imports-paquetes',
    group: 'Dart básico',
    title: '18 · Archivos, imports y paquetes',
    level: 'Principiante',
    description: 'Divide programas en archivos y conoce import, pubspec.yaml y dart pub.',
    whyItMatters: 'Un proyecto real necesita módulos y dependencias bien organizadas.',
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
    steps: ['Mueve clases a archivos separados.', 'Importa solo lo necesario.', 'Reconoce pubspec.yaml como manifiesto.', 'Usa dart pub get para dependencias.'],
    challenge: 'Separa una app en main.dart, models/libro.dart y services/biblioteca_service.dart.',
    keywords: ['import', 'archivos', 'paquetes', 'pubspec', 'dart pub'],
    accentValue: 0xFFFACC15,
  ),
  CourseSection(
    id: 'dart-19-proyecto-integrador',
    group: 'Dart básico',
    title: '19 · Proyecto: biblioteca de consola',
    level: 'Principiante',
    description: 'Integra variables, colecciones, funciones, control de flujo, clases, null safety y errores.',
    whyItMatters: 'El proyecto confirma que ya existe una base sólida antes de comenzar Flutter.',
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
    steps: ['Modela Libro y Usuario con clases.', 'Guarda objetos en colecciones tipadas.', 'Crea funciones para listar, buscar, prestar y devolver.', 'Añade un menú con switch dentro de while.', 'Valida entradas y maneja errores.'],
    challenge: 'Completa una biblioteca de consola con listar, buscar, agregar, prestar, devolver y salir.',
    keywords: ['proyecto', 'biblioteca', 'dart', 'integracion', 'consola'],
    accentValue: 0xFFFB7185,
  ),
];
