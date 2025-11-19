import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/mindful_moment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MindfulMomentsScreen extends StatefulWidget {
  const MindfulMomentsScreen({super.key});

  @override
  State<MindfulMomentsScreen> createState() => _MindfulMomentsScreenState();
}

class _MindfulMomentsScreenState extends State<MindfulMomentsScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.86);
  int _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final moments = DummyData.mindfulMoments;
    final current = moments[_index % moments.length];

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('mindfulMoments'))),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          Text(
            loc.translate('mindfulMomentsHeadline'),
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(loc.translate('mindfulMomentsSubtitle'), style: theme.textTheme.bodyMedium),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: PageView.builder(
              controller: _pageController,
              itemCount: moments.length,
              onPageChanged: (value) => setState(() => _index = value),
              itemBuilder: (context, index) {
                final moment = moments[index];
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double pageOffset = 0;
                    if (_pageController.hasClients &&
                        _pageController.position.haveDimensions) {
                      pageOffset = index -
                          (_pageController.page ??
                              _pageController.initialPage.toDouble());
                    }
                    final scale = (1 - (pageOffset.abs() * 0.08)).clamp(.9, 1.0);
                    final opacity = (1 - pageOffset.abs()).clamp(.4, 1.0);
                    return Transform.scale(
                      scale: scale,
                      child: Opacity(opacity: opacity, child: child),
                    );
                  },
                  child: _MomentCard(moment: moment),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Wrap(
              spacing: 6,
              children: List.generate(
                moments.length,
                (i) => AnimatedContainer(
                  duration: 250.ms,
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _index % moments.length
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primary.withOpacity(.2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: 300.ms,
            child: Column(
              key: ValueKey(current.id),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(current.title, style: theme.textTheme.titleLarge),
                const SizedBox(height: 6),
                Text(current.description),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: current.cues
                      .map((cue) => Chip(
                            label: Text(cue),
                            backgroundColor: theme.colorScheme.primary.withOpacity(.08),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sensors),
                  label: Text(loc.translate('mindfulMomentsCta')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            loc.translate('mindfulMomentsSecondary'),
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ...moments.map(
            (moment) => _MomentListTile(
              moment: moment,
              loc: loc,
              isCurrent: moment.id == current.id,
            ),
          ),
        ],
      ),
    );
  }
}

class _MomentCard extends StatelessWidget {
  const _MomentCard({required this.moment});

  final MindfulMoment moment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(.15),
              blurRadius: 16,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  moment.coverUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(.65),
                        Colors.black.withOpacity(.3),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(
                      label: Text('${moment.durationLabel} · ${moment.mood}'),
                      backgroundColor: Colors.white.withOpacity(.2),
                      labelStyle: theme.textTheme.labelMedium?.copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      moment.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      moment.description,
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 350.ms).scale(begin: const Offset(.95, .95));
  }
}

class _MomentListTile extends StatelessWidget {
  const _MomentListTile({
    required this.moment,
    required this.loc,
    required this.isCurrent,
  });

  final MindfulMoment moment;
  final AppLocalizations loc;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: isCurrent ? theme.colorScheme.primary.withOpacity(.08) : null,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(moment.coverUrl, width: 52, height: 52, fit: BoxFit.cover),
        ),
        title: Text(moment.title),
        subtitle: Text(moment.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(moment.durationLabel, style: theme.textTheme.labelMedium),
            const SizedBox(height: 6),
            Text(
              isCurrent ? loc.translate('resumePath') : loc.translate('startNow'),
              style: theme.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 280.ms).slide(begin: const Offset(0, 0.04));
  }
}
