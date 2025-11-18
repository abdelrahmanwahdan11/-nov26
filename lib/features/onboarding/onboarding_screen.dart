import 'dart:async';

import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onStart});

  final VoidCallback onStart;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;
  Timer? _timer;

  final List<_OnboardingItem> _items = [
    const _OnboardingItem(
      image: 'https://picsum.photos/seed/on1/800/1200',
      title: 'HEAR AND EXPAND YOUR MIND',
      subtitle: 'Immersive stories at your pace',
    ),
    const _OnboardingItem(
      image: 'https://picsum.photos/seed/on2/800/1200',
      title: 'FIND YOUR NEXT FAVORITE',
      subtitle: 'Audiobooks and ebooks together',
    ),
    const _OnboardingItem(
      image: 'https://picsum.photos/seed/on3/800/1200',
      title: 'LISTEN ON THE GO',
      subtitle: 'Smooth player with smart chapters',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      final next = (_page + 1) % _items.length;
      _controller.animateToPage(
        next,
        duration: 500.ms,
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: _items.length,
              onPageChanged: (value) {
                setState(() => _page = value);
                _startAutoPlay();
              },
              itemBuilder: (context, index) {
                final item = _items[index];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        item.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(.6), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(0.05 * (index.isEven ? 1 : -1)),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                            border: Border.all(color: Colors.white24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.25),
                                blurRadius: 24,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: .5,
                                    ),
                              ).animate().fadeIn(duration: 500.ms).slide(begin: const Offset(0, .2)),
                              const SizedBox(height: 12),
                              Text(
                                item.subtitle,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white70),
                              ).animate().fadeIn(duration: 600.ms).slide(begin: const Offset(0, .2)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _items.length,
                        (index) => AnimatedContainer(
                          duration: 250.ms,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 10,
                          width: _page == index ? 24 : 10,
                          decoration: BoxDecoration(
                            color: _page == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        TextButton(
                          onPressed: widget.onStart,
                          child: Text(loc.translate('skip')),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () {
                            final next = (_page + 1).clamp(0, _items.length - 1);
                            _controller.animateToPage(
                              next,
                              duration: 300.ms,
                              curve: Curves.easeOut,
                            );
                          },
                          child: Text(loc.translate('next')),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: const StadiumBorder(),
                        elevation: 4,
                      ),
                      onPressed: widget.onStart,
                      child: Text(loc.translate('startReading')),
                    ).animate().scale(begin: const Offset(.95, .95)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingItem {
  final String image;
  final String title;
  final String subtitle;
  const _OnboardingItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
