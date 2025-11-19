class DownloadItem {
  final String id;
  final String title;
  final String coverUrl;
  final int progress;
  final bool completed;

  const DownloadItem({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.progress,
    required this.completed,
  });
}
