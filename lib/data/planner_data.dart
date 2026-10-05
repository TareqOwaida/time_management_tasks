import 'package:flutter/material.dart';

import '../models/planner_models.dart';

const plannerThemes = [
  LuxeTheme('Champagne', Color(0xFFD6B46D), Color(0xFF9BD8C4)),
  LuxeTheme('Emerald', Color(0xFF7BD389), Color(0xFFE7C873)),
  LuxeTheme('Ruby', Color(0xFFE56B6F), Color(0xFFF2CC8F)),
];

const plannerTasks = [
  TaskItem(
    'Design weekly roadmap',
    'Strategy',
    '10:00 AM',
    0.84,
    TaskPriority.high,
  ),
  TaskItem(
    'Review client notes',
    'Admin',
    '11:30 AM',
    0.42,
    TaskPriority.medium,
  ),
  TaskItem('Deep work sprint', 'Focus', '01:00 PM', 0.65, TaskPriority.high),
  TaskItem('Plan tomorrow', 'Personal', '05:15 PM', 0.22, TaskPriority.low),
];

const plannerSchedule = [
  ScheduleItem('08:30', 'Morning review', 'Set top three priorities'),
  ScheduleItem('10:00', 'Creative block', 'No meetings, no messages'),
  ScheduleItem('13:00', 'Execution sprint', 'Finish high-value task'),
  ScheduleItem('16:30', 'Wrap up', 'Clean board and prepare tomorrow'),
];
