import 'package:flutter/material.dart';

import '../models/planner_models.dart';
import 'priority_pill.dart';
import 'responsive_layout.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.activeTheme});

  final TaskItem task;
  final LuxeTheme activeTheme;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(layout.isCompact ? 12 : 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.055),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: (constraints.maxWidth - 94).clamp(
                        160,
                        constraints.maxWidth,
                      ),
                    ),
                    child: Text(
                      task.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  PriorityPill(priority: task.priority),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 14,
                runSpacing: 8,
                children: [
                  _TaskMeta(
                    icon: Icons.sell_rounded,
                    color: activeTheme.accent,
                    label: task.category,
                  ),
                  _TaskMeta(
                    icon: Icons.access_time_rounded,
                    color: activeTheme.gold,
                    label: task.time,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: task.progress),
                  duration: const Duration(milliseconds: 520),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      minHeight: 7,
                      backgroundColor: Colors.white10,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        activeTheme.gold,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TaskMeta extends StatelessWidget {
  const _TaskMeta({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: layout.isCompact ? 180 : 240),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }
}
