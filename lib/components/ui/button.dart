import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

enum ButtonVariant {
  defaultVariant,
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

enum ButtonSize { defaultSize, sm, lg, icon }

class AppButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool fullWidth;
  final Widget? child; // 텍스트나 아이콘 대신 커스텀 위젯을 넣을 때

  const AppButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.variant = ButtonVariant.defaultVariant,
    this.size = ButtonSize.defaultSize,
    this.fullWidth = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // 사이즈 설정
    final EdgeInsets padding;
    final double? fixedHeight;
    final double? iconSize;
    final double fontSize;

    switch (size) {
      case ButtonSize.sm:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 0);
        fixedHeight = 32;
        iconSize = 14;
        fontSize = 12;
        break;
      case ButtonSize.lg:
        padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 0);
        fixedHeight = 40;
        iconSize = 18;
        fontSize = 16;
        break;
      case ButtonSize.icon:
        padding = EdgeInsets.zero;
        fixedHeight = 36; // size-9 (36px)
        iconSize = 16;
        fontSize = 14;
        break;
      case ButtonSize.defaultSize:
      default:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        fixedHeight = 36; // h-9
        iconSize = 16;
        fontSize = 14;
    }

    // 스타일 설정
    Color backgroundColor;
    Color foregroundColor;
    BorderSide? borderSide;
    double elevation = 0;

    switch (variant) {
      case ButtonVariant.destructive:
        backgroundColor = AppTheme.destructive;
        foregroundColor = Colors.white;
        break;
      case ButtonVariant.outline:
        backgroundColor = AppTheme.background;
        foregroundColor = AppTheme.foreground;
        borderSide = const BorderSide(color: AppTheme.border);
        break;
      case ButtonVariant.secondary:
        backgroundColor = AppTheme.muted;
        foregroundColor = AppTheme.foreground; // secondary-foreground
        break;
      case ButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = AppTheme.foreground;
        break;
      case ButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = AppTheme.primary;
        break;
      case ButtonVariant.defaultVariant:
      default:
        backgroundColor = AppTheme.primary;
        foregroundColor = AppTheme.primaryForeground;
    }

    // 버튼 위젯 구성
    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          IconTheme(
            data: IconThemeData(size: iconSize, color: foregroundColor),
            child: icon!,
          ),
          if (text != null) const SizedBox(width: 8),
        ],
        if (text != null)
          Text(
            text!,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              decoration: variant == ButtonVariant.link
                  ? TextDecoration.underline
                  : null,
            ),
          ),
        if (child != null) child!,
      ],
    );

    // Icon Size 버튼인 경우 Row 대신 Center로 감싸기 (Width 제약)
    if (size == ButtonSize.icon) {
      content = Center(
        child: icon != null
            ? IconTheme(
                data: IconThemeData(size: iconSize, color: foregroundColor),
                child: icon!,
              )
            : child,
      );
    }

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      padding: padding,
      minimumSize: Size(
        size == ButtonSize.icon ? fixedHeight : 0,
        fixedHeight,
      ),
      fixedSize:
          size == ButtonSize.icon ? Size(fixedHeight, fixedHeight) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // radius-md
        side: borderSide ?? BorderSide.none,
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 불필요한 마진 제거
    );

    // Ghost나 Link는 Hover 효과 등을 위해 TextButton이 나을 수 있으나, 스타일 통일을 위해 ElevatedButton 사용
    // (Flutter의 TextButton은 기본 패딩이 다름)

    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle.copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return foregroundColor.withOpacity(0.1);
          }
          return null;
        }),
      ),
      child: content,
    );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
