import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

enum BadgeVariant { defaultVariant, secondary, destructive, outline }

class AppBadge extends StatelessWidget {
  final String text;
  final BadgeVariant variant;
  final Color? customColor; // 태스크별 동적 색상 지원을 위해 추가

  const AppBadge({
    super.key,
    required this.text,
    this.variant = BadgeVariant.defaultVariant,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Border? border;

    switch (variant) {
      case BadgeVariant.secondary:
        bgColor = AppTheme.muted;
        textColor = AppTheme.foreground;
        break;
      case BadgeVariant.destructive:
        bgColor = AppTheme.destructive;
        textColor = Colors.white;
        break;
      case BadgeVariant.outline:
        bgColor = Colors.transparent;
        textColor = AppTheme.foreground;
        border = Border.all(color: AppTheme.border);
        break;
      case BadgeVariant.defaultVariant:
      default:
        bgColor = AppTheme.primary;
        textColor = AppTheme.primaryForeground;
    }

    // 커스텀 컬러(태스크 색상)가 있으면 outline 변형처럼 처리하되 색상 적용
    if (customColor != null) {
      bgColor = Colors.transparent;
      textColor = customColor!;
      border = Border.all(color: customColor!);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        border: border,
        borderRadius: BorderRadius.circular(
          9999,
        ), // full rounded (Shadcn은 md지만 배지는 보통 둥글게)
        // 만약 Shadcn의 각진 스타일(rounded-md)을 원하면 radius: 4
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
