import 'package:flutter/material.dart';

import '../models/planner_models.dart';
import '../widgets/luxury_panel.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/section_title.dart';
import '../widgets/task_card.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key, required this.activeTheme, required this.tasks});

  final LuxeTheme activeTheme;
  final List<TaskItem> tasks;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return LuxuryPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            icon: Icons.checklist_rounded,
            title: 'All Tasks',
            color: activeTheme.gold,
          ),
          SizedBox(height: layout.isCompact ? 14 : 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 860 ? 2 : 1;
              return Wrap(
                spacing: layout.gap,
                runSpacing: layout.isCompact ? 10 : 12,
                children: [
                  for (final task in tasks)
                    SizedBox(
                      width: columns == 1
                          ? double.infinity
                          : (constraints.maxWidth - layout.gap) / 2,
                      child: TaskCard(task: task, activeTheme: activeTheme),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
