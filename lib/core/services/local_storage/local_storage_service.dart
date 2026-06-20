// lib/core/services/local_storage/local_storage_service.dart

/// A contract defining the capabilities of our local storage.
/// The rest of the app relies on this interface, not a specific package.
abstract class LocalStorageService {
  // We'll likely store Macros and Triggers as JSON strings.
  String? getString(String key);
  Future<void> setString(String key, String value);
  Future<void> remove(String key);
  Future<void> clear();
}
