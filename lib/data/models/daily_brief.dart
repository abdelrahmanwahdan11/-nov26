class DailyBrief {
  const DailyBrief({
    required this.id,
    required this.headline,
    required this.subtitle,
    required this.coverUrl,
    required this.durationLabel,
    required this.mood,
  });

  final String id;
  final String headline;
  final String subtitle;
  final String coverUrl;
  final String durationLabel;
  final String mood;
}
