import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/controllers/books_controller.dart';
import 'package:audiobook_ebooks/core/controllers/comparison_controller.dart';
import 'package:audiobook_ebooks/core/controllers/goals_controller.dart';
import 'package:audiobook_ebooks/core/controllers/navigation_controller.dart';
import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/core/widgets/ai_info_button.dart';
import 'package:audiobook_ebooks/core/widgets/skeleton.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:audiobook_ebooks/features/book_detail/book_detail_screen.dart';
import 'package:audiobook_ebooks/features/comparison/comparison_screen.dart';
import 'package:audiobook_ebooks/features/home/daily_brief_screen.dart';
import 'package:audiobook_ebooks/features/home/immersion_room_screen.dart';
import 'package:audiobook_ebooks/features/home/mindful_moments_screen.dart';
import 'package:audiobook_ebooks/features/home/schedule_screen.dart';
import 'package:audiobook_ebooks/features/library/highlights_screen.dart';
import 'package:audiobook_ebooks/features/profile/notifications_screen.dart';
import 'package:audiobook_ebooks/features/profile/learning_paths_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.booksController,
    required this.comparisonController,
    required this.goalsController,
    this.navController,
    this.tabIndex = 0,
  });

  final BooksController booksController;
  final ComparisonController comparisonController;
  final GoalsController goalsController;
  final NavigationController? navController;
  final int tabIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.navController?.registerReselect(
      widget.tabIndex,
      () => _scrollToTop(animated: true),
    );
  }

  @override
  void dispose() {
    widget.navController?.unregisterReselect(widget.tabIndex);
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToTop({bool animated = false}) {
    if (!_scroll.hasClients) return;
    if (animated) {
      _scroll.animateTo(
        0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      _scroll.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('home')),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ScheduleScreen()),
              );
            },
          ),
          const AiInfoButton(),
        ],
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: comparisonController.selected,
        builder: (context, selected, _) {
          if (selected.length < 2) return const SizedBox.shrink();
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ComparisonScreen(
                    comparisonController: comparisonController,
                  ),
                ),
              );
            },
            label: Text(loc.translate('compare')),
            icon: const Icon(Icons.compare_arrows),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async => widget.booksController.refresh(),
        child: ValueListenableBuilder(
          valueListenable: widget.booksController.isLoading,
          builder: (context, loading, _) {
            if (loading) {
              return ListView.builder(
                padding: const EdgeInsets.all(AppConstants.padding),
                controller: _scroll,
                itemCount: 3,
                itemBuilder: (_, __) => const SkeletonListTile(),
              );
            }
            return ValueListenableBuilder(
              valueListenable: widget.booksController.books,
              builder: (context, books, _) {
                return ListView(
                  padding: const EdgeInsets.all(AppConstants.padding),
                  controller: _scroll,
                  children: [
                    _FocusCard(goalsController: widget.goalsController),
                    const SizedBox(height: 12),
                    _ScheduleTeaser(loc: loc),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ActionChip(
                          label: Text(loc.translate('openInbox')),
                          avatar: const Icon(Icons.mark_email_unread_outlined),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const NotificationsScreen()),
                            );
                          },
                        ),
                        ActionChip(
                          label: Text(loc.translate('openSchedule')),
                          avatar: const Icon(Icons.calendar_today_outlined),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const ScheduleScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _DailyBriefTeaser(loc: loc),
                    const SizedBox(height: 12),
                    _ImmersionPreview(loc: loc),
                    const SizedBox(height: 12),
                    _HighlightsPeek(loc: loc),
                    const SizedBox(height: 12),
                    _MindfulMomentsPeek(loc: loc),
                    const SizedBox(height: 12),
                    _LearningPathsPeek(loc: loc),
                    const SizedBox(height: 20),
                    _sectionTitle(context, 'Good Morning'),
                    SizedBox(
                      height: 260,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: books.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return _BookCard(
                            book: book,
                            onOpen: () => _openDetail(context, book),
                            onSelectComparison: () =>
                                widget.comparisonController.toggle(book),
                            selected:
                                widget.comparisonController.isSelected(book),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle(context, 'Top Picks'),
                    ...books.take(4).map(
                          (b) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: _MiniTile(
                              book: b,
                              onTap: () => _openDetail(context, b),
                            ),
                          ),
                        )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: .3,
            ),
      ),
    );
  }

  void _openDetail(BuildContext context, Book book) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BookDetailScreen(book: book),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}

