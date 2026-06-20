import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

class MainDashboard extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainDashboard({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // The IndexedStack managed by StatefulShellRoute
      floatingActionButton: navigationShell.currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColors.primaryContainer,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      color: AppColors.surface, // Replaced background with surface
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            context: context,
            index: 0,
            icon: Icons.dashboard_customize,
            label: 'Dashboard',
          ),
          _buildNavItem(
            context: context,
            index: 1,
            icon: Icons.tune,
            label: 'Triggers',
          ),
          _buildNavItem(
            context: context,
            index: 2,
            icon: Icons.show_chart,
            label: 'Macros',
          ),
          _buildNavItem(
            context: context,
            index: 3,
            icon: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isActive = navigationShell.currentIndex == index;

    return GestureDetector(
      onTap: () {
        // GoBranch switches to the requested branch.
        // If it's already the active branch, pop back to its initial location
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? AppColors.secondaryContainer : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              icon,
              color: isActive ? AppColors.onSecondaryContainer : AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
