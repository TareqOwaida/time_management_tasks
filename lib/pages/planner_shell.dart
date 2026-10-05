import 'package:flutter/material.dart';

import '../data/planner_data.dart';
import '../data/planner_storage.dart';
import '../models/planner_models.dart';
import '../widgets/header_bar.dart';
import '../widgets/responsive_layout.dart';
import 'schedule_page.dart';
import 'settings_page.dart';
import 'tasks_page.dart';
import 'today_page.dart';

class PlannerShell extends StatefulWidget {
  const PlannerShell({super.key});

  @override
  State<PlannerShell> createState() => _PlannerShellState();
}

class _PlannerShellState extends State<PlannerShell> {
  int _selectedIndex = 0;
  int _selectedTheme = 0;
  bool _focusMode = true;
  double _dailyGoal = 6;
  List<TaskItem> _tasks = List.of(plannerTasks);
  List<ScheduleItem> _schedule = List.of(plannerSchedule);
  PlannerStorage? _storage;
  bool _isLoading = true;

  LuxeTheme get _activeTheme => plannerThemes[_selectedTheme];

  @override
  void initState() {
    super.initState();
    _loadSavedPlanner();
  }

  Future<void> _loadSavedPlanner() async {
    final storage = await PlannerStorage.create();
    if (!mounted) {
      return;
    }

    setState(() {
      _storage = storage;
      _selectedTheme = storage.loadSelectedTheme();
      _focusMode = storage.loadFocusMode();
      _dailyGoal = storage.loadDailyGoal();
      _tasks = storage.loadTasks();
      _schedule = storage.loadSchedule();
      _isLoading = false;
    });

    await storage.saveTasks(_tasks);
    await storage.saveSchedule(_schedule);
  }

  void _changeTheme(int value) {
    setState(() => _selectedTheme = value);
    _storage?.saveSelectedTheme(value);
  }

  void _changeFocusMode(bool value) {
    setState(() => _focusMode = value);
    _storage?.saveFocusMode(value);
  }

  void _changeDailyGoal(double value) {
    setState(() => _dailyGoal = value);
    _storage?.saveDailyGoal(value);
  }

