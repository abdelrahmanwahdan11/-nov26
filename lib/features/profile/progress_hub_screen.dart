import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/core/widgets/skeleton.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/achievement.dart';
import 'package:audiobook_ebooks/data/models/app_notification.dart';
import 'package:audiobook_ebooks/data/models/download_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProgressHubScreen extends StatelessWidget {
  const ProgressHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.translate('progressCenter')),
          bottom: TabBar(
            tabs: [
              Tab(text: loc.translate('achievements')),
              Tab(text: loc.translate('notifications')),
              Tab(text: loc.translate('downloads')),
            ],
          ),
        ),
        body: TabBarView(
          children: const [
            _AchievementsView(),
            _NotificationsView(),
            _DownloadsView(),
          ],
        ),
      ),
    );
  }
}

class _AchievementsView extends StatelessWidget {
  const _AchievementsView();

  @override
  Widget build(BuildContext context) {
    final achievements = DummyData.achievements;
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.padding),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final a = achievements[index];
        return _AchievementTile(achievement: a)
            .animate()
            .fadeIn(duration: 220.ms)
            .slide(begin: const Offset(0, .08));
      },
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({required this.achievement});
  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = achievement.progress / achievement.target;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                achievement.badgeUrl,
                width: 68,
                height: 68,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          achievement.title,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      if (achievement.completed)
                        Icon(Icons.check_circle, color: theme.colorScheme.primary),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    achievement.description,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(value: progress),
                  const SizedBox(height: 6),
                  Text(
                    '${achievement.progress}/${achievement.target}',
                    style: theme.textTheme.labelSmall,
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

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final notes = DummyData.notifications;
    if (notes.isEmpty) {
      return Center(child: Text(loc.translate('emptyNotifications')));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.padding),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final n = notes[index];
        return _NotificationCard(notification: n)
            .animate()
            .fadeIn(duration: 200.ms)
            .slide(begin: const Offset(0, .05));
      },
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});
  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    notification.title,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                if (notification.isNew)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      AppLocalizations.of(context).translate('new'),
                      style: theme.textTheme.labelSmall,
                    ),
                  )
              ],
            ),
            const SizedBox(height: 6),
            Text(notification.body, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(
              _formatTime(notification.date),
              style: theme.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }
}

class _DownloadsView extends StatelessWidget {
  const _DownloadsView();

  @override
  Widget build(BuildContext context) {
    final downloads = DummyData.downloads;
    if (downloads.isEmpty) {
      return const SkeletonListTile();
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.padding),
      itemCount: downloads.length,
      itemBuilder: (context, index) {
        final d = downloads[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(d.coverUrl, width: 56, height: 56, fit: BoxFit.cover),
            ),
            title: Text(d.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(value: d.progress / 100),
                const SizedBox(height: 6),
                Text('${d.progress}%'),
              ],
            ),
            trailing: Icon(d.completed ? Icons.check_circle : Icons.download),
          ),
        ).animate().fadeIn(duration: 220.ms).slide(begin: const Offset(0, .06));
      },
    );
  }
}
