class LiveSession {
  const LiveSession({
    required this.id,
    required this.title,
    required this.host,
    required this.timeLabel,
    required this.mood,
    required this.coverUrl,
    required this.lengthLabel,
  });

  final String id;
  final String title;
  final String host;
  final String timeLabel;
  final String mood;
  final String coverUrl;
  final String lengthLabel;
}
