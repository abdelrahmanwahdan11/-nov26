import 'package:flutter/material.dart';

/// Coordinates bottom navigation and page transitions in the shell.
class NavigationController {
  NavigationController({int initialIndex = 0})
      : index = ValueNotifier<int>(initialIndex),
        pageController = PageController(initialPage: initialIndex);

  final ValueNotifier<int> index;
  final PageController pageController;
  final Map<int, VoidCallback> _reselectCallbacks = {};

  void registerReselect(int tab, VoidCallback callback) {
    _reselectCallbacks[tab] = callback;
  }

  void unregisterReselect(int tab) {
    _reselectCallbacks.remove(tab);
  }

  void tapIndex(int value) {
    if (value == index.value) {
      _reselectCallbacks[value]?.call();
    } else {
      setIndex(value);
    }
  }

  void setIndex(int value, {bool animate = true}) {
    if (value == index.value) return;
    index.value = value;
    if (animate) {
      pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    } else {
      pageController.jumpToPage(value);
    }
  }

  void handlePageChanged(int value) {
    if (value != index.value) {
      index.value = value;
    }
  }

  void dispose() {
    _reselectCallbacks.clear();
    index.dispose();
    pageController.dispose();
  }
}
