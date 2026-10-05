import 'package:flutter/material.dart';

import 'responsive_layout.dart';

class LuxuryPanel extends StatelessWidget {
  const LuxuryPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      width: double.infinity,
      padding: EdgeInsets.all(layout.panelPadding),
      decoration: BoxDecoration(
        color: const Color(0xFF151A22).withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.24),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: child,
    );
  }
}
