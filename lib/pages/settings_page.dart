import 'package:flutter/material.dart';

import '../models/planner_models.dart';
import '../widgets/luxury_panel.dart';
import '../widgets/preference_row.dart';
import '../widgets/responsive_layout.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.activeTheme,
    required this.themes,
    required this.selectedTheme,
    required this.focusMode,
    required this.dailyGoal,
    required this.onThemeChanged,
    required this.onFocusChanged,
    required this.onGoalChanged,
  });

  final LuxeTheme activeTheme;
  final List<LuxeTheme> themes;
  final int selectedTheme;
  final bool focusMode;
  final double dailyGoal;
  final ValueChanged<int> onThemeChanged;
  final ValueChanged<bool> onFocusChanged;
  final ValueChanged<double> onGoalChanged;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: layout.isWide ? 840 : double.infinity,
        ),
        child: LuxuryPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customize Workspace',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: layout.gap),
              Text(
                'Palette',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (var i = 0; i < themes.length; i++)
                    ChoiceChip(
                      selected: selectedTheme == i,
                      label: Text(themes[i].name),
                      avatar: CircleAvatar(backgroundColor: themes[i].gold),
                      onSelected: (_) => onThemeChanged(i),
                      selectedColor: themes[i].gold.withValues(alpha: 0.28),
                      backgroundColor: Colors.white.withValues(alpha: 0.06),
                      labelStyle: const TextStyle(color: Colors.white),
                      side: BorderSide(
                        color: selectedTheme == i
                            ? themes[i].gold
                            : Colors.white12,
                      ),
                    ),
                ],
              ),
              SizedBox(height: layout.headerGap),
              Material(
                color: Colors.transparent,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: focusMode,
                  onChanged: onFocusChanged,
                  activeThumbColor: activeTheme.gold,
                  title: const Text(
                    'Focus Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: const Text(
                    'Mute low-priority tasks during deep work.',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              SizedBox(height: layout.gap),
              Text(
                'Daily focus goal',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: Colors.white70),
              ),
              Slider(
                value: dailyGoal,
                min: 1,
                max: 10,
                divisions: 18,
                label: '${dailyGoal.toStringAsFixed(1)}h',
                activeColor: activeTheme.gold,
                inactiveColor: Colors.white12,
                onChanged: onGoalChanged,
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white12),
              const SizedBox(height: 16),
              const PreferenceRow(
                icon: Icons.dashboard_customize_rounded,
                title: 'Board density',
                value: 'Balanced',
              ),
              const PreferenceRow(
                icon: Icons.notifications_active_rounded,
                title: 'Reminder style',
                value: 'Elegant',
              ),
              const PreferenceRow(
                icon: Icons.calendar_month_rounded,
                title: 'Week starts',
                value: 'Monday',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
