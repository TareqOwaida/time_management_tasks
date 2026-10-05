import 'package:flutter/material.dart';

import 'responsive_layout.dart';

class LuxuryIconButton extends StatelessWidget {
  const LuxuryIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
  });

  final IconData icon;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout.of(context);
    return Tooltip(
      message: tooltip,
      child: IconButton.filledTonal(
        onPressed: () {},
        icon: Icon(icon),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.08),
          foregroundColor: Colors.white,
          fixedSize: Size(layout.iconButtonSize, layout.iconButtonSize),
        ),
      ),
    );
  }
}
