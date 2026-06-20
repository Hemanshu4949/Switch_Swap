import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_service.dart';
import 'shared_prefs_storage_service.dart';

part 'local_storage_provider.g.dart';

/// Provider for the SharedPreferences instance.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden in main.dart');
}

/// Provider for our abstract LocalStorageService.
@Riverpod(keepAlive: true)
LocalStorageService localStorageService(LocalStorageServiceRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPrefsStorageService(prefs);
}
