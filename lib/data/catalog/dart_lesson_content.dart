import '../../models/lesson_content.dart';

/// Contenido extendido de las 19 lecciones de Dart básico.
const dartLessonContent = <String, LessonContent>{
  'dart-01-introduccion': LessonContent(
    syntax: r"""void main() {
  print('Hola, Dart');
}

// Comentario de una línea
/* Comentario de varias líneas */""",
    concepts: [
      'main() es el punto de entrada de un programa Dart.',
      'Las instrucciones se organizan en bloques delimitados por llaves.',
      'La mayoría de sentencias terminan con punto y coma.',
      'print() permite observar valores mientras aprendes y depuras.',
    ],
    examples: [
      LessonExample(
        title: 'Primer programa',
        explanation: 'Ejecuta dos sentencias en orden dentro de main().',
        code: r"""void main() {
  print('Hola, Dart');
  print('Estoy aprendiendo programación');
}""",
        output: 'Hola, Dart\nEstoy aprendiendo programación',
      ),
      LessonExample(
        title: 'Comentarios y organización',
        explanation: 'Los comentarios explican intención, pero no se ejecutan.',
        code: r"""void main() {
  // Datos del curso
  print('Curso: Dart básico');

  /* Próximo objetivo:
     aprender variables */
  print('Lección 1 completada');
}""",
        output: 'Curso: Dart básico\nLección 1 completada',
      ),
    ],
    commonMistakes: [
      'Escribir código ejecutable fuera de una función.',
      'Olvidar cerrar paréntesis, llaves o comillas.',
      'Usar comentarios para repetir lo obvio en vez de explicar intención.',
    ],
    exercises: [
      PracticeExercise(title: 'Presentación', prompt: 'Imprime tu nombre, ciudad y profesión en tres líneas.'),
      PracticeExercise(title: 'Ficha del curso', prompt: 'Imprime un título y tres objetivos.', hint: 'Usa una llamada a print() por línea.'),
      PracticeExercise(title: 'Comentarios', prompt: 'Añade comentarios de una y varias líneas a un programa.'),
    ],
  ),
  'dart-02-variables-constantes': LessonContent(
    syntax: r"""String nombre = 'Ana';
var edad = 20;
final fecha = DateTime.now();
const iva = 0.19;""",
    concepts: [
      'Una variable guarda un valor asociado a un nombre.',
      'var infiere el tipo a partir del valor inicial.',
      'final se asigna una sola vez durante la ejecución.',
      'const representa una constante conocida al compilar.',
    ],
    examples: [
      LessonExample(
        title: 'Datos que cambian',
        explanation: 'Una variable normal puede recibir otro valor del mismo tipo.',
        code: r"""void main() {
  var puntos = 10;
  puntos = puntos + 5;
  print(puntos);
}""",
        output: '15',
      ),
      LessonExample(
        title: 'final frente a const',
        explanation: 'final puede calcularse en ejecución; const debe conocerse al compilar.',
        code: r"""void main() {
  final ahora = DateTime.now();
  const diasSemana = 7;
  print(ahora);
  print(diasSemana);
}""",
      ),
    ],
    commonMistakes: [
      'Intentar reasignar una variable final o const.',
      'Usar dynamic cuando el tipo puede expresarse claramente.',
      'Declarar como const un valor calculado en ejecución.',
    ],
    exercises: [
      PracticeExercise(title: 'Producto', prompt: 'Declara nombre, precio y cantidad; luego modifica la cantidad.'),
      PracticeExercise(title: 'IVA', prompt: 'Crea una constante para el IVA y calcula un total.'),
      PracticeExercise(title: 'Fecha', prompt: 'Guarda DateTime.now() en una variable final.', hint: 'DateTime.now() se resuelve en ejecución.'),
    ],
  ),
  'dart-03-tipos-datos': LessonContent(
    syntax: r"""int edad = 25;
double precio = 12.50;
num valor = 10;
String nombre = 'Dart';
bool activo = true;
Object dato = 'texto';
dynamic flexible = 5;""",
    concepts: [
      'int representa enteros y double números decimales.',
      'num es el tipo común de int y double.',
      'String representa texto y bool estados true/false.',
      'Object conserva seguridad; dynamic reduce comprobaciones del compilador.',
    ],
    examples: [
      LessonExample(
        title: 'Cálculo tipado',
        explanation: 'Los tipos numéricos pueden combinarse en expresiones.',
        code: r"""void main() {
  int cantidad = 3;
  double precio = 9.5;
  double total = cantidad * precio;
  print(total);
}""",
        output: '28.5',
      ),
      LessonExample(
        title: 'runtimeType',
        explanation: 'runtimeType ayuda a observar el tipo real de un valor.',
        code: r"""void main() {
  var nombre = 'Ana';
  var edad = 21;
  print(nombre.runtimeType);
  print(edad.runtimeType);
}""",
        output: 'String\nint',
      ),
    ],
    commonMistakes: [
      'Guardar valores decimales en int.',
      'Guardar como String un dato que después requiere cálculos.',
      'Abusar de dynamic y perder ayuda del compilador.',
    ],
    exercises: [
      PracticeExercise(title: 'Estudiante', prompt: 'Modela nombre, edad, promedio y estado activo con tipos adecuados.'),
      PracticeExercise(title: 'Factura', prompt: 'Declara cantidad, precio unitario y total.'),
      PracticeExercise(title: 'Inspección', prompt: 'Crea cinco valores e imprime runtimeType para cada uno.'),
    ],
  ),
  'dart-04-operadores': LessonContent(
    syntax: r"""a + b;   a - b;   a * b;
a / b;   a ~/ b;  a % b;
a == b;  a != b;  a >= b;
a > 0 && b > 0;
condicion ? valorA : valorB;""",
    concepts: [
      'Los operadores aritméticos transforman números.',
      'Los operadores relacionales producen bool.',
      '&&, || y ! combinan o invierten condiciones.',
      'El ternario expresa decisiones simples en una expresión.',
    ],
    examples: [
      LessonExample(
        title: 'División y residuo',
        explanation: '~/ devuelve división entera y % el residuo.',
        code: r"""void main() {
  print(10 / 3);
  print(10 ~/ 3);
  print(10 % 3);
}""",
        output: '3.3333333333333335\n3\n1',
      ),
      LessonExample(
        title: 'Validación compuesta',
        explanation: 'Combina requisitos con operadores lógicos.',
        code: r"""void main() {
  const edad = 20;
  const tieneEntrada = true;
  final puedeEntrar = edad >= 18 && tieneEntrada;
  print(puedeEntrar ? 'Puede entrar' : 'No puede entrar');
}""",
        output: 'Puede entrar',
      ),
    ],
    commonMistakes: [
      'Confundir = con ==.',
      'Dividir entre cero sin validar el divisor.',
      'Crear expresiones lógicas demasiado difíciles de leer.',
    ],
    exercises: [
      PracticeExercise(title: 'Calculadora', prompt: 'Calcula suma, resta, multiplicación, división y residuo.'),
      PracticeExercise(title: 'Acceso', prompt: 'Valida edad mínima y disponibilidad de cupo.'),
      PracticeExercise(title: 'Par o impar', prompt: 'Determina si un entero es par usando %.', hint: 'El residuo al dividir por 2 debe ser 0.'),
    ],
  ),
  'dart-05-strings': LessonContent(
    syntax: r"""String nombre = 'Ana';
String mensaje = 'Hola $nombre';
String calculo = 'Total: ${2 + 3}';
String multilinea = 'Línea 1\nLínea 2';
String ruta = r'C:\proyectos\flutter';""",
    concepts: [
      'String almacena secuencias de caracteres.',
      'La interpolación inserta variables o expresiones en texto.',
      'Los métodos de String permiten buscar, dividir y transformar.',
      'Las raw strings desactivan escapes e interpolación.',
    ],
    examples: [
      LessonExample(
        title: 'Interpolación',
        explanation: 'Usa $variable para un valor y ${expresion} para cálculos.',
        code: r"""void main() {
  const nombre = 'Sara';
  const edad = 22;
  print('Hola $nombre. El próximo año tendrás ${edad + 1}.');
}""",
        output: 'Hola Sara. El próximo año tendrás 23.',
      ),
      LessonExample(
        title: 'Transformar texto',
        explanation: 'Los métodos ayudan en búsquedas y formularios.',
        code: r"""void main() {
  final texto = '  Aprender Dart  ';
  print(texto.trim());
  print(texto.toLowerCase().contains('dart'));
  print('uno,dos,tres'.split(','));
}""",
        output: 'Aprender Dart\ntrue\n[uno, dos, tres]',
      ),
    ],
    commonMistakes: [
      'Olvidar llaves al interpolar una expresión.',
      'Comparar texto sin normalizar espacios o mayúsculas cuando no importan.',
      'Concatenar muchas piezas con + cuando la interpolación es más clara.',
    ],
    exercises: [
      PracticeExercise(title: 'Ficha', prompt: 'Construye una ficha con nombre, edad, ciudad y profesión.'),
      PracticeExercise(title: 'Normalización', prompt: 'Limpia espacios y convierte un texto a minúsculas.'),
      PracticeExercise(title: 'Etiquetas', prompt: 'Convierte "dart,flutter,git" en una lista con split().'),
    ],
  ),
  'dart-06-conversion-entrada': LessonContent(
    syntax: r"""int numero = int.parse('42');
int? seguro = int.tryParse('abc');
double precio = double.parse('19.5');
String texto = numero.toString();""",
    concepts: [
      'parse convierte texto válido y lanza una excepción si falla.',
      'tryParse devuelve null cuando no puede convertir.',
      'toString transforma un valor en texto.',
      'stdin.readLineSync() se usa en programas Dart de consola.',
    ],
    examples: [
      LessonExample(
        title: 'Conversión segura',
        explanation: 'tryParse permite validar sin lanzar una excepción.',
        code: r"""void main() {
  final edad = int.tryParse('20');
  if (edad == null) {
    print('Dato inválido');
  } else {
    print(edad + 1);
  }
}""",
        output: '21',
      ),
      LessonExample(
        title: 'Entrada por consola',
        explanation: 'dart:io permite leer texto en un programa de consola.',
        code: r"""import 'dart:io';

void main() {
  stdout.write('Nombre: ');
  final nombre = stdin.readLineSync() ?? 'Sin nombre';
  print('Hola $nombre');
}""",
      ),
    ],
    commonMistakes: [
      'Usar parse con entrada del usuario sin validarla.',
      'Forzar un valor nullable sin comprobar null.',
      'Importar dart:io en una aplicación web.',
    ],
    exercises: [
      PracticeExercise(title: 'Edad segura', prompt: 'Convierte un String a int con tryParse y maneja el caso inválido.'),
      PracticeExercise(title: 'Dos números', prompt: 'Lee dos números por consola y muestra operaciones básicas.'),
      PracticeExercise(title: 'Precio', prompt: 'Convierte "25.90" a double y aplica un 10% de descuento.'),
    ],
  ),
  'dart-07-condicionales': LessonContent(
    syntax: r"""if (condicion) {
  // caso verdadero
} else if (otraCondicion) {
  // alternativa
} else {
  // resto de casos
}""",
    concepts: [
      'if ejecuta un bloque cuando una condición es true.',
      'else if añade alternativas evaluadas en orden.',
      'else cubre cualquier caso restante.',
      'Las condiciones deben ser expresiones booleanas.',
    ],
    examples: [
      LessonExample(
        title: 'Clasificar una nota',
        explanation: 'Las condiciones se evalúan de arriba hacia abajo.',
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
        output: 'Aprobado',
      ),
      LessonExample(
        title: 'Condición compuesta',
        explanation: 'Un bloque puede depender de varios requisitos.',
        code: r"""void main() {
  const usuarioActivo = true;
  const edad = 19;
  if (usuarioActivo && edad >= 18) {
    print('Acceso concedido');
  }
}""",
        output: 'Acceso concedido',
      ),
    ],
    commonMistakes: [
      'Colocar primero una condición demasiado general.',
      'Anidar if cuando una expresión lógica sencilla basta.',
      'Comparar un bool con true en vez de usar la variable directamente.',
    ],
    exercises: [
      PracticeExercise(title: 'Edad', prompt: 'Distingue menor, adulto y adulto mayor.'),
      PracticeExercise(title: 'Descuentos', prompt: 'Aplica descuentos según el total de compra.'),
      PracticeExercise(title: 'Login', prompt: 'Valida usuario activo y contraseña correcta.'),
    ],
  ),
  'dart-08-switch': LessonContent(
    syntax: r"""switch (valor) {
  case opcionA:
    // ...
  case opcionB:
    // ...
  default:
    // ...
}

enum Estado { pendiente, listo, error }""",
    concepts: [
      'switch expresa múltiples casos con claridad.',
      'enum define un conjunto cerrado de valores.',
      'Un switch sobre enum puede cubrir todos los estados.',
      'default cubre valores no contemplados cuando es necesario.',
    ],
    examples: [
      LessonExample(
        title: 'Estado con enum',
        explanation: 'Los enums evitan textos libres para representar estados.',
        code: r"""enum Estado { cargando, listo, error }

void main() {
  const estado = Estado.listo;
  switch (estado) {
    case Estado.cargando:
      print('Cargando...');
    case Estado.listo:
      print('Contenido listo');
    case Estado.error:
      print('Ocurrió un error');
  }
}""",
        output: 'Contenido listo',
      ),
      LessonExample(
        title: 'Menú por opción',
        explanation: 'switch funciona bien para valores discretos conocidos.',
        code: r"""void main() {
  const opcion = 2;
  switch (opcion) {
    case 1:
      print('Crear');
    case 2:
      print('Listar');
    default:
      print('Salir');
  }
}""",
        output: 'Listar',
      ),
    ],
    commonMistakes: [
      'Usar String libres cuando el dominio debería ser enum.',
      'Olvidar cubrir estados importantes.',
      'Usar switch para una decisión binaria más clara con if.',
    ],
    exercises: [
      PracticeExercise(title: 'Semáforo', prompt: 'Crea un enum rojo, amarillo y verde y muestra la acción.'),
      PracticeExercise(title: 'Rol', prompt: 'Usa switch para admin, editor e invitado.'),
      PracticeExercise(title: 'Mes', prompt: 'Recibe 1 a 12 e imprime el nombre del mes.'),
    ],
  ),
  'dart-09-bucles': LessonContent(
    syntax: r"""for (var i = 0; i < 5; i++) {}
for (final item in items) {}
while (condicion) {}
do {} while (condicion);

break;
continue;""",
    concepts: [
      'for es útil cuando necesitas índice o repeticiones conocidas.',
      'for-in recorre directamente una colección.',
      'while repite mientras una condición sea true.',
      'break termina el bucle y continue salta una iteración.',
    ],
    examples: [
      LessonExample(
        title: 'Recorrer una lista',
        explanation: 'for-in expresa directamente la intención.',
        code: r"""void main() {
  final cursos = ['Dart', 'Flutter', 'Git'];
  for (final curso in cursos) {
    print(curso);
  }
}""",
        output: 'Dart\nFlutter\nGit',
      ),
      LessonExample(
        title: 'Filtrar con continue',
        explanation: 'continue omite el resto de la iteración actual.',
        code: r"""void main() {
  for (var i = 1; i <= 5; i++) {
    if (i == 3) continue;
    print(i);
  }
}""",
        output: '1\n2\n4\n5',
      ),
    ],
    commonMistakes: [
      'Crear un while cuya condición nunca cambia.',
      'Modificar una colección de forma insegura mientras se recorre.',
      'Usar índices cuando solo necesitas cada elemento.',
    ],
    exercises: [
      PracticeExercise(title: 'Tabla', prompt: 'Imprime la tabla del 7 del 1 al 10.'),
      PracticeExercise(title: 'Múltiplos', prompt: 'Muestra del 1 al 100 solo múltiplos de 3.'),
      PracticeExercise(title: 'Búsqueda', prompt: 'Usa break al encontrar el primer valor mayor que 50.'),
    ],
  ),
  'dart-10-colecciones': LessonContent(
    syntax: r"""final lista = <String>['A', 'B'];
final unicos = <String>{'dart', 'flutter'};
final mapa = <String, int>{'Ana': 20};

lista.add('C');
lista.where((item) => item.startsWith('A'));
lista.map((item) => item.toUpperCase());""",
    concepts: [
      'List conserva orden y permite repetidos.',
      'Set mantiene valores únicos.',
      'Map relaciona claves únicas con valores.',
      'where y map permiten filtrar y transformar colecciones.',
    ],
    examples: [
      LessonExample(
        title: 'List y métodos',
        explanation: 'Filtra y transforma sin modificar el original.',
        code: r"""void main() {
  final numeros = [1, 2, 3, 4, 5];
  final pares = numeros.where((n) => n.isEven).toList();
  final dobles = pares.map((n) => n * 2).toList();
  print(dobles);
}""",
        output: '[4, 8]',
      ),
      LessonExample(
        title: 'Map de datos',
        explanation: 'Map permite consultar un valor por su clave.',
        code: r"""void main() {
  final usuario = <String, Object>{
    'nombre': 'Ana',
    'edad': 22,
  };
  print(usuario['nombre']);
}""",
        output: 'Ana',
      ),
    ],
    commonMistakes: [
      'Acceder a un índice inexistente en List.',
      'Esperar duplicados dentro de un Set.',
      'Olvidar toList() cuando necesitas una List después de map o where.',
    ],
    exercises: [
      PracticeExercise(title: 'Inventario', prompt: 'Filtra productos con precio mayor que 50.'),
      PracticeExercise(title: 'Etiquetas únicas', prompt: 'Elimina duplicados usando Set.'),
      PracticeExercise(title: 'Directorio', prompt: 'Crea un Map nombre → teléfono y consulta un contacto.'),
    ],
  ),
  'dart-11-funciones': LessonContent(
    syntax: r"""int sumar(int a, int b) => a + b;

String saludar(String nombre, {String prefijo = 'Hola'}) {
  return '$prefijo $nombre';
}

void registrar(String nombre, [int? edad]) {}""",
    concepts: [
      'Una función agrupa comportamiento reutilizable.',
      'Los parámetros posicionales se identifican por orden.',
      'Los parámetros nombrados mejoran legibilidad.',
      'Los parámetros opcionales pueden usar valores por defecto.',
    ],
    examples: [
      LessonExample(
        title: 'Función con retorno',
        explanation: 'El tipo de retorno documenta qué produce la función.',
        code: r"""double calcularTotal(double precio, int cantidad) {
  return precio * cantidad;
}

void main() {
  print(calcularTotal(12.5, 3));
}""",
        output: '37.5',
      ),
      LessonExample(
        title: 'Parámetros nombrados',
        explanation: 'La llamada se vuelve autoexplicativa.',
        code: r"""String ficha({required String nombre, int edad = 0}) {
  return '$nombre - $edad años';
}

void main() {
  print(ficha(nombre: 'Ana', edad: 22));
}""",
        output: 'Ana - 22 años',
      ),
    ],
    commonMistakes: [
      'Crear funciones que hacen demasiadas tareas.',
      'Usar muchos parámetros posicionales del mismo tipo.',
      'Declarar un tipo de retorno incompatible.',
    ],
    exercises: [
      PracticeExercise(title: 'Área', prompt: 'Crea funciones para área de círculo y rectángulo.'),
      PracticeExercise(title: 'Descuento', prompt: 'Crea calcularDescuento con porcentaje nombrado.'),
      PracticeExercise(title: 'Validador', prompt: 'Crea esMayorDeEdad(int edad) que retorne bool.'),
    ],
  ),
  'dart-12-scope-callbacks': LessonContent(
    syntax: r"""final duplicar = (int n) => n * 2;

void ejecutar(void Function() accion) {
  accion();
}

items.map((item) => item.toString());""",
    concepts: [
      'El scope determina dónde existe una variable.',
      'Una función puede guardarse y pasarse como argumento.',
      'Un callback es una función ejecutada por otra función.',
      'Las funciones anónimas son comunes en colecciones y eventos.',
    ],
    examples: [
      LessonExample(
        title: 'Función anónima',
        explanation: 'Una función también puede ser un valor.',
        code: r"""void main() {
  final triplicar = (int n) => n * 3;
  print(triplicar(4));
}""",
        output: '12',
      ),
      LessonExample(
        title: 'Callback',
        explanation: 'ejecutar no necesita saber qué hará la acción.',
        code: r"""void ejecutar(void Function() accion) {
  print('Antes');
  accion();
  print('Después');
}

void main() {
  ejecutar(() => print('Acción'));
}""",
        output: 'Antes\nAcción\nDespués',
      ),
    ],
    commonMistakes: [
      'Usar una variable local fuera de su bloque.',
      'Ejecutar la función al pasarla cuando se esperaba la referencia.',
      'Meter demasiada lógica en un callback inline.',
    ],
    exercises: [
      PracticeExercise(title: 'Transformación', prompt: 'Usa map() con una función anónima para duplicar enteros.'),
      PracticeExercise(title: 'Ejecutor', prompt: 'Crea una función que reciba un callback y lo ejecute dos veces.'),
      PracticeExercise(title: 'Scope', prompt: 'Crea bloques anidados y prueba qué variables son accesibles.'),
    ],
  ),
  'dart-13-null-safety': LessonContent(
    syntax: r"""String nombre = 'Ana';
String? apodo;

final longitud = apodo?.length;
final visible = apodo ?? 'Sin apodo';

late String token;""",
    concepts: [
      'Un tipo sin ? no puede contener null.',
      'T? declara explícitamente que un valor puede ser null.',
      '?. y ?? trabajan con valores nullable de forma segura.',
      '! afirma que un valor no es null y debe usarse con cuidado.',
    ],
    examples: [
      LessonExample(
        title: 'Valor alternativo',
        explanation: '?? proporciona un valor cuando la izquierda es null.',
        code: r"""void main() {
  String? nombre;
  print(nombre ?? 'Invitado');
}""",
        output: 'Invitado',
      ),
      LessonExample(
        title: 'Acceso condicional',
        explanation: '?. evita llamar un miembro si el objeto es null.',
        code: r"""void main() {
  String? texto;
  print(texto?.toUpperCase());
  texto = 'dart';
  print(texto.toUpperCase());
}""",
        output: 'null\nDART',
      ),
    ],
    commonMistakes: [
      'Usar ! solo para silenciar al compilador.',
      'Hacer nullable una variable que siempre debería tener valor.',
      'Ignorar null después de tryParse.',
    ],
    exercises: [
      PracticeExercise(title: 'Perfil', prompt: 'Modela nombre obligatorio y segundo nombre opcional.'),
      PracticeExercise(title: 'tryParse', prompt: 'Maneja explícitamente un resultado nullable.'),
      PracticeExercise(title: 'Cadena segura', prompt: 'Obtén la longitud de un String? sin usar !.'),
    ],
  ),
  'dart-14-clases-objetos': LessonContent(
    syntax: r"""class Libro {
  Libro({required this.titulo, required this.autor});

  final String titulo;
  final String autor;

  void describir() {
    print('$titulo - $autor');
  }
}

final libro = Libro(titulo: 'Dart', autor: 'Ana');""",
    concepts: [
      'Una clase define datos y comportamiento relacionados.',
      'Un objeto es una instancia concreta.',
      'El constructor establece el estado inicial.',
      'Los métodos operan sobre el estado del objeto.',
    ],
    examples: [
      LessonExample(
        title: 'Clase Producto',
        explanation: 'El constructor nombrado hace clara la creación.',
        code: r"""class Producto {
  Producto({required this.nombre, required this.precio});
  final String nombre;
  final double precio;
  double precioConIva() => precio * 1.19;
}

void main() {
  final p = Producto(nombre: 'Libro', precio: 20);
  print(p.precioConIva());
}""",
        output: '23.8',
      ),
      LessonExample(
        title: 'Constructor alternativo',
        explanation: 'Los constructores nombrados representan distintas formas de crear.',
        code: r"""class Usuario {
  Usuario(this.nombre, this.activo);
  Usuario.invitado() : nombre = 'Invitado', activo = false;

  final String nombre;
  final bool activo;
}""",
      ),
    ],
    commonMistakes: [
      'Crear clases sin una responsabilidad clara.',
      'Dejar mutables campos que no deberían cambiar.',
      'Usar parámetros poco claros en constructores largos.',
    ],
    exercises: [
      PracticeExercise(title: 'Libro', prompt: 'Crea Libro con título, autor, año y método resumen().' ),
      PracticeExercise(title: 'Cuenta', prompt: 'Crea Cuenta con saldo, depositar y retirar.'),
      PracticeExercise(title: 'Invitado', prompt: 'Añade un constructor nombrado para un usuario invitado.'),
    ],
  ),
  'dart-15-poo': LessonContent(
    syntax: r"""abstract class Figura {
  double area();
}

class Cuadrado extends Figura {
  Cuadrado(this.lado);
  final double lado;

  @override
  double area() => lado * lado;
}

mixin ConAuditoria {
  void registrar() => print('Registrado');
}""",
    concepts: [
      'La abstracción expone contratos sin fijar todos los detalles.',
      'La herencia especializa una clase base.',
      'implements obliga a cumplir una interfaz.',
      'Los mixins reutilizan comportamiento sin jerarquías profundas.',
    ],
    examples: [
      LessonExample(
        title: 'Abstracción',
        explanation: 'Distintas figuras pueden responder a area().',
        code: r"""abstract class Figura {
  double area();
}

class Circulo implements Figura {
  Circulo(this.radio);
  final double radio;

  @override
  double area() => 3.1416 * radio * radio;
}""",
      ),
      LessonExample(
        title: 'Mixin',
        explanation: 'Comparte comportamiento sin forzar herencia.',
        code: r"""mixin ConLog {
  void log(String mensaje) => print('[LOG] $mensaje');
}

class Servicio with ConLog {
  void ejecutar() => log('Servicio ejecutado');
}""",
      ),
    ],
    commonMistakes: [
      'Crear jerarquías profundas solo para reutilizar código.',
      'Confundir extends con implements.',
      'Romper el contrato esperado al sobrescribir un método.',
    ],
    exercises: [
      PracticeExercise(title: 'Figuras', prompt: 'Crea Figura y dos implementaciones de area().' ),
      PracticeExercise(title: 'Notificación', prompt: 'Define Notificador e implementa Email y Push.'),
      PracticeExercise(title: 'Auditoría', prompt: 'Crea un mixin de auditoría y úsalo en dos clases.'),
    ],
  ),
  'dart-16-excepciones': LessonContent(
    syntax: r"""try {
  // operación que puede fallar
} on FormatException catch (error) {
  // error conocido
} catch (error, stackTrace) {
  // resto de errores
} finally {
  // siempre se ejecuta
}

throw ArgumentError('Dato inválido');""",
    concepts: [
      'Una excepción representa un fallo durante la ejecución.',
      'try delimita código que puede lanzar una excepción.',
      'catch y on reaccionan según el tipo de error.',
      'finally se ejecuta tanto si hubo error como si no.',
    ],
    examples: [
      LessonExample(
        title: 'Capturar FormatException',
        explanation: 'int.parse falla cuando el texto no es numérico.',
        code: r"""void main() {
  try {
    final numero = int.parse('abc');
    print(numero);
  } on FormatException {
    print('Número inválido');
  }
}""",
        output: 'Número inválido',
      ),
      LessonExample(
        title: 'Lanzar una excepción',
        explanation: 'Tu código puede impedir estados inválidos.',
        code: r"""void retirar(double saldo, double valor) {
  if (valor > saldo) {
    throw StateError('Saldo insuficiente');
  }
}""",
      ),
    ],
    commonMistakes: [
      'Usar catch vacío y ocultar fallos.',
      'Utilizar excepciones para decisiones normales.',
      'Mostrar detalles técnicos al usuario final.',
    ],
    exercises: [
      PracticeExercise(title: 'Conversión', prompt: 'Captura el error de int.parse con texto inválido.'),
      PracticeExercise(title: 'Validación', prompt: 'Lanza ArgumentError si un porcentaje está fuera de 0 a 100.'),
      PracticeExercise(title: 'Finally', prompt: 'Simula abrir y cerrar un recurso usando finally.'),
    ],
  ),
  'dart-17-async': LessonContent(
    syntax: r"""Future<String> cargar() async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return 'Listo';
}

void main() async {
  final resultado = await cargar();
  print(resultado);
}""",
    concepts: [
      'Future representa un valor disponible más adelante.',
      'async permite usar await.',
      'await espera un Future sin bloquear la interfaz de Flutter.',
      'Los errores asíncronos se manejan con try/catch.',
    ],
    examples: [
      LessonExample(
        title: 'Simular una tarea',
        explanation: 'Future.delayed ayuda a entender el orden.',
        code: r"""Future<String> obtenerMensaje() async {
  await Future<void>.delayed(const Duration(milliseconds: 300));
  return 'Datos listos';
}

void main() async {
  print('Inicio');
  print(await obtenerMensaje());
  print('Fin');
}""",
        output: 'Inicio\nDatos listos\nFin',
      ),
      LessonExample(
        title: 'Error asíncrono',
        explanation: 'await permite capturar errores del Future.',
        code: r"""Future<void> ejecutar() async {
  try {
    await Future<void>.error(Exception('Fallo'));
  } catch (error) {
    print('Error controlado: $error');
  }
}""",
      ),
    ],
    commonMistakes: [
      'Olvidar await y trabajar con Future<T> en lugar de T.',
      'Marcar todo async aunque no exista trabajo asíncrono.',
      'Ignorar errores de red o disco.',
    ],
    exercises: [
      PracticeExercise(title: 'Temporizador', prompt: 'Espera un segundo y retorna un mensaje.'),
      PracticeExercise(title: 'Secuencia', prompt: 'Ejecuta tres Futures en orden usando await.'),
      PracticeExercise(title: 'Error', prompt: 'Crea un Future que falle y maneja la excepción.'),
    ],
  ),
  'dart-18-imports-paquetes': LessonContent(
    syntax: r"""import 'dart:math';
import 'package:mi_app/modelos/libro.dart';

// pubspec.yaml
// dependencies:
//   paquete: ^1.0.0""",
    concepts: [
      'Cada archivo puede actuar como una librería Dart.',
      'import hace disponibles tipos y funciones de otra librería.',
      'package: apunta a archivos del proyecto o paquetes.',
      'pubspec.yaml declara dependencias, assets y metadatos.',
    ],
    examples: [
      LessonExample(
        title: 'Librería estándar',
        explanation: 'dart:math forma parte del SDK.',
        code: r"""import 'dart:math';

void main() {
  print(max(10, 25));
  print(pi);
}""",
        output: '25\n3.141592653589793',
      ),
      LessonExample(
        title: 'Separar archivos',
        explanation: 'Los modelos pueden vivir en archivos propios.',
        code: r"""// lib/modelos/libro.dart
class Libro {
  Libro(this.titulo);
  final String titulo;
}

// lib/main.dart
import 'modelos/libro.dart';""",
      ),
    ],
    commonMistakes: [
      'Crear importaciones circulares.',
      'Usar rutas relativas muy largas cuando package: es más claro.',
      'Editar dependencias sin ejecutar pub get.',
    ],
    exercises: [
      PracticeExercise(title: 'Modelo separado', prompt: 'Mueve Libro a su propio archivo e impórtalo.'),
      PracticeExercise(title: 'dart:math', prompt: 'Genera un número aleatorio con Random.'),
      PracticeExercise(title: 'Paquete', prompt: 'Explica qué hace pub get y dónde se declara una dependencia.'),
    ],
  ),
  'dart-19-proyecto-integrador': LessonContent(
    syntax: r"""class Libro {
  Libro({required this.titulo, required this.autor});

  final String titulo;
  final String autor;
  bool prestado = false;
}

final biblioteca = <Libro>[];""",
    concepts: [
      'El proyecto integra variables, control de flujo, colecciones, funciones y clases.',
      'La lógica debe dividirse en funciones pequeñas.',
      'Los datos del dominio conviene modelarlos con tipos propios.',
      'Las entradas inválidas deben manejarse sin cerrar el programa.',
    ],
    examples: [
      LessonExample(
        title: 'Buscar libros',
        explanation: 'Una búsqueda combina List, where y String.',
        code: r"""List<Libro> buscar(List<Libro> libros, String texto) {
  final consulta = texto.toLowerCase();
  return libros.where((libro) {
    return libro.titulo.toLowerCase().contains(consulta);
  }).toList();
}""",
      ),
      LessonExample(
        title: 'Cambiar estado',
        explanation: 'El objeto mantiene su estado de préstamo.',
        code: r"""void prestar(Libro libro) {
  if (libro.prestado) {
    print('Ese libro ya está prestado');
    return;
  }
  libro.prestado = true;
}""",
      ),
    ],
    commonMistakes: [
      'Escribir todo el programa dentro de main().',
      'Representar libros con índices mágicos o Maps sin tipos.',
      'No validar opciones del menú o entradas numéricas.',
    ],
    exercises: [
      PracticeExercise(title: 'Catálogo', prompt: 'Implementa agregar, listar y buscar libros.'),
      PracticeExercise(title: 'Préstamos', prompt: 'Añade prestar y devolver con validación de estado.'),
      PracticeExercise(title: 'Menú', prompt: 'Crea un menú que se repita hasta seleccionar Salir.', hint: 'Usa while y switch.'),
    ],
  ),
};
