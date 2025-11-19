class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  final bool isNew;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.isNew,
  });

  AppNotification copyWith({bool? isNew}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      date: date,
      isNew: isNew ?? this.isNew,
    );
  }

  String get timeLabel {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    }
    return '${diff.inDays}d ago';
  }
}
