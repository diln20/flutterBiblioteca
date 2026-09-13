import 'package:shared_preferences/shared_preferences.dart';

class LibraryProgress {
  final Set<String> favorites;
  final Set<String> completed;
  final String? selectedId;

  const LibraryProgress({
    required this.favorites,
    required this.completed,
    required this.selectedId,
  });
}

class ProgressStore {
  static const _favoritesKey = 'library_favorites_v2';
  static const _completedKey = 'library_completed_v2';
  static const _selectedKey = 'library_selected_v2';

  Future<LibraryProgress> load() async {
    final prefs = await SharedPreferences.getInstance();
    return LibraryProgress(
      favorites: (prefs.getStringList(_favoritesKey) ?? const <String>[]).toSet(),
      completed: (prefs.getStringList(_completedKey) ?? const <String>[]).toSet(),
      selectedId: prefs.getString(_selectedKey),
    );
  }

  Future<void> save({
    required Set<String> favorites,
    required Set<String> completed,
    required String? selectedId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, favorites.toList()..sort());
    await prefs.setStringList(_completedKey, completed.toList()..sort());
    if (selectedId == null) {
      await prefs.remove(_selectedKey);
    } else {
      await prefs.setString(_selectedKey, selectedId);
    }
  }
}
