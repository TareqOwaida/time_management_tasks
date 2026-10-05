import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management_tasks/app/aurelia_planner_app.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('renders the planner dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const AureliaPlannerApp());
    await tester.pumpAndSettle();

    expect(find.text('Aurelia Planner'), findsOneWidget);
    expect(find.text('Today Command Center'), findsOneWidget);
    expect(find.text('Priority Tasks'), findsOneWidget);
  });

  testWidgets('opens settings page from navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AureliaPlannerApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Customize Workspace'), findsOneWidget);
  });

  testWidgets('renders on a compact mobile viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AureliaPlannerApp());
    await tester.pumpAndSettle();

    expect(find.text('Aurelia Planner'), findsOneWidget);
    expect(find.text('Today Command Center'), findsOneWidget);
  });

  testWidgets('renders on a wide desktop viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AureliaPlannerApp());
    await tester.pumpAndSettle();

    expect(find.text('Priority Tasks'), findsOneWidget);
    expect(find.text('Time Blocks'), findsOneWidget);
  });
}
