import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppSeparator extends StatelessWidget {
  final Axis orientation;
  final double thickness;
  final Color? color;

  const AppSeparator({
    super.key,
    this.orientation = Axis.horizontal,
    this.thickness = 1.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (orientation == Axis.horizontal) {
      return Divider(
        height: thickness,
        thickness: thickness,
        color: color ?? AppTheme.border,
      );
    } else {
      return VerticalDivider(
        width: thickness,
        thickness: thickness,
        color: color ?? AppTheme.border,
      );
    }
  }
}
