import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/author_spotlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthorSpotlightScreen extends StatelessWidget {
  const AuthorSpotlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final authors = DummyData.authorSpotlights;
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('authorSpotlight'))),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.padding),
        itemCount: authors.length,
        itemBuilder: (context, index) {
          final author = authors[index];
          return _AuthorCard(author: author, index: index, loc: loc);
        },
      ),
    );
  }
}

class _AuthorCard extends StatelessWidget {
  const _AuthorCard({
    required this.author,
    required this.index,
    required this.loc,
  });

  final AuthorSpotlight author;
  final int index;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(author.coverUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        author.name,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    Chip(
                      label: Text('${author.booksCount} ${loc.translate('books')}'),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  author.tagline,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(author.bio),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final highlight in author.highlights)
                      Chip(
                        label: Text(highlight),
                        backgroundColor:
                            theme.colorScheme.secondaryContainer.withOpacity(.35),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    FilledButton.icon(
                      icon: const Icon(Icons.play_arrow),
                      label: Text(loc.translate('startListening')),
                      onPressed: () => _showPreview(context, author),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      tooltip: loc.translate('aiSoon'),
                      onPressed: () => _showPreview(context, author, compact: true),
                      icon: const Icon(Icons.auto_awesome),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ).animate(delay: (90 * index).ms).fadeIn().scale(begin: 0.98);
  }

  void _showPreview(BuildContext context, AuthorSpotlight author, {bool compact = false}) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(author.coverUrl),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(author.name, style: theme.textTheme.titleMedium),
                        Text(author.tagline, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Text(author.bio),
              const SizedBox(height: 12),
              if (!compact)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.translate('featuredHighlights'),
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 6),
                    for (final highlight in author.highlights)
                      ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(highlight),
                      ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
