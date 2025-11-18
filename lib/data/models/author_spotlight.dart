class AuthorSpotlight {
  final String id;
  final String name;
  final String tagline;
  final String bio;
  final String coverUrl;
  final int booksCount;
  final List<String> highlights;

  const AuthorSpotlight({
    required this.id,
    required this.name,
    required this.tagline,
    required this.bio,
    required this.coverUrl,
    required this.booksCount,
    required this.highlights,
  });
}
