import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/highlight_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HighlightsScreen extends StatefulWidget {
  const HighlightsScreen({super.key});

  @override
  State<HighlightsScreen> createState() => _HighlightsScreenState();
}

class _HighlightsScreenState extends State<HighlightsScreen> {
  final ValueNotifier<String> _filter = ValueNotifier<String>('all');

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final filters = ['all', 'focus', 'calm', 'renew'];
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('highlights')),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(loc.translate('aiSoon'))),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('highlightsHero'),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              loc.translate('highlightsSub'),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: ValueListenableBuilder<String>(
                valueListenable: _filter,
                builder: (context, value, _) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final key = filters[index];
                      final selected = value == key;
                      return ChoiceChip(
                        label: Text(key == 'all'
                            ? loc.translate('all')
                            : key.capitalize()),
                        selected: selected,
                        onSelected: (_) => _filter.value = key,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ValueListenableBuilder<String>(
                valueListenable: _filter,
                builder: (context, value, _) {
                  final items = DummyData.highlights
                      .where(
                        (h) =>
                            value == 'all' ||
                            h.mood.toLowerCase() == value.toLowerCase(),
                      )
                      .toList();
                  return AnimatedSwitcher(
                    duration: 280.ms,
                    switchInCurve: Curves.easeOutCubic,
                    child: ListView.separated(
                      key: ValueKey(value),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return _HighlightCard(note: item)
                            .animate()
                            .fadeIn(duration: 250.ms)
                            .slide(begin: const Offset(0, .05));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({required this.note});

  final HighlightNote note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(.1)),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            spreadRadius: 2,
            color: theme.colorScheme.primary.withOpacity(.06),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              note.coverUrl,
              width: 82,
              height: 82,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.bookTitle,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(note.chapterTitle, style: theme.textTheme.bodySmall),
                const SizedBox(height: 8),
                Text(
                  note.snippet,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    Chip(
                      label: Text(note.mood),
                      visualDensity: VisualDensity.compact,
                      backgroundColor:
                          theme.colorScheme.primary.withOpacity(.08),
                    ),
                    for (final tag in note.tags)
                      Chip(
                        label: Text(tag),
                        visualDensity: VisualDensity.compact,
                        backgroundColor:
                            theme.colorScheme.surfaceVariant.withOpacity(.6),
                      )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      note.timeLabel,
                      style: theme.textTheme.bodySmall,
                    ),
                    IconButton(
                      icon: const Icon(Icons.push_pin_outlined),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)
                                  .translate('pinnedToPlanner'),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension on String {
  String capitalize() => isEmpty
      ? this
      : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}
