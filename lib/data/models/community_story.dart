class CommunityStory {
  final String id;
  final String userName;
  final String userAvatarUrl;
  final String coverUrl;
  final String snippet;
  final String mood;
  final int minutes;
  final int likes;
  final int comments;
  final String timeAgo;

  const CommunityStory({
    required this.id,
    required this.userName,
    required this.userAvatarUrl,
    required this.coverUrl,
    required this.snippet,
    required this.mood,
    required this.minutes,
    required this.likes,
    required this.comments,
    required this.timeAgo,
  });
}
