import 'package:audiobook_ebooks/core/controllers/auth_controller.dart';
import 'package:audiobook_ebooks/core/controllers/books_controller.dart';
import 'package:audiobook_ebooks/core/controllers/comparison_controller.dart';
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
  });

  final ThemeController themeController;
  final AuthController authController;
  final BooksController booksController;
  final ComparisonController comparisonController;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(
        booksController: widget.booksController,
        comparisonController: widget.comparisonController,
      ),
      CatalogScreen(
        booksController: widget.booksController,
        comparisonController: widget.comparisonController,
      ),
      LibraryScreen(booksController: widget.booksController),
      ProfileScreen(themeController: widget.themeController),
    ];
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

    final nav = isWide
        ? NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
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
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
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
            child: AnimatedSwitcher(
              duration: 250.ms,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(.05, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: IndexedStack(
                key: ValueKey(_index),
                index: _index,
                children: _pages,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isWide ? null : nav,
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  _NavItem({required this.label, required this.icon});
}
