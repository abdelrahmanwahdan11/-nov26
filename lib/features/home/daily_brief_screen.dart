import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DailyBriefScreen extends StatelessWidget {
  const DailyBriefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final briefs = DummyData.dailyBriefs;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('dailyBrief')),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.bolt),
            label: Text(loc.translate('startFlow')),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(.12),
                    Theme.of(context).colorScheme.secondaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('dailyBriefHeadline'),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    loc.translate('dailyBriefCopy'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Chip(
                        avatar: const Icon(Icons.schedule, size: 16),
                        label: Text(loc.translate('threeBlocks')),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        avatar: const Icon(Icons.auto_awesome, size: 16),
                        label: Text(loc.translate('freshPicks')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().slide(begin: const Offset(0, 0.1)).fadeIn(),
          const SizedBox(height: 16),
          ...briefs.map(
            (brief) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            brief.coverUrl,
                            width: 96,
                            height: 96,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              brief.headline,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              brief.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Theme.of(context).hintColor),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Chip(
                                  label: Text(brief.durationLabel),
                                  avatar: const Icon(Icons.timelapse, size: 16),
                                ),
                                Chip(
                                  label: Text(brief.mood),
                                  avatar:
                                      const Icon(Icons.waves_outlined, size: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.play_circle_fill),
                        tooltip: loc.translate('startFlow'),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 240.ms).slide(begin: const Offset(0, 0.08)),
            ),
          ),
        ],
      ),
    );
  }
}