class _BookCard extends StatefulWidget {
  const _BookCard({
    required this.book,
    required this.onOpen,
    required this.onSelectComparison,
    required this.selected,
  });

  final Book book;
  final VoidCallback onOpen;
  final VoidCallback onSelectComparison;
  final bool selected;

  @override
  State<_BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<_BookCard> {
  bool _flipped = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onLongPress: widget.onSelectComparison,
      onTap: () async {
        setState(() => _flipped = !_flipped);
        if (!_flipped) {
          await Future.delayed(300.ms);
          widget.onOpen();
        }
      },
      child: AnimatedContainer(
        duration: 250.ms,
        width: 200,
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.12),
              blurRadius: 16,
              offset: const Offset(0, 12),
            )
          ],
          border: Border.all(
            color: widget.selected
                ? theme.colorScheme.primary
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: AnimatedSwitcher(
          duration: 300.ms,
          transitionBuilder: (child, animation) {
            final rotate = Tween(begin: _flipped ? -1.0 : 1.0, end: 0.0)
                .animate(animation);
            return AnimatedBuilder(
              animation: rotate,
              builder: (context, child) {
                final tilt = (_flipped ? -0.05 : 0.05);
                return Transform(
                  transform: Matrix4.rotationY(rotate.value + tilt),
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: child,
            );
          },
          child: _flipped
              ? _CardBack(book: widget.book, key: const ValueKey('back'))
              : _CardFront(book: widget.book, key: const ValueKey('front')),
        ),
      ).animate().fadeIn().slide(begin: const Offset(.1, 0)),
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          child: Image.network(book.coverUrl, fit: BoxFit.cover, height: 260,
              width: 200),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text('${book.rating}')
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(book.author),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.timelapse, size: 16),
              const SizedBox(width: 4),
              Text('${book.durationMinutes}m'),
              const SizedBox(width: 12),
              const Icon(Icons.lock_open, size: 16),
              const SizedBox(width: 4),
              Text(book.isLocked ? 'Locked' : 'Free'),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text('Genre: ${book.genre}'),
          )
        ],
      ),
    );
  }
}

class _MiniTile extends StatelessWidget {
  const _MiniTile({required this.book, required this.onTap});
  final Book book;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.network(book.coverUrl, width: 56, height: 56, fit: BoxFit.cover),
      ),
      title: Text(book.title),
      subtitle: Text('${book.author} · ${book.genre}'),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

class _FocusCard extends StatelessWidget {
  const _FocusCard({required this.goalsController});
  final GoalsController goalsController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return ValueListenableBuilder(
      valueListenable: goalsController.state,
      builder: (context, state, _) {
        final progress = (state.todayMinutes / state.targetMinutes).clamp(0, 1.0);
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(.14),
                theme.colorScheme.primary.withOpacity(.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(.12),
                blurRadius: 16,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.translate('dailyFocus'),
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      loc.translate('dailyGoalSub'),
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${state.todayMinutes} / ${state.targetMinutes} ${loc.translate('minutes')}',
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => goalsController.logMinutes(10),
                    icon: const Icon(Icons.flash_on),
                    label: Text(loc.translate('logTen')),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => _FocusDetail(goalsController: goalsController),
                      ),
                    ),
                    child: Text(loc.translate('adjustGoal')),
                  ),
                ],
              )
            ],
          ),
        ).animate().fadeIn(duration: 260.ms).slide(begin: const Offset(0, .05));
      },
    );
  }
}

