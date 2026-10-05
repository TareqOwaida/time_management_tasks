import 'package:flutter/material.dart';

class CircularProgressBadge extends StatelessWidget {
  const CircularProgressBadge({
    super.key,
    required this.color,
    required this.value,
  });

  final Color color;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: 72,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value.clamp(0, 1),
            strokeWidth: 7,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          Text(
            '${(value * 100).round()}%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
