import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/listening_club.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('clubs')),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppConstants.padding),
        itemBuilder: (_, index) {
          final club = DummyData.listeningClubs[index];
          return _ClubTile(club: club, loc: loc, theme: theme)
              .animate()
              .fadeIn(duration: 250.ms)
              .slide(begin: const Offset(0, .06));
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: DummyData.listeningClubs.length,
      ),
    );
  }
}

class _ClubTile extends StatelessWidget {
  const _ClubTile({
    required this.club,
    required this.loc,
    required this.theme,
  });

  final ListeningClub club;
  final AppLocalizations loc;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      elevation: 8,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  club.coverUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            club.title,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(.1),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            club.mood,
                            style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${loc.translate('hostedBy')} ${club.host}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${loc.translate('nextSession')} ${club.timeLabel}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.group, size: 16, color: theme.hintColor),
                        const SizedBox(width: 4),
                        Text('${club.members} ${loc.translate('listeners')}',
                            style: theme.textTheme.labelMedium),
                        const Spacer(),
                        FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.headphones),
                          label: Text(loc.translate('joinClub')),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
