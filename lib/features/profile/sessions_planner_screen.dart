import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SessionsPlannerScreen extends StatefulWidget {
  const SessionsPlannerScreen({super.key});

  @override
  State<SessionsPlannerScreen> createState() => _SessionsPlannerScreenState();
}

class _SessionsPlannerScreenState extends State<SessionsPlannerScreen> {
  final ValueNotifier<Set<String>> _reminders = ValueNotifier(<String>{});

  @override
  void dispose() {
    _reminders.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final sessions = DummyData.liveSessions;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('sessionPlanner')),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            tooltip: loc.translate('reminder'),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: const Icon(Icons.auto_schedule),
              title: Text(loc.translate('planYourDay')),
              subtitle: Text(loc.translate('planYourDayCopy')),
              trailing: FilledButton(
                onPressed: () {},
                child: Text(loc.translate('autoFill')),
              ),
            ),
          ).animate().fadeIn().slide(begin: const Offset(0, .08)),
          const SizedBox(height: 12),
          ...sessions.map(
            (session) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            session.coverUrl,
                            width: 86,
                            height: 86,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              session.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${session.host} · ${session.mood}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Theme.of(context).hintColor),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 8,
                              children: [
                                Chip(
                                  avatar: const Icon(Icons.timer, size: 16),
                                  label: Text(session.lengthLabel),
                                ),
                                Chip(
                                  avatar: const Icon(Icons.event, size: 16),
                                  label: Text(session.timeLabel),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ValueListenableBuilder<Set<String>>(
                        valueListenable: _reminders,
                        builder: (context, reminders, _) {
                          final active = reminders.contains(session.id);
                          return IconButton(
                            tooltip: loc.translate('reminder'),
                            onPressed: () {
                              final next = {...reminders};
                              if (active) {
                                next.remove(session.id);
                              } else {
                                next.add(session.id);
                              }
                              _reminders.value = next;
                            },
                            icon: Icon(
                              active
                                  ? Icons.notifications_active
                                  : Icons.notifications_none,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 220.ms).slide(begin: const Offset(0, 0.06)),
            ),
          ),
        ],
      ),
    );
  }
}
