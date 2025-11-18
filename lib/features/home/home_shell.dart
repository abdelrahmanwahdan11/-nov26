import 'package:audiobook_ebooks/core/controllers/auth_controller.dart';
import 'package:audiobook_ebooks/core/controllers/books_controller.dart';
import 'package:audiobook_ebooks/core/controllers/comparison_controller.dart';
import 'package:audiobook_ebooks/core/controllers/goals_controller.dart';
import 'package:audiobook_ebooks/core/controllers/navigation_controller.dart';
import 'package:audiobook_ebooks/core/controllers/theme_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/features/catalog/catalog_screen.dart';
import 'package:audiobook_ebooks/features/home/home_screen.dart';
import 'package:audiobook_ebooks/features/library/library_screen.dart';
import 'package:audiobook_ebooks/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.themeController,
    required this.authController,
    required this.booksController,
    required this.comparisonController,
    required this.goalsController,
  });

  final ThemeController themeController;
  final AuthController authController;
  final BooksController booksController;
  final ComparisonController comparisonController;
  final GoalsController goalsController;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late final NavigationController _navController;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _navController = NavigationController();
    _pages = [
      HomeScreen(
        booksController: widget.booksController,
        comparisonController: widget.comparisonController,
        goalsController: widget.goalsController,
        navController: _navController,
        tabIndex: 0,
      ),
      CatalogScreen(
        booksController: widget.booksController,
        comparisonController: widget.comparisonController,
        navController: _navController,
        tabIndex: 1,
      ),
      LibraryScreen(
        booksController: widget.booksController,
        navController: _navController,
        tabIndex: 2,
      ),
      ProfileScreen(
        themeController: widget.themeController,
        goalsController: widget.goalsController,
        navController: _navController,
        tabIndex: 3,
      ),
    ];
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final items = [
      _NavItem(label: loc.translate('home'), icon: IconlyBold.home),
      _NavItem(label: loc.translate('catalog'), icon: IconlyBold.category),
      _NavItem(label: loc.translate('library'), icon: IconlyBold.paper),
      _NavItem(label: loc.translate('profile'), icon: IconlyBold.profile),
    ];

    final isWide = MediaQuery.of(context).size.width >= 900;

    return ValueListenableBuilder<int>(
      valueListenable: _navController.index,
      builder: (context, index, _) {
        final nav = isWide
            ? NavigationRail(
                selectedIndex: index,
                onDestinationSelected: (i) => _navController.tapIndex(i),
                labelType: NavigationRailLabelType.all,
                destinations: [
                  for (final item in items)
                    NavigationRailDestination(
                      icon: Icon(item.icon),
                      label: Text(item.label),
                    ),
                ],
              )
            : BottomNavigationBar(
                currentIndex: index,
                onTap: (i) => _navController.tapIndex(i),
                items: [
                  for (final item in items)
                    BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      label: item.label,
                    ),
                ],
              );

        return Scaffold(
          body: Row(
            children: [
              if (isWide) nav,
              Expanded(
                child: PageView(
                  controller: _navController.pageController,
                  onPageChanged: _navController.handlePageChanged,
                  children: [
                    for (final page in _pages)
                      AnimatedSwitcher(
                        duration: 280.ms,
                        switchInCurve: Curves.easeOut,
                        child: page,
                      ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: isWide ? null : nav,
        );
      },
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  _NavItem({required this.label, required this.icon});
}
