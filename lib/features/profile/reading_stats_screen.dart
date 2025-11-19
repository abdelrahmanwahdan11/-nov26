import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ReadingStatsScreen extends StatelessWidget {
  const ReadingStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final stats = DummyData.readingStats;
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('readingStats'))),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          _StreakCard(title: loc.translate('focusStreak'), days: 5)
              .animate()
              .fadeIn(duration: 220.ms)
              .slide(begin: const Offset(0, .06)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final stat in stats)
                _StatChip(
                  label: stat.label,
                  value: stat.value,
                  progress: stat.progress,
                )
                    .animate()
                    .fadeIn(duration: 240.ms)
                    .scale(begin: 0.98, end: 1),
            ],
          ),
          const SizedBox(height: 24),
          _GradientCard(
            title: loc.translate('topGenres'),
            items: const ['Fiction', 'History', 'Young Adult'],
          ),
          const SizedBox(height: 12),
          _GradientCard(
            title: loc.translate('listeningMoments'),
            items: const ['Morning commute', 'Lunch break', 'Late night wind-down'],
          ),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.title, required this.days});
  final String title;
  final int days;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.local_fire_department, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text('$days ${AppLocalizations.of(context).translate('days')}'),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(value: days / 7),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(AppLocalizations.of(context).translate('almostThere')),
            )
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value, required this.progress});
  final String label;
  final String value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(.12),
            theme.colorScheme.surfaceVariant.withOpacity(.6),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress),
        ],
      ),
    );
  }
}

class _GradientCard extends StatelessWidget {
  const _GradientCard({required this.title, required this.items});
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.cardRadius)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(.12),
              theme.colorScheme.secondary.withOpacity(.12),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.check, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item)),
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
