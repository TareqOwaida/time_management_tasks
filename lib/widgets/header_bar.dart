import 'package:flutter/material.dart';

import '../models/planner_models.dart';
import 'luxury_icon_button.dart';
import 'responsive_layout.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({
    super.key,
    required this.activeTheme,
    required this.onAddTask,
  });

  final LuxeTheme activeTheme;
  final VoidCallback onAddTask;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    final titleGroup = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: layout.isCompact ? double.infinity : 560,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aurelia Planner',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Time, tasks, and focus arranged with intention.',
            maxLines: layout.isCompact ? 2 : 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
    final actions = Wrap(
      spacing: layout.isCompact ? 8 : 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const LuxuryIconButton(icon: Icons.search_rounded, tooltip: 'Search'),
        const LuxuryIconButton(icon: Icons.tune_rounded, tooltip: 'Customize'),
        FilledButton.icon(
          onPressed: onAddTask,
          icon: const Icon(Icons.add_rounded),
          label: Text(layout.isVeryNarrow ? 'Task' : 'New Task'),
          style: FilledButton.styleFrom(
            backgroundColor: activeTheme.gold,
            foregroundColor: const Color(0xFF17130A),
            padding: EdgeInsets.symmetric(
              horizontal: layout.isCompact ? 14 : 18,
              vertical: layout.isCompact ? 14 : 16,
            ),
          ),
        ),
      ],
    );

    if (layout.isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleGroup,
          SizedBox(height: layout.gap),
          actions,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: titleGroup),
        const SizedBox(width: 18),
        actions,
      ],
    );
  }
}
