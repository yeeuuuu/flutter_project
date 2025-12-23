import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppRadioGroup<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T?> onChanged;
  final List<AppRadioItem<T>> items;

  const AppRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return InkWell(
          onTap: () => onChanged(item.value),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              children: [
                _buildRadioIcon(item.value == value),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.foreground,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRadioIcon(bool isSelected) {
    return Container(
      width: 16, // size-4
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppTheme.primary : AppTheme.foreground,
          width: 1, // Shadcn default border width
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primary,
                ),
              ),
            )
          : null,
    );
  }
}

class AppRadioItem<T> {
  final T value;
  final String label;

  AppRadioItem({required this.value, required this.label});
}
