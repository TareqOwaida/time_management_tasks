import 'package:flutter/material.dart';

import 'responsive_layout.dart';

class StatTile extends StatelessWidget {
  const StatTile(
    this.title,
    this.value,
    this.note,
    this.icon,
    this.color, {
    super.key,
  });

  final String title;
  final String value;
  final String note;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return SizedBox(
      width: layout.statTileWidth,
      child: Container(
        padding: EdgeInsets.all(layout.isCompact ? 14 : 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.055),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            SizedBox(height: layout.isCompact ? 10 : 12),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: layout.isCompact ? 22 : 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$title - $note',
              style: const TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
