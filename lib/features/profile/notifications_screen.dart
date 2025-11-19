import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/app_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final ValueNotifier<List<AppNotification>> _items;

  @override
  void initState() {
    super.initState();
    _items = ValueNotifier(List.of(DummyData.notifications));
  }

  @override
  void dispose() {
    _items.dispose();
    super.dispose();
  }

  void _markAllRead() {
    final updated = [
      for (final item in _items.value) item.copyWith(isNew: false),
    ];
    _items.value = updated;
  }

  void _toggleRead(AppNotification item) {
    final updated = _items.value
        .map((e) => e.id == item.id ? e.copyWith(isNew: !e.isNew) : e)
        .toList();
    _items.value = updated;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('notificationCenter')),
        actions: [
          TextButton(
            onPressed: _markAllRead,
            child: Text(loc.translate('markAllRead')),
          )
        ],
      ),
      body: ValueListenableBuilder<List<AppNotification>>(
        valueListenable: _items,
        builder: (context, items, _) {
          if (items.isEmpty) {
            return Center(child: Text(loc.translate('noNotifications')));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppConstants.padding),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              final card = _NotificationCard(
                item: item,
                onTap: () => _toggleRead(item),
              );
              return card.animate().fadeIn(duration: 220.ms).slide(begin: const Offset(0, .05));
            },
          );
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item, required this.onTap});

  final AppNotification item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surfaceVariant.withOpacity(.5),
              theme.colorScheme.surface,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.isNew ? Icons.fiber_new : Icons.notifications,
                color: theme.colorScheme.primary,
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
                          item.title,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      if (item.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            AppLocalizations.of(context).translate('new'),
                            style: theme.textTheme.labelMedium?.copyWith(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.body,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: theme.hintColor),
                      const SizedBox(width: 6),
                      Text(item.timeLabel, style: theme.textTheme.labelMedium),
                    ],
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
