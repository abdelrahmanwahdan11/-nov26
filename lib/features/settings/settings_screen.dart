import 'package:audiobook_ebooks/core/controllers/theme_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.themeController});
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    const seeds = [0xFF3A7BD5, 0xFFB53471, 0xFF2ecc71, 0xFFf39c12];
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: ValueListenableBuilder(
        valueListenable: themeController.preferences,
        builder: (context, prefs, _) {
          return ListView(
            children: [
              SwitchListTile(
                title: Text(loc.translate('darkMode')),
                value: prefs.isDarkMode,
                onChanged: themeController.toggleDarkMode,
              ),
              ListTile(
                title: Text(loc.translate('primaryColor')),
                subtitle: Wrap(
                  spacing: 8,
                  children: [
                    for (final seed in seeds)
                      GestureDetector(
                        onTap: () => themeController.updateSeed(seed),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(seed),
                          child: prefs.primaryColorSeed == seed
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      )
                  ],
                ),
              ),
              ListTile(
                title: Text(loc.translate('language')),
                trailing: DropdownButton<String>(
                  value: prefs.preferredLanguageCode,
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'ar', child: Text('العربية')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      themeController.updateLanguage(value);
                    }
                  },
                ),
              ),
              SwitchListTile(
                title: const Text('Notifications'),
                value: true,
                onChanged: (_) {},
              ),
              const ListTile(
                title: Text('About app'),
                subtitle: Text('Audiobook & ebook exploration experience'),
              )
            ],
          );
        },
      ),
    );
  }
}
