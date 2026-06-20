// lib/core/services/local_storage/shared_prefs_storage_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_service.dart';

/// The concrete implementation of [LocalStorageService] using SharedPreferences.
class SharedPrefsStorageService implements LocalStorageService {
  final SharedPreferences _prefs;

  // We require the SharedPreferences instance to be passed in via the constructor.
  // This is called "Dependency Injection".
  SharedPrefsStorageService(this._prefs);

  @override
  String? getString(String key) {
    return _prefs.getString(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
}
