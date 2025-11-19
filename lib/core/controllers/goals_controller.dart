import 'package:audiobook_ebooks/data/models/goal_state.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsController {
  final ValueNotifier<GoalState> state =
      ValueNotifier<GoalState>(GoalState.initial());

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final map = {
      'targetMinutes': prefs.getInt('goal_target') ?? 30,
      'todayMinutes': prefs.getInt('goal_today') ?? 0,
      'reminderEnabled': prefs.getBool('goal_reminder') ?? false,
      'focusMode': prefs.getBool('goal_focus') ?? false,
    };
    state.value = GoalState.fromMap(map);
  }

  Future<void> setTarget(int minutes) async {
    state.value = state.value.copyWith(targetMinutes: minutes);
    await _persist();
  }

  Future<void> toggleReminder(bool enabled) async {
    state.value = state.value.copyWith(reminderEnabled: enabled);
    await _persist();
  }

  Future<void> toggleFocusMode(bool enabled) async {
    state.value = state.value.copyWith(focusMode: enabled);
    await _persist();
  }

  Future<void> logMinutes(int minutes) async {
    final maxCap = state.value.targetMinutes * 2;
    final newMinutes = (state.value.todayMinutes + minutes).clamp(0, maxCap);
    state.value = state.value.copyWith(todayMinutes: newMinutes);
    await _persist();
  }

  Future<void> resetToday() async {
    state.value = state.value.copyWith(todayMinutes: 0);
    await _persist();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('goal_target', state.value.targetMinutes);
    await prefs.setInt('goal_today', state.value.todayMinutes);
    await prefs.setBool('goal_reminder', state.value.reminderEnabled);
    await prefs.setBool('goal_focus', state.value.focusMode);
  }

  void dispose() {
    state.dispose();
  }
}
