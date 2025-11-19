class GoalState {
  final int targetMinutes;
  final int todayMinutes;
  final bool reminderEnabled;
  final bool focusMode;

  const GoalState({
    required this.targetMinutes,
    required this.todayMinutes,
    required this.reminderEnabled,
    required this.focusMode,
  });

  factory GoalState.initial() => const GoalState(
        targetMinutes: 30,
        todayMinutes: 0,
        reminderEnabled: false,
        focusMode: false,
      );

  GoalState copyWith({
    int? targetMinutes,
    int? todayMinutes,
    bool? reminderEnabled,
    bool? focusMode,
  }) {
    return GoalState(
      targetMinutes: targetMinutes ?? this.targetMinutes,
      todayMinutes: todayMinutes ?? this.todayMinutes,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      focusMode: focusMode ?? this.focusMode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'targetMinutes': targetMinutes,
      'todayMinutes': todayMinutes,
      'reminderEnabled': reminderEnabled,
      'focusMode': focusMode,
    };
  }

  factory GoalState.fromMap(Map<String, dynamic> map) {
    return GoalState(
      targetMinutes: map['targetMinutes'] ?? 30,
      todayMinutes: map['todayMinutes'] ?? 0,
      reminderEnabled: map['reminderEnabled'] ?? false,
      focusMode: map['focusMode'] ?? false,
    );
  }
}
