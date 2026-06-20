import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'core/model/automation_profile.dart';
import 'core/model/macro.dart';
import 'core/navigation/router.dart';
import 'core/providers/database_provider.dart';
import 'core/services/local_storage/local_storage_provider.dart';
import 'core/theme/app_theme.dart';

import 'core/services/isar_service.dart';
import 'core/engine/headless_engine.dart';

void main() async {
  // Ensure Flutter bindings are initialized before doing async work in main
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Await the asynchronous shared preferences initialization
  final sharedPreferences = await SharedPreferences.getInstance();

  // 2. Initialize IsarService
  final isarService = IsarService();
  final isarInstance = await isarService.db; // Ensure it's opened

  // Wrap the entire app in ProviderScope
  runApp(ProviderScope(

    // Override the uninitialized providers with the real instances
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      isarServiceProvider.overrideWithValue(isarService),
    ],
    child: const KeyMapperApp(),
  ));
}

class KeyMapperApp extends StatelessWidget {
  const KeyMapperApp({super.key});

  @override
  Widget build(BuildContext context ) {
    return MaterialApp.router(
      title: 'KeyMapper Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}