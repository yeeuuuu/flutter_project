import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppInput({
    super.key,
    this.controller,
    this.placeholder,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: AppTheme.mutedForeground),
        filled: true,
        fillColor:
            Colors.transparent, // bg-input-background (보통 투명 or 아주 연한 회색)
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ), // h-9 equivalent
        // 기본 테두리
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppTheme.border),
        ),

        // 포커스 시 테두리 (Ring 효과)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: AppTheme.primary,
            width: 2,
          ), // Ring color
        ),

        // 에러 시 테두리
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppTheme.destructive),
        ),
      ),
    );
  }
}
