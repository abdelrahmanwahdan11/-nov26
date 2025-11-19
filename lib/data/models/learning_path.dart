class LearningPath {
  const LearningPath({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.focus,
    required this.progress,
    required this.steps,
    required this.coverUrl,
    required this.minutesPerDay,
    required this.featured,
    required this.tags,
  });

  final String id;
  final String title;
  final String subtitle;
  final String focus;
  final double progress;
  final List<String> steps;
  final String coverUrl;
  final int minutesPerDay;
  final bool featured;
  final List<String> tags;
}
