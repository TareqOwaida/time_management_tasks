import 'package:flutter/material.dart';

import '../models/planner_models.dart';
import '../widgets/luxury_panel.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/timeline.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({
    super.key,
    required this.activeTheme,
    required this.schedule,
  });

  final LuxeTheme activeTheme;
  final List<ScheduleItem> schedule;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: layout.isWide ? 760 : double.infinity,
        ),
        child: LuxuryPanel(
          child: Timeline(schedule: schedule, activeTheme: activeTheme),
        ),
      ),
    );
  }
}
