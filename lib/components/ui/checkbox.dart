import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AppCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20, // size-4 approx
      height: 20,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primary,
        checkColor: AppTheme.primaryForeground,
        side: const BorderSide(color: AppTheme.primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 패딩 제거
      ),
    );
  }
}
