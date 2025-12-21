import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  final Color? color;
  final bool outline;

  const CustomBadge({
    super.key,
    required this.text,
    this.color,
    this.outline = false,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? AppTheme.primary;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: outline ? Colors.transparent : baseColor,
        borderRadius: BorderRadius.circular(4),
        border: outline ? Border.all(color: baseColor) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: outline ? baseColor : Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}