class _ScheduleTeaser extends StatelessWidget {
  const _ScheduleTeaser({required this.loc});

  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final session = DummyData.liveSessions.first;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ScheduleScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(.12),
              theme.colorScheme.surface,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                session.coverUrl,
                width: 92,
                height: 92,
                fit: BoxFit.cover,
              ),
            ).animate().scale(begin: const Offset(.95, .95)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('todayPlan'),
                    style: theme.textTheme.labelLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    session.title,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: theme.hintColor),
                      const SizedBox(width: 6),
                      Text(session.timeLabel, style: theme.textTheme.labelMedium),
                      const SizedBox(width: 12),
                      Chip(
                        visualDensity: VisualDensity.compact,
                        label: Text(loc.translate('openSchedule')),
                        backgroundColor: theme.colorScheme.primary.withOpacity(.12),
                        labelStyle: theme.textTheme.labelMedium,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ).animate().fadeIn(duration: 250.ms).slide(begin: const Offset(0, .04)),
    );
  }
}

class _DailyBriefTeaser extends StatelessWidget {
  const _DailyBriefTeaser({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: ListTile(
        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
          ),
          child: const Icon(Icons.calendar_today, color: Colors.white),
        ),
        title: Text(loc.translate('dailyBrief')),
        subtitle: Text(loc.translate('dailyBriefHeadline')),
        trailing: Icon(Icons.arrow_forward, color: theme.colorScheme.primary),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const DailyBriefScreen()),
          );
        },
      ),
    ).animate().fadeIn(duration: 240.ms).slide(begin: const Offset(0, .05));
  }
}

class _ImmersionPreview extends StatelessWidget {
  const _ImmersionPreview({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hero = DummyData.immersions.first;
    return InkWell(
      borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ImmersionRoomScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          color: theme.colorScheme.secondaryContainer.withOpacity(.6),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('immersionRoom'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hero.subtitle,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _Chip(text: hero.mood),
                      const SizedBox(width: 8),
                      _Chip(text: '${hero.minutes} ${loc.translate('minutes')}'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                hero.coverUrl,
                width: 100,
                height: 110,
                fit: BoxFit.cover,
              ),
            ).animate().shimmer(duration: 900.ms, delay: 100.ms),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slide(begin: const Offset(0, .05));
  }
}

class _HighlightsPeek extends StatelessWidget {
  const _HighlightsPeek({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final highlight = DummyData.highlights.first;
    return InkWell(
      borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const HighlightsScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.primary.withOpacity(.08)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('highlights'),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    highlight.snippet,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    children: [
                      _Chip(text: highlight.mood),
                      _Chip(text: loc.translate('viewHighlights')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                highlight.coverUrl,
                width: 90,
                height: 100,
                fit: BoxFit.cover,
              ),
            ).animate().shimmer(duration: 1100.ms, delay: 140.ms),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 250.ms).slide(begin: const Offset(0, .04));
  }
}

class _MindfulMomentsPeek extends StatelessWidget {
  const _MindfulMomentsPeek({required this.loc});

  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hero = DummyData.mindfulMoments.first;
    return InkWell(
      borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const MindfulMomentsScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.tertiary.withOpacity(.2),
              theme.colorScheme.primary.withOpacity(.08),
            ],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('mindfulMoments'),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    loc.translate('mindfulMomentsHeadline'),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    children: hero.cues
                        .take(3)
                        .map(
                          (cue) => Chip(
                            label: Text(cue),
                            visualDensity: VisualDensity.compact,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                Icon(Icons.self_improvement,
                    color: theme.colorScheme.primary, size: 34),
                const SizedBox(height: 6),
                Text(hero.durationLabel, style: theme.textTheme.labelLarge),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 260.ms).slide(begin: const Offset(0, .04));
  }
}

class _LearningPathsPeek extends StatelessWidget {
  const _LearningPathsPeek({required this.loc});

  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hero = DummyData.learningPaths.first;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.route, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(loc.translate('learningPaths'),
                    style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            Text(hero.title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(hero.subtitle, style: theme.textTheme.bodySmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(value: hero.progress),
                ),
                const SizedBox(width: 12),
                Text('${(hero.progress * 100).round()}%'),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LearningPathsScreen()),
                ),
                child: Text(loc.translate('resumePath')),
              ),
            )
          ],
        ),
      ),
    ).animate().fadeIn(duration: 280.ms).slide(begin: const Offset(0, .04));
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

class _FocusDetail extends StatelessWidget {
  const _FocusDetail({required this.goalsController});
  final GoalsController goalsController;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('dailyFocus'))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padding),
          child: _FocusCard(goalsController: goalsController),
        ),
      ),
    );
  }
}
