import 'package:audiobook_ebooks/core/controllers/theme_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/features/profile/progress_hub_screen.dart';
import 'package:audiobook_ebooks/features/profile/reading_stats_screen.dart';
import 'package:audiobook_ebooks/features/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.themeController});
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('profile'))),
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
            _ProfileAction(
              title: loc.translate('readingStats'),
              icon: Icons.auto_graph,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ReadingStatsScreen()),
                );
              },
            ),
            _ProfileAction(
              title: loc.translate('progressCenter'),
              icon: Icons.emoji_events,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProgressHubScreen()),
                );
              },
            ),
            _ProfileAction(
              title: loc.translate('settings'),
              icon: Icons.tune,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(themeController: themeController),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAction extends StatelessWidget {
  const _ProfileAction({required this.title, required this.icon, required this.onTap});

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    ).animate().fadeIn(duration: 220.ms).slide(begin: const Offset(0, .05));
  }
}
