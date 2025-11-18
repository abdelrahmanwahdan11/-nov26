import 'package:audiobook_ebooks/core/controllers/auth_controller.dart';
import 'package:audiobook_ebooks/core/controllers/books_controller.dart';
import 'package:audiobook_ebooks/core/controllers/comparison_controller.dart';
import 'package:audiobook_ebooks/core/controllers/theme_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/core/theme/app_theme.dart';
import 'package:audiobook_ebooks/features/onboarding/onboarding_screen.dart';
import 'package:audiobook_ebooks/features/home/home_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HearAndReadApp());
}

class HearAndReadApp extends StatefulWidget {
  const HearAndReadApp({super.key});

  @override
  State<HearAndReadApp> createState() => _HearAndReadAppState();
}

class _HearAndReadAppState extends State<HearAndReadApp> {
  final ThemeController _themeController = ThemeController();
  final AuthController _authController = AuthController();
  final BooksController _booksController = BooksController();
  final ComparisonController _comparisonController = ComparisonController();

  @override
  void initState() {
    super.initState();
    _themeController.load();
    _booksController.loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _themeController.preferences,
      builder: (context, prefs, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hear & Read',
          theme: AppTheme.light(prefs.primaryColorSeed),
          darkTheme: AppTheme.dark(prefs.primaryColorSeed),
          themeMode: prefs.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          locale: Locale(prefs.preferredLanguageCode),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            final loc = AppLocalizations.of(context);
            return Directionality(
              textDirection: loc.isRtl ? TextDirection.rtl : TextDirection.ltr,
              child: child!,
            );
          },
          home: OnboardingScreen(
            onStart: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => HomeShell(
                    themeController: _themeController,
                    authController: _authController,
                    booksController: _booksController,
                    comparisonController: _comparisonController,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
