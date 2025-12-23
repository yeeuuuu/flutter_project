import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.background, // bg-card
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(
          8,
        ), // rounded-xl (Shadcn default is xl=12px or lg=8px)
        boxShadow: const [], // Shadcn cards are usually flat unless hovered
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child:
            padding != null ? Padding(padding: padding!, child: child) : child,
      ),
    );
  }
}

// CardHeader, CardTitle 등은 간단히 Column 등으로 대체 가능하지만,
// 구조를 맞추려면 아래와 같이 유틸리티 위젯을 만들 수 있습니다.

class AppCardHeader extends StatelessWidget {
  final Widget child;
  const AppCardHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24), // p-6
      child: child,
    );
  }
}

class AppCardContent extends StatelessWidget {
  final Widget child;
  const AppCardContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24), // px-6 pb-6
      child: child,
    );
  }
}
