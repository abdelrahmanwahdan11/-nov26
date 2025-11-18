import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AchievementsShowcaseScreen extends StatelessWidget {
  const AchievementsShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final achievements = DummyData.achievements;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('achievementsCabinet'))),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.9,
        ),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          final progress = achievement.progress / achievement.target;
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(achievement.badgeUrl),
                        radius: 24,
                      ).animate().scale(begin: const Offset(.9, .9), duration: 220.ms),
                      const Spacer(),
                      Icon(
                        achievement.completed ? Icons.check_circle : Icons.bolt,
                        color: achievement.completed ? Colors.green : theme.colorScheme.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    achievement.title,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    achievement.description,
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                  ),
                  const Spacer(),
                  LinearProgressIndicator(
                    value: progress.clamp(0, 1),
                    borderRadius: BorderRadius.circular(24),
                  ).animate().shimmer(duration: 1.seconds),
                  const SizedBox(height: 6),
                  Text(
                    '${achievement.progress}/${achievement.target} ${loc.translate('days')}',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 280.ms).slide(begin: const Offset(0, 0.05));
        },
      ),
    );
  }
}
