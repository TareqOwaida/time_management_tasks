import 'package:flutter/material.dart';

import '../models/planner_models.dart';
import 'responsive_layout.dart';
import 'section_title.dart';

class Timeline extends StatelessWidget {
  const Timeline({
    super.key,
    required this.schedule,
    required this.activeTheme,
  });

  final List<ScheduleItem> schedule;
  final LuxeTheme activeTheme;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          icon: Icons.schedule_rounded,
          title: 'Time Blocks',
          color: activeTheme.accent,
        ),
        SizedBox(height: layout.isCompact ? 14 : 16),
        for (final item in schedule)
          Padding(
            padding: EdgeInsets.only(bottom: layout.gap),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: layout.timelineTimeWidth,
                  child: Text(
                    item.time,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 4, right: 12),
                  decoration: BoxDecoration(
                    color: activeTheme.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.note,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
