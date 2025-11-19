import 'package:flutter/material.dart';

@immutable
class UserPreferences {
  final int primaryColorSeed;
  final bool isDarkMode;
  final String preferredLanguageCode;

  const UserPreferences({
    required this.primaryColorSeed,
    required this.isDarkMode,
    required this.preferredLanguageCode,
  });

  UserPreferences copyWith({
    int? primaryColorSeed,
    bool? isDarkMode,
    String? preferredLanguageCode,
  }) {
    return UserPreferences(
      primaryColorSeed: primaryColorSeed ?? this.primaryColorSeed,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      preferredLanguageCode:
          preferredLanguageCode ?? this.preferredLanguageCode,
    );
  }
}
