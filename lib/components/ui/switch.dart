import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AppSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44, // w-11 approx
      height: 24, // h-6 approx
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppTheme.background,
          activeTrackColor: AppTheme.primary,
          inactiveThumbColor: AppTheme.background,
          inactiveTrackColor: AppTheme.input, // input-background
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          splashRadius: 0,
        ),
      ),
    );
  }
}
