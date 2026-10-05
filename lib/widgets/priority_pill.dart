import 'package:flutter/material.dart';

import '../models/planner_models.dart';

class PriorityPill extends StatelessWidget {
  const PriorityPill({super.key, required this.priority});

  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    final color = switch (priority) {
      TaskPriority.high => const Color(0xFFE56B6F),
      TaskPriority.medium => const Color(0xFFD6B46D),
      TaskPriority.low => const Color(0xFF9BD8C4),
    };
    final label = switch (priority) {
      TaskPriority.high => 'High',
      TaskPriority.medium => 'Medium',
      TaskPriority.low => 'Low',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}
