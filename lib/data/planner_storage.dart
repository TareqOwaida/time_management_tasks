import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/planner_models.dart';
import 'planner_data.dart';

class PlannerStorage {
  static const _selectedThemeKey = 'selected_theme';
  static const _focusModeKey = 'focus_mode';
  static const _dailyGoalKey = 'daily_goal';
  static const _tasksKey = 'tasks';
  static const _scheduleKey = 'schedule';

  PlannerStorage(this._preferences);

  final SharedPreferences _preferences;

  static Future<PlannerStorage> create() async {
    final preferences = await SharedPreferences.getInstance();
    return PlannerStorage(preferences);
  }

  int loadSelectedTheme() {
    final saved = _preferences.getInt(_selectedThemeKey) ?? 0;
    return saved.clamp(0, plannerThemes.length - 1);
  }

  bool loadFocusMode() {
    return _preferences.getBool(_focusModeKey) ?? true;
  }

  double loadDailyGoal() {
    return _preferences.getDouble(_dailyGoalKey) ?? 6;
  }

  List<TaskItem> loadTasks() {
    final saved = _preferences.getString(_tasksKey);
    if (saved == null) {
      return List.of(plannerTasks);
    }

    try {
      final decoded = jsonDecode(saved) as List<dynamic>;
      return decoded
          .whereType<Map<String, Object?>>()
          .map(TaskItem.fromJson)
          .toList();
    } on Object {
      return List.of(plannerTasks);
    }
  }

  List<ScheduleItem> loadSchedule() {
    final saved = _preferences.getString(_scheduleKey);
    if (saved == null) {
      return List.of(plannerSchedule);
    }

    try {
      final decoded = jsonDecode(saved) as List<dynamic>;
      return decoded
          .whereType<Map<String, Object?>>()
          .map(ScheduleItem.fromJson)
          .toList();
    } on Object {
      return List.of(plannerSchedule);
    }
  }

  Future<void> saveSelectedTheme(int value) {
    return _preferences.setInt(_selectedThemeKey, value);
  }

  Future<void> saveFocusMode(bool value) {
    return _preferences.setBool(_focusModeKey, value);
  }

  Future<void> saveDailyGoal(double value) {
    return _preferences.setDouble(_dailyGoalKey, value);
  }

  Future<void> saveTasks(List<TaskItem> tasks) {
    final encoded = jsonEncode(tasks.map((task) => task.toJson()).toList());
    return _preferences.setString(_tasksKey, encoded);
  }

  Future<void> saveSchedule(List<ScheduleItem> schedule) {
    final encoded = jsonEncode(schedule.map((item) => item.toJson()).toList());
    return _preferences.setString(_scheduleKey, encoded);
  }
}
