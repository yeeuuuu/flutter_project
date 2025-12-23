import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppDropdownMenu<T> extends StatelessWidget {
  final Widget trigger; // Trigger (e.g. Icon or Button)
  final List<AppDropdownItem<T>> items;
  final ValueChanged<T> onSelected;

  const AppDropdownMenu({
    super.key,
    required this.trigger,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: onSelected,
      itemBuilder: (context) => items.map((item) {
        return PopupMenuItem<T>(
          value: item.value,
          height: 32, // compact height
          child: Row(
            children: [
              if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: 16,
                  color: item.isDestructive ? AppTheme.destructive : null,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 14,
                  color: item.isDestructive
                      ? AppTheme.destructive
                      : AppTheme.foreground,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: AppTheme.border),
      ),
      elevation: 3,
      color: AppTheme.background,
      surfaceTintColor: Colors.transparent,
      child: trigger,
    );
  }
}

class AppDropdownItem<T> {
  final T value;
  final String label;
  final IconData? icon;
  final bool isDestructive;

  AppDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.isDestructive = false,
  });
}
