import 'package:flutter/material.dart';

import '../pages/planner_shell.dart';

class AureliaPlannerApp extends StatelessWidget {
  const AureliaPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aurelia Planner',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'Sans',
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD6B46D),
          brightness: Brightness.dark,
          primary: const Color(0xFFD6B46D),
          secondary: const Color(0xFF9BD8C4),
          surface: const Color(0xFF151A22),
        ),
      ),
      home: const PlannerShell(),
    );
  }
}
