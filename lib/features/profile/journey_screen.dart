import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/journey_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final events = DummyData.journey;
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('journey'))),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(loc: loc),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: events.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final event = events[index];
                  return _JourneyCard(event: event, index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(.15),
            theme.colorScheme.secondaryContainer.withOpacity(.2),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.translate('journeySubtitle'),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            loc.translate('journeyHelper'),
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: .72,
            minHeight: 10,
            borderRadius: BorderRadius.circular(12),
          ).animate().shimmer(duration: 1400.ms),
        ],
      ),
    ).animate().fadeIn(duration: 280.ms).slide(begin: const Offset(0, .1));
  }
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard({required this.event, required this.index});

  final JourneyEvent event;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final baseColor = theme.colorScheme.primary.withOpacity(.15 + event.emphasis / 4);
    return Stack(
      children: [
        Positioned(
          left: 22,
          top: 0,
          bottom: index == DummyData.journey.length - 1 ? 40 : -4,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [baseColor, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: baseColor,
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(.4),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    event.dateLabel.split(' ').first,
                    style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              event.title,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text('${(event.emphasis * 100).round()}%'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        event.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.play_arrow, size: 18),
                          const SizedBox(width: 6),
                          Text(loc.translate('keepListening')),
                          const Spacer(),
                          IconButton(
                            tooltip: loc.translate('aiSoon'),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(loc.translate('aiSoon'))),
                              );
                            },
                            icon: const Icon(Icons.auto_awesome),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ).animate(delay: (80 * index).ms).fadeIn().slide(begin: const Offset(0, .1)),
      ],
    );
  }
}
