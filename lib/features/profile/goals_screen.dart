import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/controllers/goals_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key, required this.goalsController});
  final GoalsController goalsController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('goals'))),
      body: ValueListenableBuilder(
        valueListenable: goalsController.state,
        builder: (context, state, _) {
          final progress = (state.todayMinutes / state.targetMinutes).clamp(0, 1.0);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withOpacity(.16),
                        theme.colorScheme.primary.withOpacity(.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(.2),
                        blurRadius: 20,
                        offset: const Offset(0, 12),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.translate('dailyFocus'),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(loc.translate('goalHeroCopy')),
                      const SizedBox(height: 16),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 160,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 12,
                            ).animate().shimmer(duration: 600.ms),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${(progress * 100).round()}%',
                                style: theme.textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text('${state.todayMinutes}/${state.targetMinutes} ${loc.translate('minutes')}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().slide(begin: const Offset(0, .05)).fadeIn(),
                const SizedBox(height: 20),
                _settingCard(
                  context,
                  title: loc.translate('adjustGoal'),
                  subtitle: loc.translate('goalAdjustCopy'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${state.targetMinutes} ${loc.translate('minutes')}'),
                      Slider(
                        value: state.targetMinutes.toDouble(),
                        min: 10,
                        max: 180,
                        onChanged: (v) => goalsController.setTarget(v.round()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _settingCard(
                  context,
                  title: loc.translate('reminder'),
                  subtitle: loc.translate('reminderCopy'),
                  trailing: Switch(
                    value: state.reminderEnabled,
                    onChanged: goalsController.toggleReminder,
                  ),
                ),
                const SizedBox(height: 12),
                _settingCard(
                  context,
                  title: loc.translate('focusMode'),
                  subtitle: loc.translate('focusCopy'),
                  trailing: Switch(
                    value: state.focusMode,
                    onChanged: goalsController.toggleFocusMode,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => goalsController.logMinutes(15),
                        icon: const Icon(Icons.timer),
                        label: Text(loc.translate('logFifteen')),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: goalsController.resetToday,
                        child: Text(loc.translate('resetToday')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _settingCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(subtitle, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(width: 12),
            trailing,
          ],
        ),
      ),
    ).animate().fadeIn().slide(begin: const Offset(.05, 0));
  }
}
