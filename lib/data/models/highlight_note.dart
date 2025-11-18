class HighlightNote {
  final String id;
  final String bookTitle;
  final String chapterTitle;
  final String snippet;
  final String mood;
  final String coverUrl;
  final String timeLabel;
  final List<String> tags;

  const HighlightNote({
    required this.id,
    required this.bookTitle,
    required this.chapterTitle,
    required this.snippet,
    required this.mood,
    required this.coverUrl,
    required this.timeLabel,
    required this.tags,
  });
}
