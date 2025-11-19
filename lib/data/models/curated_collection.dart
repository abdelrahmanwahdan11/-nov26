class CuratedCollection {
  final String id;
  final String title;
  final String subtitle;
  final String coverUrl;
  final List<String> tags;

  const CuratedCollection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.coverUrl,
    required this.tags,
  });
}
