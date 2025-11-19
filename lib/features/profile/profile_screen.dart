import 'package:audiobook_ebooks/core/controllers/goals_controller.dart';
import 'package:audiobook_ebooks/core/controllers/navigation_controller.dart';
import 'package:audiobook_ebooks/core/controllers/theme_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/features/library/downloads_center_screen.dart';
import 'package:audiobook_ebooks/features/home/community_feed_screen.dart';
import 'package:audiobook_ebooks/features/home/schedule_screen.dart';
import 'package:audiobook_ebooks/features/profile/clubs_screen.dart';
import 'package:audiobook_ebooks/features/profile/goals_screen.dart';
import 'package:audiobook_ebooks/features/profile/learning_paths_screen.dart';
import 'package:audiobook_ebooks/features/profile/journey_screen.dart';
import 'package:audiobook_ebooks/features/profile/achievements_showcase_screen.dart';
import 'package:audiobook_ebooks/features/profile/notifications_screen.dart';
import 'package:audiobook_ebooks/features/profile/progress_hub_screen.dart';
import 'package:audiobook_ebooks/features/profile/reading_stats_screen.dart';
import 'package:audiobook_ebooks/features/profile/sessions_planner_screen.dart';
import 'package:audiobook_ebooks/features/profile/coach_screen.dart';
import 'package:audiobook_ebooks/features/profile/ritual_lab_screen.dart';
import 'package:audiobook_ebooks/features/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.themeController,
    required this.goalsController,
    this.navController,
    this.tabIndex = 3,
  });
  final ThemeController themeController;
  final GoalsController goalsController;
  final NavigationController? navController;
  final int tabIndex;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.navController
        ?.registerReselect(widget.tabIndex, () => _scroll.animateTo(
              0,
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeOutCubic,
            ));
  }

  @override
  void dispose() {
    widget.navController?.unregisterReselect(widget.tabIndex);
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('profile'))),
      body: ListView(
        controller: _scroll,
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/seed/profile/80/80'),
            ),
            title: const Text('Jane Listener'),
            subtitle: const Text('jane@example.com'),
          ),
          const SizedBox(height: 12),
          _ProfileAction(
            title: loc.translate('notificationCenter'),
            icon: Icons.notifications_active_outlined,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('schedule'),
            icon: Icons.calendar_month,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ScheduleScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('communityStories'),
            icon: Icons.groups_2_outlined,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CommunityFeedScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('ritualLab'),
            icon: Icons.science_outlined,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RitualLabScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('readingStats'),
            icon: Icons.auto_graph,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ReadingStatsScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('achievementsCabinet'),
            icon: Icons.workspace_premium,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AchievementsShowcaseScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('goals'),
            icon: Icons.track_changes,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GoalsScreen(goalsController: widget.goalsController),
                ),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('learningPaths'),
            icon: Icons.route,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LearningPathsScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('journey'),
            icon: Icons.timeline,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const JourneyScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('coachTitle'),
            icon: Icons.auto_fix_high,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CoachScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('clubs'),
            icon: Icons.podcasts,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ClubsScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('sessionPlanner'),
            icon: Icons.event_available,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SessionsPlannerScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('progressCenter'),
            icon: Icons.emoji_events,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProgressHubScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('downloadsCenter'),
            icon: Icons.offline_pin,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DownloadsCenterScreen()),
              );
            },
          ),
          _ProfileAction(
            title: loc.translate('settings'),
            icon: Icons.tune,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(themeController: widget.themeController),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileAction extends StatelessWidget {
  const _ProfileAction({required this.title, required this.icon, required this.onTap});

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    ).animate().fadeIn(duration: 220.ms).slide(begin: const Offset(0, .05));
  }
}
