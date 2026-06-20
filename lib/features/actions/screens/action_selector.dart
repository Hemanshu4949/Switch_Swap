import 'package:flutter/material.dart';

import '../../../core/model/action_ui_model.dart';
import '../widgets/category_header.dart';
import '../widgets/list_card.dart';
import 'package:go_router/go_router.dart';


class ActionSelectorScreen extends StatelessWidget {
  const ActionSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      // Top Branding AppBar (Matching the Home Screen)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: colorScheme.primary),
        title: Text(
          'KeyMapper Pro',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.bolt, color: colorScheme.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Back Button and Screen Title
            Row(
              children: [
                InkWell(
                  onTap: () => context.pop(), // Basic pop navigation
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Select Action',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2. Search Bar
            // Inherits the beautiful styles from app_theme.dart!
            TextField(
              decoration: InputDecoration(
                hintText: 'Search over 100+ commands...',
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
              ),
            ),
            const SizedBox(height: 8),

            // 3. Category: System Toggles
            ActionCategoryHeader(
              title: 'System Toggles',
              indicatorColor: colorScheme.primary, // Red/Coral
            ),
            _buildSystemToggles(colorScheme , context),

            // 4. Category: Text Injection
            ActionCategoryHeader(
              title: 'Text Injection',
              indicatorColor: colorScheme.secondary, // Purple
            ),
            _buildTextInjection(colorScheme , context),

            // 5. Category: Media
            ActionCategoryHeader(
              title: 'Media',
              indicatorColor: colorScheme.tertiary, // Green
            ),
            _buildMedia(colorScheme , context),

            // 6. Category: Shell Commands
            ActionCategoryHeader(
              title: 'Shell Commands',
              indicatorColor: colorScheme.onSurface, // Black/Dark
            ),
            _buildShellCommands(colorScheme , context),

            const SizedBox(height: 40), // Bottom padding
          ],
        ),
      ),
    );
  }

  // --- Dummy Data Builders ---
  // In a real app, this data would come from your Riverpod Provider!

  Widget _buildSystemToggles(ColorScheme colorScheme , BuildContext context) {
    final actions = [
      ActionItemModel(
        title: 'Toggle Wi-Fi',
        subtitle: 'Enable or disable wireless networking.',
        icon: Icons.wifi,
        iconColor: colorScheme.secondary,
        iconBackgroundColor: colorScheme.secondaryContainer.withValues(alpha: 0.3),
      ),
      ActionItemModel(
        title: 'Toggle Bluetooth',
        subtitle: 'Switch Bluetooth radio state.',
        icon: Icons.bluetooth,
        iconColor: colorScheme.secondary,
        iconBackgroundColor: colorScheme.secondaryContainer.withValues(alpha: 0.3),
      ),
      ActionItemModel(
        title: 'Flashlight',
        subtitle: 'Instantly activate device flashlight.',
        icon: Icons.flashlight_on,
        iconColor: colorScheme.secondary,
        iconBackgroundColor: colorScheme.secondaryContainer.withValues(alpha: 0.3),
      ),
    ];
    return Column(children: actions.map((a) => ActionListCard(action: a, onTap: (){
      context.pop(a.title);
    })).toList());
  }

  Widget _buildTextInjection(ColorScheme colorScheme , BuildContext context) {
    final actions = [
      ActionItemModel(
        title: 'Type String',
        subtitle: 'Simulate keyboard typing a specific phrase.',
        icon: Icons.keyboard_outlined,
        iconColor: colorScheme.primary,
        iconBackgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.3),
      ),
      ActionItemModel(
        title: 'Paste Clipboard',
        subtitle: 'Inject current clipboard contents directly.',
        icon: Icons.content_paste,
        iconColor: colorScheme.primary,
        iconBackgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.3),
      ),
    ];
    return Column(children: actions.map((a) => ActionListCard(action: a, onTap: (){
      context.pop(a.title);
    })).toList());
  }

  Widget _buildMedia(ColorScheme colorScheme , BuildContext context) {
    final actions = [
      ActionItemModel(
        title: 'Play / Pause',
        subtitle: 'Toggle active media playback.',
        icon: Icons.play_arrow,
        iconColor: colorScheme.onSurfaceVariant,
        iconBackgroundColor: colorScheme.surfaceContainerHigh,
      ),
      ActionItemModel(
        title: 'Next Track',
        subtitle: 'Skip to the next media item.',
        icon: Icons.skip_next,
        iconColor: colorScheme.onSurfaceVariant,
        iconBackgroundColor: colorScheme.surfaceContainerHigh,
      ),
    ];
    return Column(children: actions.map((a) => ActionListCard(action: a, onTap: (){
      context.pop(a.title);
    })).toList());
  }

  Widget _buildShellCommands(ColorScheme colorScheme , BuildContext context) {
    final actions = [
      ActionItemModel(
        title: 'Execute Bash Script',
        subtitle: 'Run custom shell scripts as root or standard user.',
        icon: Icons.terminal,
        iconColor: colorScheme.onSurfaceVariant,
        iconBackgroundColor: colorScheme.surfaceContainerHigh,
        codeSnippet: '#!/bin/bash\necho "Hello World"', // Injects the code block!
      ),
    ];
    return Column(children: actions.map((a) => ActionListCard(action: a, onTap: (){
      context.pop(a.title);
    })).toList());
  }
}