  @override
  Widget build(BuildContext context) {
    final activeTheme = _activeTheme;
    final pages = [
      TodayPage(
        activeTheme: activeTheme,
        dailyGoal: _dailyGoal,
        tasks: _tasks,
        schedule: _schedule,
      ),
      TasksPage(activeTheme: activeTheme, tasks: _tasks),
      SchedulePage(activeTheme: activeTheme, schedule: _schedule),
      SettingsPage(
        activeTheme: activeTheme,
        themes: plannerThemes,
        selectedTheme: _selectedTheme,
        focusMode: _focusMode,
        dailyGoal: _dailyGoal,
        onThemeChanged: _changeTheme,
        onFocusChanged: _changeFocusMode,
        onGoalChanged: _changeDailyGoal,
      ),
    ];

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _FloatingPlannerNav(
        activeTheme: activeTheme,
        selectedIndex: _selectedIndex,
        onSelected: (value) => setState(() => _selectedIndex = value),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0D1117),
              Color.alphaBlend(
                activeTheme.accent.withValues(alpha: 0.12),
                const Color(0xFF11161E),
              ),
              const Color(0xFF151008),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final layout = ResponsiveLayout.of(context);
              return SingleChildScrollView(
                padding: layout.pageInsets,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: layout.maxContentWidth,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderBar(
                          activeTheme: activeTheme,
                          onAddTask: _showAddTaskDialog,
                        ),
                        SizedBox(height: layout.headerGap),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 260),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, animation) {
                            final offsetAnimation = Tween<Offset>(
                              begin: const Offset(0, 0.02),
                              end: Offset.zero,
                            ).animate(animation);

                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: KeyedSubtree(
                            key: ValueKey(_selectedIndex),
                            child: _isLoading
                                ? _LoadingPage(activeTheme: activeTheme)
                                : pages[_selectedIndex],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showAddTaskDialog() async {
    final newTask = await showDialog<TaskItem>(
      context: context,
      builder: (context) {
        return _AddTaskDialog(activeTheme: _activeTheme);
      },
    );

    if (newTask == null) {
      return;
    }

    final updatedTasks = [..._tasks, newTask];
    setState(() => _tasks = updatedTasks);
    await _storage?.saveTasks(updatedTasks);
  }
}

class _FloatingPlannerNav extends StatelessWidget {
  const _FloatingPlannerNav({
    required this.activeTheme,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const _destinations = [
    _PlannerDestination(Icons.dashboard_rounded, 'Today'),
    _PlannerDestination(Icons.checklist_rounded, 'Tasks'),
    _PlannerDestination(Icons.schedule_rounded, 'Schedule'),
    _PlannerDestination(Icons.settings_rounded, 'Settings'),
  ];

  final LuxeTheme activeTheme;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return SafeArea(
      minimum: EdgeInsets.fromLTRB(
        layout.navHorizontalPadding,
        0,
        layout.navHorizontalPadding,
        layout.navBottomPadding,
      ),
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: layout.navMaxWidth),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFF151A22).withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.36),
                  blurRadius: 28,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  for (var i = 0; i < _destinations.length; i++)
                    Expanded(
                      child: _NavItem(
                        destination: _destinations[i],
                        activeTheme: activeTheme,
                        selected: selectedIndex == i,
                        layout: layout,
                        onTap: () => onSelected(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.activeTheme,
    required this.selected,
    required this.layout,
    required this.onTap,
  });

  final _PlannerDestination destination;
  final LuxeTheme activeTheme;
  final bool selected;
  final ResponsiveLayout layout;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? const Color(0xFF17130A) : Colors.white70;

    return Tooltip(
      message: destination.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          height: layout.navItemHeight,
          padding: EdgeInsets.symmetric(horizontal: layout.navItemPadding),
          decoration: BoxDecoration(
            color: selected ? activeTheme.gold : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(destination.icon, color: foreground, size: 22),
              if (!layout.isVeryNarrow) ...[
                const SizedBox(width: 7),
                Flexible(
                  child: Text(
                    destination.label,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color: foreground,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PlannerDestination {
  const _PlannerDestination(this.icon, this.label);

  final IconData icon;
  final String label;
}

class _LoadingPage extends StatelessWidget {
  const _LoadingPage({required this.activeTheme});

  final LuxeTheme activeTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(activeTheme.gold),
        ),
      ),
    );
  }
}

class _AddTaskDialog extends StatefulWidget {
  const _AddTaskDialog({required this.activeTheme});

  final LuxeTheme activeTheme;

  @override
  State<_AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<_AddTaskDialog> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController(text: 'Focus');
  final _timeController = TextEditingController(text: '09:00 AM');
  TaskPriority _priority = TaskPriority.medium;

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return AlertDialog(
      title: const Text('New Task'),
      content: SizedBox(
        width: layout.dialogMaxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Time'),
            ),
            const SizedBox(height: 18),
            if (layout.isVeryNarrow)
              DropdownButtonFormField<TaskPriority>(
                initialValue: _priority,
                decoration: const InputDecoration(labelText: 'Priority'),
                items: const [
                  DropdownMenuItem(value: TaskPriority.low, child: Text('Low')),
                  DropdownMenuItem(
                    value: TaskPriority.medium,
                    child: Text('Medium'),
                  ),
                  DropdownMenuItem(
                    value: TaskPriority.high,
                    child: Text('High'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _priority = value);
                  }
                },
              )
            else
              SegmentedButton<TaskPriority>(
                segments: const [
                  ButtonSegment(
                    value: TaskPriority.low,
                    label: Text('Low'),
                    icon: Icon(Icons.low_priority_rounded),
                  ),
                  ButtonSegment(
                    value: TaskPriority.medium,
                    label: Text('Medium'),
                    icon: Icon(Icons.remove_rounded),
                  ),
                  ButtonSegment(
                    value: TaskPriority.high,
                    label: Text('High'),
                    icon: Icon(Icons.priority_high_rounded),
                  ),
                ],
                selected: {_priority},
                onSelectionChanged: (value) {
                  setState(() => _priority = value.first);
                },
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final title = _titleController.text.trim();
            if (title.isEmpty) {
              return;
            }

            Navigator.of(context).pop(
              TaskItem(
                title,
                _categoryController.text.trim().isEmpty
                    ? 'Focus'
                    : _categoryController.text.trim(),
                _timeController.text.trim().isEmpty
                    ? '09:00 AM'
                    : _timeController.text.trim(),
                0,
                _priority,
              ),
            );
          },
          style: FilledButton.styleFrom(
            backgroundColor: widget.activeTheme.gold,
            foregroundColor: const Color(0xFF17130A),
          ),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
