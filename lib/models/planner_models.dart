import 'package:flutter/material.dart';

class LuxeTheme {
  const LuxeTheme(this.name, this.gold, this.accent);

  final String name;
  final Color gold;
  final Color accent;
}

class TaskItem {
  const TaskItem(
    this.title,
    this.category,
    this.time,
    this.progress,
    this.priority,
  );

  final String title;
  final String category;
  final String time;
  final double progress;
  final TaskPriority priority;

  factory TaskItem.fromJson(Map<String, Object?> json) {
    return TaskItem(
      json['title'] as String? ?? '',
      json['category'] as String? ?? '',
      json['time'] as String? ?? '',
      (json['progress'] as num?)?.toDouble() ?? 0,
      TaskPriority.values.byName(json['priority'] as String? ?? 'low'),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'category': category,
      'time': time,
      'progress': progress,
      'priority': priority.name,
    };
  }
}

class ScheduleItem {
  const ScheduleItem(this.time, this.title, this.note);

  final String time;
  final String title;
  final String note;

  factory ScheduleItem.fromJson(Map<String, Object?> json) {
    return ScheduleItem(
      json['time'] as String? ?? '',
      json['title'] as String? ?? '',
      json['note'] as String? ?? '',
    );
  }

  Map<String, Object?> toJson() {
    return {'time': time, 'title': title, 'note': note};
  }
}

enum TaskPriority { high, medium, low }
