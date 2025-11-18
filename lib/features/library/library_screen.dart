import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/controllers/books_controller.dart';
import 'package:audiobook_ebooks/core/controllers/navigation_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/features/library/downloads_center_screen.dart';
import 'package:audiobook_ebooks/features/library/highlights_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({
    super.key,
    required this.booksController,
    this.navController,
    this.tabIndex = 2,
  });
  final BooksController booksController;
  final NavigationController? navController;
  final int tabIndex;

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _inProgress = ScrollController();
  final ScrollController _favorites = ScrollController();
  final ScrollController _downloads = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    widget.navController?.registerReselect(
      widget.tabIndex,
      () => _scrollActive(animated: true),
    );
  }

  void _scrollActive({bool animated = false}) {
    final controllers = [_inProgress, _favorites, _downloads];
    final controller = controllers[_tabController.index];
    if (!controller.hasClients) return;
    if (animated) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    } else {
      controller.jumpTo(0);
    }
  }

  @override
  void dispose() {
    widget.navController?.unregisterReselect(widget.tabIndex);
    _tabController.dispose();
    _inProgress.dispose();
    _favorites.dispose();
    _downloads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final downloads = DummyData.downloads;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('library')),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_done_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DownloadsCenterScreen()),
              );
            },
            tooltip: loc.translate('downloadsCenter'),
          ).animate().fadeIn(duration: 200.ms).scale(begin: .9, curve: Curves.easeOut),
          IconButton(
            icon: const Icon(Icons.push_pin_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const HighlightsScreen()),
              );
            },
            tooltip: loc.translate('highlights'),
          )
              .animate()
              .fadeIn(duration: 200.ms)
              .scale(begin: .9, curve: Curves.easeOut),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: loc.translate('inProgress')),
            Tab(text: loc.translate('favorites')),
            Tab(text: loc.translate('downloads')),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.padding),
            child: _HighlightsTeaser(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _LibraryList(
                  booksController: widget.booksController,
                  filter: (index) => index % 3 != 0,
                  emptyState: Text(loc.translate('noInProgress')),
                  controller: _inProgress,
                ),
                _LibraryList(
                  booksController: widget.booksController,
                  filter: (index) => index.isEven,
                  emptyState: Text(loc.translate('noFavorites')),
                  controller: _favorites,
                ),
                ListView.builder(
                  controller: _downloads,
                  padding: const EdgeInsets.all(AppConstants.padding),
                  itemCount: downloads.length,
                  itemBuilder: (context, i) {
                    final d = downloads[i];
                    return Card(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(d.coverUrl, width: 56, height: 56, fit: BoxFit.cover),
                        ),
                        title: Text(d.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LinearProgressIndicator(value: d.progress / 100),
                            const SizedBox(height: 6),
                            Text('${d.progress}% ${loc.translate('complete')}'),
                          ],
                        ),
                        trailing: Icon(d.completed ? Icons.check_circle : Icons.download),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 220.ms)
                        .slide(begin: const Offset(0, .05));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightsTeaser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.primary.withOpacity(.12)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(.08),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc.translate('highlights'),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(
                  loc.translate('highlightsTeaser'),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                FilledButton.tonal(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HighlightsScreen()),
                    );
                  },
                  child: Text(loc.translate('viewHighlights')),
                )
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              DummyData.highlights.first.coverUrl,
              width: 86,
              height: 86,
              fit: BoxFit.cover,
            ),
          )
              .animate()
              .shimmer(delay: 200.ms, duration: 1200.ms)
              .scale(begin: const Offset(.95, .95)),
        ],
      ),
    ).animate().fadeIn(duration: 260.ms).slide(begin: const Offset(0, -.02));
  }
}

class _LibraryList extends StatelessWidget {
  const _LibraryList({
    required this.booksController,
    required this.filter,
    required this.emptyState,
    required this.controller,
  });

  final BooksController booksController;
  final bool Function(int) filter;
  final Widget emptyState;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ValueListenableBuilder(
      valueListenable: booksController.books,
      builder: (context, books, _) {
        final filtered = [
          for (var i = 0; i < books.length; i++)
            if (filter(i)) books[i]
        ];
        if (filtered.isEmpty) {
          return Center(child: emptyState);
        }
        return RefreshIndicator(
          onRefresh: () async => booksController.refresh(),
          child: ListView.separated(
            controller: controller,
            padding: const EdgeInsets.all(AppConstants.padding),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final b = filtered[index];
              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(b.coverUrl, width: 56, height: 56, fit: BoxFit.cover),
                  ),
                  title: Text(b.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LinearProgressIndicator(value: .4),
                      const SizedBox(height: 6),
                      Text(loc.translate('keepListening')),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {},
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: 220.ms)
                  .slide(begin: const Offset(0, .05));
            },
          ),
        );
      },
    );
  }
}
