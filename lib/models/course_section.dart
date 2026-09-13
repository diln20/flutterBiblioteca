class CourseSection {
  final String id;
  final String group;
  final String title;
  final String level;
  final String description;
  final String whyItMatters;
  final String code;
  final List<String> steps;
  final String challenge;
  final List<String> keywords;
  final int accentValue;

  const CourseSection({
    required this.id,
    required this.group,
    required this.title,
    required this.level,
    required this.description,
    required this.whyItMatters,
    required this.code,
    required this.steps,
    required this.challenge,
    required this.keywords,
    required this.accentValue,
  });
}
