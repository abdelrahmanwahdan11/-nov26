import 'package:audiobook_ebooks/data/models/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController {
  static const _keyPrimarySeed = 'primary_seed';
  static const _keyDarkMode = 'dark_mode';
  static const _keyLanguage = 'language';

  final ValueNotifier<UserPreferences> preferences = ValueNotifier(
    const UserPreferences(
      primaryColorSeed: 0xFF3A7BD5,
      isDarkMode: false,
      preferredLanguageCode: 'en',
    ),
  );

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final seed = prefs.getInt(_keyPrimarySeed) ?? 0xFF3A7BD5;
    final dark = prefs.getBool(_keyDarkMode) ?? false;
    final language = prefs.getString(_keyLanguage) ?? 'en';
    preferences.value = UserPreferences(
      primaryColorSeed: seed,
      isDarkMode: dark,
      preferredLanguageCode: language,
    );
  }

  Future<void> toggleDarkMode(bool value) async {
    preferences.value = preferences.value.copyWith(isDarkMode: value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, value);
  }

  Future<void> updateSeed(int seed) async {
    preferences.value = preferences.value.copyWith(primaryColorSeed: seed);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyPrimarySeed, seed);
  }

  Future<void> updateLanguage(String code) async {
    preferences.value = preferences.value.copyWith(preferredLanguageCode: code);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, code);
  }
}
