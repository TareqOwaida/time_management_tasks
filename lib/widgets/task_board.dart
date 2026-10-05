import 'package:flutter/material.dart';

import '../models/planner_models.dart';
import 'responsive_layout.dart';
import 'section_title.dart';
import 'task_card.dart';

class TaskBoard extends StatelessWidget {
  const TaskBoard({super.key, required this.tasks, required this.activeTheme});

  final List<TaskItem> tasks;
  final LuxeTheme activeTheme;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          icon: Icons.checklist_rounded,
          title: 'Priority Tasks',
          color: activeTheme.gold,
        ),
        SizedBox(height: layout.isCompact ? 12 : 14),
        for (final task in tasks) ...[
          TaskCard(task: task, activeTheme: activeTheme),
          SizedBox(height: layout.isCompact ? 10 : 12),
        ],
      ],
    );
  }
}
