import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomInput extends StatelessWidget {
  final String? placeholder;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomInput({
    super.key,
    this.placeholder,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: AppTheme.mutedForeground),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius),
          borderSide: const BorderSide(
            color: AppTheme.primary,
            width: 2,
          ), // Ring effect
        ),
        fillColor: Colors.transparent,
        filled: true,
      ),
    );
  }
}
