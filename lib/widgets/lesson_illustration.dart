import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/course_section.dart';

class LessonIllustration extends StatelessWidget {
  const LessonIllustration({
    super.key,
    required this.section,
    this.compact = false,
  });

  final CourseSection section;
  final bool compact;

  String get asset {
    final group = section.group.toLowerCase();
    final id = section.id.toLowerCase();

    if (group.contains('proyecto')) {
      return 'assets/illustrations/project-build.svg';
    }
    if (group.contains('api') ||
        group.contains('datos') ||
        id.contains('persistencia')) {
      return 'assets/illustrations/data-api.svg';
    }
    if (group.contains('estado') || id.contains('estado')) {
      return 'assets/illustrations/state-flow.svg';
    }
    if (group.contains('dart')) {
      return 'assets/illustrations/dart-foundations.svg';
    }
    return 'assets/illustrations/flutter-ui.svg';
  }

  @override
  Widget build(BuildContext context) {
    final accent = Color(section.accentValue);
    final radius = BorderRadius.circular(compact ? 16 : 24);

    return Semantics(
      image: true,
      label: 'Ilustración de ${section.title}',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: .10),
              blurRadius: compact ? 10 : 24,
              offset: Offset(0, compact ? 4 : 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: AspectRatio(
            aspectRatio: compact ? 1.55 : 720 / 420,
            child: SvgPicture.asset(
              asset,
              fit: BoxFit.cover,
              placeholderBuilder: (_) => ColoredBox(
                color: accent.withValues(alpha: .08),
                child: Center(
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: accent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
