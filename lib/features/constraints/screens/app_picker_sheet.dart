import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';

class AppPickerSheet extends StatelessWidget {
  const AppPickerSheet({super.key});

  Future<void> _showManualInputDialog(BuildContext context) async {
    final textController = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Require Specific App'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'e.g., com.spotify.music',
              labelText: 'Package Name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final val = textController.text.trim();
                Navigator.pop(context, val.isEmpty ? null : val);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result != null && context.mounted) {
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AppInfo>>(
      future: InstalledApps.getInstalledApps(
        excludeSystemApps: false, // Show all apps like Chrome, Maps, etc.
        excludeNonLaunchableApps: true, // Hide background services
        withIcon: true,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading apps: ${snapshot.error}'));
        }

        final apps = snapshot.data ?? [];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select App',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: apps.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Enter Package Name Manually'),
                      onTap: () => _showManualInputDialog(context),
                    );
                  }

                  final app = apps[index - 1];
                  return ListTile(
                    leading: app.icon != null
                        ? Image.memory(app.icon!, width: 40, height: 40)
                        : const Icon(Icons.android, size: 40),
                    title: Text(app.name ?? 'Unknown App'),
                    subtitle: Text(app.packageName ?? ''),
                    onTap: () => Navigator.pop(context, app.packageName),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
