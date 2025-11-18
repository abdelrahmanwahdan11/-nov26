import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/controllers/books_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key, required this.booksController});
  final BooksController booksController;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final downloads = DummyData.downloads;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.translate('library')),
          bottom: TabBar(
            tabs: [
              Tab(text: loc.translate('inProgress')),
              Tab(text: loc.translate('favorites')),
              Tab(text: loc.translate('downloads')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _LibraryList(
              booksController: booksController,
              filter: (index) => index % 3 != 0,
              emptyState: Text(loc.translate('noInProgress')),
            ),
            _LibraryList(
              booksController: booksController,
              filter: (index) => index.isEven,
              emptyState: Text(loc.translate('noFavorites')),
            ),
            ListView.builder(
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
    );
  }
}

class _LibraryList extends StatelessWidget {
  const _LibraryList({
    required this.booksController,
    required this.filter,
    required this.emptyState,
  });

  final BooksController booksController;
  final bool Function(int) filter;
  final Widget emptyState;

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
