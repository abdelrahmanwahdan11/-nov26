import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/controllers/books_controller.dart';
import 'package:audiobook_ebooks/core/controllers/comparison_controller.dart';
import 'package:audiobook_ebooks/core/controllers/search_controller.dart' as controllers;
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/core/widgets/ai_info_button.dart';
import 'package:audiobook_ebooks/core/widgets/skeleton.dart';
import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:audiobook_ebooks/features/book_detail/book_detail_screen.dart';
import 'package:audiobook_ebooks/features/catalog/author_spotlight_screen.dart';
import 'package:audiobook_ebooks/features/catalog/collections_screen.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
    required this.booksController,
    required this.comparisonController,
  });
  final BooksController booksController;
  final ComparisonController comparisonController;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final controllers.SearchController _searchController =
      controllers.SearchController();
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 200) {
      widget.booksController.paginate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: loc.translate('searchHint'),
            border: InputBorder.none,
          ),
          onChanged: (value) => _searchController.updateQuery(
            value,
            widget.booksController.books.value,
          ),
        ),
        actions: [
          IconButton(
            tooltip: loc.translate('collections'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CollectionsScreen()),
            ),
            icon: const Icon(Icons.auto_awesome),
          ),
          IconButton(
            tooltip: loc.translate('authorSpotlight'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AuthorSpotlightScreen()),
            ),
            icon: const Icon(Icons.record_voice_over),
          ),
          const AiInfoButton()
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: widget.booksController.isLoading,
        builder: (context, loading, _) {
          if (loading) {
            return GridView.builder(
              padding: const EdgeInsets.all(AppConstants.padding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .62,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 6,
              itemBuilder: (_, __) => const SkeletonBox(height: 260),
            );
          }
          return ValueListenableBuilder(
            valueListenable: widget.booksController.books,
            builder: (context, books, _) {
              final show = _searchController.query.value.isEmpty
                  ? books
                  : _searchController.results.value;
              return NotificationListener<ScrollNotification>(
                onNotification: (_) {
                  _onScroll();
                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: () async => widget.booksController.refresh(),
                  child: GridView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.all(AppConstants.padding),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .62,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: show.length + 1,
                    itemBuilder: (context, index) {
                      if (index == show.length) {
                        return ValueListenableBuilder(
                          valueListenable: widget.booksController.isPaginating,
                          builder: (context, paginating, _) {
                            if (!paginating) return const SizedBox.shrink();
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      }
                      final book = show[index];
                      return _CatalogCard(
                        book: book,
                        onTap: () => _openDetail(context, book),
                        onSelect: () => widget.comparisonController.toggle(book),
                        selected: widget.comparisonController.isSelected(book),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
    );
  }
}

class _CatalogCard extends StatelessWidget {
  const _CatalogCard({
    required this.book,
    required this.onTap,
    required this.onSelect,
    required this.selected,
  });
  final Book book;
  final VoidCallback onTap;
  final VoidCallback onSelect;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      onLongPress: onSelect,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          book.coverUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, size: 14),
                            const SizedBox(width: 4),
                            Text('${book.rating}')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                book.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium,
              ),
              Text(
                book.author,
                style: theme.textTheme.bodySmall,
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    selected ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: selected
                        ? theme.colorScheme.primary
                        : theme.hintColor,
                  ),
                  const SizedBox(width: 8),
                  Text(book.genre),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
