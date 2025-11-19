import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/live_session.dart';
import 'package:audiobook_ebooks/data/models/scheduled_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('schedule'))),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          Text(
            loc.translate('todayPlan'),
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: 12),
          ...DummyData.liveSessions
              .map((session) => _SessionCard(session: session))
              .toList(),
          const SizedBox(height: 16),
          Text(
            loc.translate('eventTimeline'),
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(duration: 320.ms),
          const SizedBox(height: 12),
          ...DummyData.scheduledEvents
              .map((event) => _EventTile(event: event))
              .toList(),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

  final LiveSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            color: theme.shadowColor.withOpacity(.08),
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(session.coverUrl, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Chip(
                    label: Text(session.mood),
                    backgroundColor: theme.colorScheme.surface.withOpacity(.8),
                  ).animate().scale(begin: const Offset(.95, .95)),
                  const SizedBox(height: 8),
                  Text(
                    session.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(duration: 300.ms).slide(begin: const Offset(0, .1)),
                  const SizedBox(height: 4),
                  Text(
                    '${session.timeLabel} · ${session.lengthLabel}',
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${session.host} • ${AppLocalizations.of(context).translate('liveSession')}',
                    style: theme.textTheme.labelLarge?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});

  final ScheduledEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.primary.withOpacity(.12)),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(event.coverUrl, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(event.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.subtitle),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: theme.hintColor),
                const SizedBox(width: 6),
                Text(event.window, style: theme.textTheme.labelMedium),
                const SizedBox(width: 12),
                Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text(event.vibe),
                  backgroundColor: theme.colorScheme.primary.withOpacity(.12),
                  padding: EdgeInsets.zero,
                  labelStyle: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: theme.colorScheme.primary),
      ),
    ).animate().fadeIn(duration: 240.ms).slide(begin: const Offset(0, .06));
  }
}
