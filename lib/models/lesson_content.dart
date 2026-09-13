class LessonExample {
  const LessonExample({
    required this.title,
    required this.explanation,
    required this.code,
    this.output = '',
  });

  final String title;
  final String explanation;
  final String code;
  final String output;
}

class PracticeExercise {
  const PracticeExercise({
    required this.title,
    required this.prompt,
    this.hint = '',
  });

  final String title;
  final String prompt;
  final String hint;
}

class LessonContent {
  const LessonContent({
    this.syntax = '',
    this.concepts = const <String>[],
    this.examples = const <LessonExample>[],
    this.commonMistakes = const <String>[],
    this.exercises = const <PracticeExercise>[],
  });

  final String syntax;
  final List<String> concepts;
  final List<LessonExample> examples;
  final List<String> commonMistakes;
  final List<PracticeExercise> exercises;
}
