import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/learning_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LearningPathsScreen extends StatefulWidget {
  const LearningPathsScreen({super.key});

  @override
  State<LearningPathsScreen> createState() => _LearningPathsScreenState();
}

class _LearningPathsScreenState extends State<LearningPathsScreen> {
  final PageController _heroController = PageController(viewportFraction: 0.85);
  int _heroIndex = 0;
  String _filter = 'all';

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final heroCandidates =
        DummyData.learningPaths.where((p) => p.featured).toList();
    final heroPaths = heroCandidates.isEmpty
        ? DummyData.learningPaths
        : heroCandidates;
    final filtered = DummyData.learningPaths.where((path) {
      if (_filter == 'all') return true;
      return path.focus.toLowerCase() == _filter;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('learningPaths'))),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          SizedBox(
            height: 260,
            child: PageView.builder(
              controller: _heroController,
              onPageChanged: (value) => setState(() => _heroIndex = value),
              itemCount: heroPaths.length,
              itemBuilder: (context, index) {
                final path = heroPaths[index];
                return AnimatedBuilder(
                  animation: _heroController,
                  builder: (context, child) {
                    double value = 0;
                    if (_heroController.hasClients &&
                        _heroController.position.haveDimensions) {
                      value = index.toDouble() -
                          (_heroController.page ??
                              _heroController.initialPage.toDouble());
                      value = (value * 0.06).clamp(-1.0, 1.0);
                    }
                    return Transform.translate(
                      offset: Offset(-24 * value, 0),
                      child: Transform.scale(
                        scale: 1 - (value.abs() * 0.12),
                        child: child,
                      ),
                    );
                  },
                  child: _HeroPathCard(path: path, loc: loc),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: 300.ms,
            child: _PathSteps(
              key: ValueKey(heroPaths[_heroIndex % heroPaths.length].id),
              path: heroPaths[_heroIndex % heroPaths.length],
              loc: loc,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            loc.translate('learningPathsHeadline'),
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _filters(loc).entries.map((entry) {
              return ChoiceChip(
                label: Text(entry.value),
                selected: _filter == entry.key,
                onSelected: (_) => setState(() => _filter = entry.key),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          ...filtered.map(
            (path) => _LearningPathTile(path: path, loc: loc),
          ),
        ],
      ),
    );
  }

  Map<String, String> _filters(AppLocalizations loc) => {
        'all': loc.translate('pathFiltersAll'),
        'focus': loc.translate('pathFiltersFocus'),
        'calm': loc.translate('pathFiltersCalm'),
        'growth': loc.translate('pathFiltersGrowth'),
      };
}

class _HeroPathCard extends StatelessWidget {
  const _HeroPathCard({required this.path, required this.loc});

  final LearningPath path;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(.15),
              theme.colorScheme.secondary.withOpacity(.08),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                child: Image.network(
                  path.coverUrl,
                  width: 160,
                  fit: BoxFit.cover,
                ).animate().shimmer(duration: 1.seconds),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(path.focus.toUpperCase()),
                    backgroundColor: theme.colorScheme.primary.withOpacity(.1),
                  ),
                  const Spacer(),
                  Text(
                    path.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ).animate().fadeIn(duration: 250.ms, delay: 100.ms),
                  const SizedBox(height: 8),
                  Text(path.subtitle, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: path.progress),
                    duration: 450.ms,
                    builder: (context, value, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinearProgressIndicator(value: value, minHeight: 6),
                          const SizedBox(height: 6),
                          Text('${(value * 100).round()}% · ${loc.translate('resumePath')}'),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slide(begin: const Offset(0, 0.08));
  }
}

class _PathSteps extends StatelessWidget {
  const _PathSteps({super.key, required this.path, required this.loc});

  final LearningPath path;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('pathStepsTitle'),
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...path.steps.asMap().entries.map(
              (entry) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 18,
                  backgroundColor: theme.colorScheme.primary.withOpacity(.1),
                  child: Text('${entry.key + 1}'),
                ).animate().scale(duration: 250.ms),
                title: Text(entry.value),
                trailing: const Icon(Icons.check_circle_outline),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.playlist_add_check_circle),
              label: Text(loc.translate('pathSecondaryCta')),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slide(begin: const Offset(0, 0.04));
  }
}

class _LearningPathTile extends StatelessWidget {
  const _LearningPathTile({required this.path, required this.loc});

  final LearningPath path;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                path.coverUrl,
                width: 96,
                height: 120,
                fit: BoxFit.cover,
              ).animate().shimmer(duration: 900.ms),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(path.title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(
                    path.subtitle,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: path.tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 16, color: theme.hintColor),
                      const SizedBox(width: 4),
                      Text(
                        '${loc.translate('pathDailyCommitment')} · ${path.minutesPerDay} ${loc.translate('minutes')}',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            RotatedBox(
              quarterTurns: 3,
              child: Text('${(path.progress * 100).round()}%'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 320.ms).slide(begin: const Offset(0, 0.05));
  }
}
