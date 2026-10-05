import 'package:flutter/material.dart';

import '../models/planner_models.dart';
import '../widgets/circular_progress_badge.dart';
import '../widgets/luxury_panel.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/stat_tile.dart';
import '../widgets/task_board.dart';
import '../widgets/timeline.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({
    super.key,
    required this.activeTheme,
    required this.dailyGoal,
    required this.tasks,
    required this.schedule,
  });

  final LuxeTheme activeTheme;
  final double dailyGoal;
  final List<TaskItem> tasks;
  final List<ScheduleItem> schedule;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return Column(
      children: [
        LuxuryPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (layout.isCompact) ...[
                _TodaySummaryText(),
                SizedBox(height: layout.gap),
                CircularProgressBadge(
                  color: activeTheme.gold,
                  value: dailyGoal / 10,
                ),
              ] else
                Row(
                  children: [
                    const Expanded(child: _TodaySummaryText()),
                    const SizedBox(width: 16),
                    CircularProgressBadge(
                      color: activeTheme.gold,
                      value: dailyGoal / 10,
                    ),
                  ],
                ),
              SizedBox(height: layout.headerGap),
              Wrap(
                spacing: layout.isCompact ? 10 : 12,
                runSpacing: layout.isCompact ? 10 : 12,
                children: [
                  StatTile(
                    'Completed',
                    '12',
                    '+18%',
                    Icons.done_all_rounded,
                    activeTheme.gold,
                  ),
                  StatTile(
                    'Focus time',
                    '${dailyGoal.toStringAsFixed(1)}h',
                    'goal',
                    Icons.timer_rounded,
                    activeTheme.accent,
                  ),
                  const StatTile(
                    'Streak',
                    '9d',
                    'steady',
                    Icons.local_fire_department_rounded,
                    Color(0xFFE56B6F),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: layout.gap),
        LayoutBuilder(
          builder: (context, constraints) {
            final twoColumns = constraints.maxWidth >= 760;
            if (twoColumns) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: LuxuryPanel(
                      child: TaskBoard(tasks: tasks, activeTheme: activeTheme),
                    ),
                  ),
                  SizedBox(width: layout.gap),
                  Expanded(
                    flex: 4,
                    child: LuxuryPanel(
                      child: Timeline(
                        schedule: schedule,
                        activeTheme: activeTheme,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                LuxuryPanel(
                  child: TaskBoard(tasks: tasks, activeTheme: activeTheme),
                ),
                SizedBox(height: layout.gap),
                LuxuryPanel(
                  child: Timeline(schedule: schedule, activeTheme: activeTheme),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _TodaySummaryText extends StatelessWidget {
  const _TodaySummaryText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today Command Center',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Monday, July 13 - 4 premium focus blocks scheduled',
          style: TextStyle(color: Colors.white60),
        ),
      ],
    );
  }
}
