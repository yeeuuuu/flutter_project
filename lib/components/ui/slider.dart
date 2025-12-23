import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const AppSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: AppTheme.primary,
        inactiveTrackColor: AppTheme.muted,
        thumbColor: AppTheme.background,
        overlayColor: AppTheme.primary.withOpacity(0.1),
        trackHeight: 2.0,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 8.0,
          elevation: 2, // shadow-sm
        ),
        // 썸(Thumb) 테두리를 그리기 위해 커스텀 Shape가 필요할 수 있으나,
        // 기본적으로 흰색 원형 썸으로 구현
      ),
      child: Slider(value: value, min: min, max: max, onChanged: onChanged),
    );
  }
}
