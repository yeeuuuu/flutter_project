import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppSelect<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? placeholder;

  const AppSelect({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(6),
        color: AppTheme.background,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          icon: const Icon(
            LucideIcons.chevronDown,
            size: 16,
            color: AppTheme.mutedForeground,
          ),
          isExpanded: true,
          hint: placeholder != null
              ? Text(
                  placeholder!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.mutedForeground,
                  ),
                )
              : null,
          style: const TextStyle(fontSize: 14, color: AppTheme.foreground),
          dropdownColor: AppTheme.background,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
