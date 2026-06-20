// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'f408e555b3e0d2d83469490c669155da73aa7157';

/// Provider for the SharedPreferences instance.
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = Provider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef = ProviderRef<SharedPreferences>;
String _$localStorageServiceHash() =>
    r'bf5702ec0c9833e4d0d8aa7bcc489e8042dd8686';

/// Provider for our abstract LocalStorageService.
///
/// Copied from [localStorageService].
@ProviderFor(localStorageService)
final localStorageServiceProvider = Provider<LocalStorageService>.internal(
  localStorageService,
  name: r'localStorageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localStorageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalStorageServiceRef = ProviderRef<LocalStorageService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
