import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/coach_tip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final tips = DummyData.coachTips;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('coachTitle')),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome_motion),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(loc.translate('aiSoon'))),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          Text(
            loc.translate('coachHero'),
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(loc.translate('coachSub'), style: theme.textTheme.bodyMedium),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tips.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final tip = tips[index];
                return _CoachCard(tip: tip)
                    .animate()
                    .fadeIn(duration: 240.ms, delay: (index * 40).ms)
                    .slide(begin: const Offset(0.05, 0));
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            loc.translate('microActions'),
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...DummyData.microTasks.asMap().entries.map(
            (entry) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primary.withOpacity(.12),
                  child: Text('${entry.key + 1}'),
                ),
                title: Text(entry.value),
                trailing: const Icon(Icons.chevron_right),
              ),
            )
                .animate()
                .fadeIn(duration: 200.ms, delay: (entry.key * 40).ms)
                .slide(begin: const Offset(0, .03)),
          ),
        ],
      ),
    );
  }
}

class _CoachCard extends StatelessWidget {
  const _CoachCard({required this.tip});

  final CoachTip tip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 260,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(.1)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(.08),
            blurRadius: 14,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              tip.illustrationUrl,
              height: 90,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tip.title,
            style:
                theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(tip.subtitle, style: theme.textTheme.bodySmall),
          const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.tonal(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(tip.actionLabel)),
              ),
              child: Text(tip.actionLabel),
            ),
          )
        ],
      ),
    );
  }
}
