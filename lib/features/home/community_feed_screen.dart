import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/core/widgets/ai_info_button.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/community_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CommunityFeedScreen extends StatefulWidget {
  const CommunityFeedScreen({super.key});

  @override
  State<CommunityFeedScreen> createState() => _CommunityFeedScreenState();
}

class _CommunityFeedScreenState extends State<CommunityFeedScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final filters = [
      loc.translate('communityTrending'),
      loc.translate('communityFresh'),
      loc.translate('communityFocus'),
      loc.translate('communityCalm'),
    ];
    final stories = DummyData.communityStories;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('communityStories')),
        actions: const [AiInfoButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          _HeroHeader(
            subtitle: loc.translate('communityStoriesSubtitle'),
            badge: filters[_selectedFilter],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (int i = 0; i < filters.length; i++)
                ChoiceChip(
                  selected: _selectedFilter == i,
                  label: Text(filters[i]),
                  onSelected: (_) => setState(() => _selectedFilter = i),
                ),
            ],
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: 16),
          for (int i = 0; i < stories.length; i++)
            _StoryCard(
              story: stories[i],
              index: i,
              loc: loc,
            ),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.subtitle, required this.badge});

  final String subtitle;
  final String badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(.9),
            theme.colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            right: 20,
            child: Chip(
              label: Text(badge),
              backgroundColor: Colors.white.withOpacity(.15),
              side: BorderSide(color: Colors.white.withOpacity(.2)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ).animate().fadeIn(duration: 400.ms).slide(begin: const Offset(0, .2)),
                const Spacer(),
                FilledButton.tonal(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    foregroundColor: theme.colorScheme.onPrimaryContainer,
                    backgroundColor: Colors.white.withOpacity(.2),
                  ),
                  child: Text(AppLocalizations.of(context).translate('communityCta')),
                ).animate().scale(begin: const Offset(.95, .95)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slide(begin: const Offset(0, .1));
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.story,
    required this.index,
    required this.loc,
  });

  final CommunityStory story;
  final int index;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        color: theme.colorScheme.surfaceVariant.withOpacity(.4),
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppConstants.cardRadius),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    story.coverUrl,
                    fit: BoxFit.cover,
                    height: 180,
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(.65), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Row(
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(story.userAvatarUrl)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          story.userName,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Chip(
                        label: Text(story.mood),
                        backgroundColor: Colors.white.withOpacity(.2),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.snippet,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 18, color: theme.colorScheme.primary),
                    const SizedBox(width: 6),
                    Text('${story.minutes}${loc.translate('minutes')} · ${story.timeAgo}'),
                    const Spacer(),
                    Icon(Icons.favorite_border, size: 18, color: theme.colorScheme.error),
                    const SizedBox(width: 4),
                    Text('${story.likes}'),
                    const SizedBox(width: 12),
                    Icon(Icons.mode_comment_outlined, size: 18),
                    const SizedBox(width: 4),
                    Text('${story.comments}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 80).ms).fadeIn(duration: 400.ms).slide(begin: const Offset(0, .1));
  }
}
