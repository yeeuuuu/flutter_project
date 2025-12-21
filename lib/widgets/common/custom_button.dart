import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum ButtonVariant { defaultBtn, destructive, outline, secondary, ghost, link }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final double? width;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.defaultBtn,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    // Variant에 따른 스타일 분기
    Color backgroundColor;
    Color textColor;
    BorderSide? borderSide;

    switch (variant) {
      case ButtonVariant.destructive:
        backgroundColor = AppTheme.destructive;
        textColor = Colors.white;
        break;
      case ButtonVariant.outline:
        backgroundColor = Colors.transparent;
        textColor = AppTheme.foreground;
        borderSide = const BorderSide(color: AppTheme.border);
        break;
      case ButtonVariant.secondary:
        backgroundColor = AppTheme.muted;
        textColor = AppTheme.foreground;
        break;
      case ButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        textColor = AppTheme.foreground;
        break;
      case ButtonVariant.link:
        backgroundColor = Colors.transparent;
        textColor = AppTheme.primary;
        break;
      case ButtonVariant.defaultBtn:
      default:
        backgroundColor = AppTheme.primary;
        textColor = AppTheme.primaryForeground;
    }

    return SizedBox(
      width: width,
      height: 40, // h-10 equivalent
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }
}
