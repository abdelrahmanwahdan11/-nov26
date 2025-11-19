class RitualBlueprint {
  final String id;
  final String title;
  final String description;
  final String focus;
  final int durationMinutes;
  final List<String> steps;

  const RitualBlueprint({
    required this.id,
    required this.title,
    required this.description,
    required this.focus,
    required this.durationMinutes,
    required this.steps,
  });
}
