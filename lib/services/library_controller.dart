import 'package:flutter/foundation.dart';

import '../data/course_catalog.dart';
import '../models/course_section.dart';
import 'progress_store.dart';

class LibraryController extends ChangeNotifier {
  LibraryController({ProgressStore? store}) : _store = store ?? ProgressStore();

  final ProgressStore _store;
  final Set<String> favorites = <String>{};
  final Set<String> completed = <String>{};

  String selectedId = courseCatalog.first.id;
  String group = 'Todos';
  String query = '';
  bool favoritesOnly = false;
  bool initialized = false;

  List<String> get groups => <String>[
        'Todos',
        ...{for (final section in courseCatalog) section.group},
      ];

  CourseSection get selected => courseCatalog.firstWhere(
        (section) => section.id == selectedId,
        orElse: () => courseCatalog.first,
      );

  List<CourseSection> get filtered {
    final normalized = query.trim().toLowerCase();
    return courseCatalog.where((section) {
      final matchesGroup = group == 'Todos' || section.group == group;
      final matchesFavorite = !favoritesOnly || favorites.contains(section.id);
      final haystack = <String>[
        section.title,
        section.group,
        section.level,
        section.description,
        ...section.keywords,
      ].join(' ').toLowerCase();
      final matchesQuery = normalized.isEmpty || haystack.contains(normalized);
      return matchesGroup && matchesFavorite && matchesQuery;
    }).toList();
  }

  int get total => courseCatalog.length;

  double get progress => courseCatalog.isEmpty ? 0 : completed.length / courseCatalog.length;

  Future<void> initialize() async {
    final progress = await _store.load();
    final validIds = courseCatalog.map((section) => section.id).toSet();
    favorites
      ..clear()
      ..addAll(progress.favorites.where(validIds.contains));
    completed
      ..clear()
      ..addAll(progress.completed.where(validIds.contains));
    if (progress.selectedId != null && validIds.contains(progress.selectedId)) {
      selectedId = progress.selectedId!;
    }
    initialized = true;
    notifyListeners();
  }

  void setQuery(String value) {
    query = value;
    notifyListeners();
  }

  void setGroup(String value) {
    group = value;
    notifyListeners();
  }

  void toggleFavoritesOnly() {
    favoritesOnly = !favoritesOnly;
    notifyListeners();
  }

  void select(String id) {
    selectedId = id;
    notifyListeners();
    _persist();
  }

  void toggleFavorite(String id) {
    favorites.contains(id) ? favorites.remove(id) : favorites.add(id);
    notifyListeners();
    _persist();
  }

  void toggleCompleted(String id) {
    completed.contains(id) ? completed.remove(id) : completed.add(id);
    notifyListeners();
    _persist();
  }

  CourseSection? previousOf(CourseSection current) {
    final index = courseCatalog.indexWhere((section) => section.id == current.id);
    return index > 0 ? courseCatalog[index - 1] : null;
  }

  CourseSection? nextOf(CourseSection current) {
    final index = courseCatalog.indexWhere((section) => section.id == current.id);
    return index >= 0 && index < courseCatalog.length - 1 ? courseCatalog[index + 1] : null;
  }

  Future<void> _persist() => _store.save(
        favorites: favorites,
        completed: completed,
        selectedId: selectedId,
      );
}
