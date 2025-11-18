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
}
