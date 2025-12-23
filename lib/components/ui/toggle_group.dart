import 'package:flutter/material.dart';
import 'package:flutter_project2/components/ui/toggle.dart';

class AppToggleGroup<T> extends StatelessWidget {
  final List<T> values; // 선택된 값들 (단일 선택이라도 리스트로 처리 가능)
  final List<AppToggleGroupItem<T>> items;
  final ValueChanged<T> onSelected;
  final bool multiple;

  const AppToggleGroup({
    super.key,
    required this.values,
    required this.items,
    required this.onSelected,
    this.multiple = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items.map((item) {
        final isSelected = values.contains(item.value);
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: AppToggle(
            value: isSelected,
            onChanged: (_) => onSelected(item.value),
            tooltip: item.tooltip,
            child: item.child,
          ),
        );
      }).toList(),
    );
  }
}

class AppToggleGroupItem<T> {
  final T value;
  final Widget child; // Icon or Text
  final String? tooltip;

  AppToggleGroupItem({required this.value, required this.child, this.tooltip});
}
