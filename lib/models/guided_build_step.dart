class GuidedBuildStep {
  const GuidedBuildStep({
    required this.number,
    required this.total,
    required this.title,
    required this.goal,
    required this.createFiles,
    required this.modifyFiles,
    required this.tasks,
    required this.expectedResult,
    required this.checkpoint,
    this.commands = const <String>[],
  });

  final int number;
  final int total;
  final String title;
  final String goal;
  final List<String> createFiles;
  final List<String> modifyFiles;
  final List<String> tasks;
  final String expectedResult;
  final String checkpoint;
  final List<String> commands;
}
