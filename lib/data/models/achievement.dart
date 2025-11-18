class Achievement {
  final String id;
  final String title;
  final String description;
  final int progress;
  final int target;
  final String badgeUrl;
  final bool completed;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.badgeUrl,
    required this.completed,
  });
}
