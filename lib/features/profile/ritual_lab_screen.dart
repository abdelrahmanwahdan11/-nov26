import 'dart:math';

import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/ritual_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RitualLabScreen extends StatefulWidget {
  const RitualLabScreen({super.key});

  @override
  State<RitualLabScreen> createState() => _RitualLabScreenState();
}

class _RitualLabScreenState extends State<RitualLabScreen> {
  double _intensity = 0.6;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final blueprints = DummyData.ritualBlueprints;
    final ideas = DummyData.ritualIdeas;
    final theme = Theme.of(context);
    final color = Color.lerp(
          theme.colorScheme.primary,
          theme.colorScheme.secondary,
          _intensity,
        ) ??
        theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('ritualLab'))),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          _HeroMixer(
            color: color,
            intensity: _intensity,
            subtitle: loc.translate('ritualLabSubtitle'),
            onChanged: (value) => setState(() => _intensity = value),
          ),
          const SizedBox(height: 16),
          Text(
            loc.translate('ritualBlueprints'),
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < blueprints.length; i++)
            _BlueprintCard(
              blueprint: blueprints[i],
              index: i,
              loc: loc,
            ),
          const SizedBox(height: 8),
          Text(
            loc.translate('ritualIdeas'),
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final idea in ideas)
                Chip(
                  label: Text(idea),
                  avatar: const Icon(Icons.lightbulb_outline, size: 16),
                ).animate().fadeIn(duration: 300.ms),
            ],
          ),
          const SizedBox(height: 16),
          _LabTips(loc: loc),
        ],
      ),
    );
  }
}

class _HeroMixer extends StatelessWidget {
  const _HeroMixer({
    required this.color,
    required this.intensity,
    required this.subtitle,
    required this.onChanged,
  });

  final Color color;
  final double intensity;
  final String subtitle;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: 350.ms,
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        gradient: LinearGradient(
          colors: [color.withOpacity(.9), color.withOpacity(.5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: theme.textTheme.titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          Slider(
            value: intensity,
            onChanged: onChanged,
          ),
          Text(
            '${(intensity * 100).round()}% vibe',
            style: theme.textTheme.labelLarge?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slide(begin: const Offset(0, .1));
  }
}

class _BlueprintCard extends StatelessWidget {
  const _BlueprintCard({
    required this.blueprint,
    required this.index,
    required this.loc,
  });

  final RitualBlueprint blueprint;
  final int index;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    blueprint.title,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Chip(
                  label: Text(blueprint.focus),
                ),
                const SizedBox(width: 8),
                Chip(
                  avatar: const Icon(Icons.schedule, size: 16),
                  label: Text('${blueprint.durationMinutes}${loc.translate('minutes')}'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              blueprint.description,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              loc.translate('ritualSteps'),
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            for (final step in blueprint.steps)
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(step)),
                ],
              ),
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton(
                onPressed: () {},
                child: Text(loc.translate('ritualStart')),
              ),
            ),
          ],
        ),
      ),
    ).animate(delay: (index * 90).ms).fadeIn(duration: 350.ms).slide(begin: const Offset(0, .08));
  }
}

class _LabTips extends StatelessWidget {
  const _LabTips({required this.loc});

  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tips = [
      loc.translate('ritualTipEnergy'),
      loc.translate('ritualTipLength'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.translate('ritualTips'),
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < tips.length; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
              color: theme.colorScheme.surfaceVariant.withOpacity(.5),
            ),
            child: Row(
              children: [
                Transform.rotate(
                  angle: pi / 24,
                  child: Icon(Icons.auto_awesome, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(tips[i])),
              ],
            ),
          ).animate(delay: (i * 120).ms).fadeIn(duration: 300.ms).slide(begin: const Offset(0, .06)),
      ],
    );
  }
}
