class MindfulMoment {
  const MindfulMoment({
    required this.id,
    required this.title,
    required this.description,
    required this.mood,
    required this.durationLabel,
    required this.coverUrl,
    required this.cues,
  });

  final String id;
  final String title;
  final String description;
  final String mood;
  final String durationLabel;
  final String coverUrl;
  final List<String> cues;
}
