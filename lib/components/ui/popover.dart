import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppPopover extends StatelessWidget {
  final Widget trigger;
  final Widget content;
  final MenuController? controller;

  const AppPopover({
    super.key,
    required this.trigger,
    required this.content,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: controller,
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: trigger,
        );
      },
      menuChildren: [
        Padding(padding: const EdgeInsets.all(12.0), child: content),
      ],
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(AppTheme.background),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppTheme.border),
          ),
        ),
        elevation: WidgetStateProperty.all(4),
      ),
    );
  }
}
