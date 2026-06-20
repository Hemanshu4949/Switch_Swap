import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/actions/screens/action_selection_screen.dart';
import '../../features/actions/screens/action_selector.dart';
import '../../features/actions/screens/macro_builder.dart';
import '../../features/actions/screens/macro_selection_screen.dart';
import '../../features/constraints/screens/constraints_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/triggers/screen/trigger_screen.dart';
import 'main_dashboard.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// We need a GlobalKey for each tab's nested navigator
final _dashboardNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'dashboardNav');
final _triggersNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'triggersNav');
final _macrosNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'macrosNav');
final _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settingsNav');

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // The navigationShell is passed to the custom dashboard
          return MainDashboard(navigationShell: navigationShell);
        },
        branches: [
          // 1. Dashboard Branch
          StatefulShellBranch(
            navigatorKey: _dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const KeyMapperHomeScreen(),
              ),
            ],
          ),

          // 2. Triggers Branch (The Wizard Flow)
          StatefulShellBranch(
            navigatorKey: _triggersNavigatorKey,
            routes: [
              GoRoute(
                path: '/trigger',
                builder: (context, state) => const TriggerConfigScreen(),
                routes: [
                  // Sub-route: /trigger/action
                  GoRoute(
                    path: 'action',
                    builder: (context, state) => const MacroSelectionScreen(),
                    routes: [
                      // Sub-route: /trigger/action/select (for the standalone picker)
                      GoRoute(
                        path: 'select',
                        builder: (context, state) => const ActionSelectionScreen(),
                      ),
                    ],
                  ),
                  // Sub-route: /trigger/constraints
                  GoRoute(
                    path: 'constraints',
                    builder: (context, state) => const ConstraintsScreen(),
                  ),
                ],
              ),
            ],
          ),

          // 3. Macros Branch
          StatefulShellBranch(
            navigatorKey: _macrosNavigatorKey,
            routes: [
              GoRoute(
                path: '/macros',
                builder: (context, state) => const MacroBuilderScreen(),
                routes: [
                  GoRoute(
                    path: 'actions',
                    builder: (context, state) => const ActionSelectionScreen(),
                  ),
                ],
              ),
            ],
          ),

          // 4. Settings Branch
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const PlaceholderScreen(title: 'Settings Canvas'),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

// Temporary Placeholder Screen for Settings
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          title,
          style: textTheme.headlineMedium,
        ),
      ),
    );
  }
}
