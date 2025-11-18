import 'package:audiobook_ebooks/core/controllers/theme_controller.dart';
import 'package:audiobook_ebooks/features/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.themeController});
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/seed/profile/80/80'),
              ),
              title: const Text('Jane Listener'),
              subtitle: const Text('jane@example.com'),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: const Text('Settings'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SettingsScreen(themeController: themeController),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
