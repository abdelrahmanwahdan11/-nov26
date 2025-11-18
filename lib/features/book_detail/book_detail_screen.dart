import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/core/widgets/ai_info_button.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:audiobook_ebooks/data/models/chapter.dart';
import 'package:audiobook_ebooks/data/models/review.dart';
import 'package:audiobook_ebooks/features/player/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final chapters = DummyData.chaptersFor(book.id);
    final reviews = DummyData.reviewsFor(book.id);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: const [AiInfoButton()],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'What you will get?',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.pink),
                      const SizedBox(width: 4),
                      Text('${book.likes}'),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, color: Colors.amber),
                      Text('${book.rating}')
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            _HeroCard(book: book),
            TabBar(
              tabs: [
                Tab(text: loc.translate('aboutBook')),
                Tab(text: loc.translate('chapters')),
                Tab(text: loc.translate('reviews')),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _AboutTab(book: book),
                  _ChaptersTab(chapters: chapters),
                  _ReviewsTab(reviews: reviews),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: SizedBox(
        height: 220,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(.1),
                      Theme.of(context).colorScheme.secondary.withOpacity(.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                ),
              ),
            ),
            Positioned(
              left: 24,
              bottom: 16,
              top: 16,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(-0.12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(book.coverUrl),
                ),
              ),
            ),
            Positioned(
              right: 24,
              top: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.title,
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(book.author),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.lock_open),
                      const SizedBox(width: 6),
                      Text(book.isLocked ? 'Locked' : 'Unlocked'),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ).animate().fadeIn(),
    );
  }
}

class _AboutTab extends StatelessWidget {
  const _AboutTab({required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          book.title,
          style:
              Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(book.description),
        const SizedBox(height: 16),
        Text('You may like this',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: DummyData.books.take(5).length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final b = DummyData.books[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(b.coverUrl),
              );
            },
          ),
        )
      ],
    ).animate().fadeIn(duration: 300.ms).slide(begin: const Offset(0, .1));
  }
}

class _ChaptersTab extends StatelessWidget {
  const _ChaptersTab({required this.chapters});
  final List<Chapter> chapters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        final chapter = chapters[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${chapter.order}')),
            title: Text(chapter.title),
            subtitle: Text('${chapter.durationMinutes} mins'),
            trailing: IconButton(
              icon: Icon(chapter.isLocked ? Icons.lock : Icons.play_arrow),
              onPressed: () {
                if (!chapter.isLocked) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PlayerScreen(title: chapter.title),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    ).animate().fadeIn(duration: 300.ms).slide(begin: const Offset(0, .1));
  }
}

class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab({required this.reviews});
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              _FilterChip(label: loc.translate('verified')),
              const SizedBox(width: 8),
              _FilterChip(label: loc.translate('latest')),
              const SizedBox(width: 8),
              _FilterChip(label: loc.translate('mostPopular')),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(loc.translate('addReview')),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(review.userAvatarUrl),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(review.userName,
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                Text('${review.rating} ★'),
                              ],
                            ),
                            Text(review.content),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}
