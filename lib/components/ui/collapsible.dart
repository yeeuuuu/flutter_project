import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppCollapsible extends StatelessWidget {
  final String title;
  final Widget content;
  final bool initiallyExpanded;

  const AppCollapsible({
    super.key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.foreground,
          ),
        ),
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 16),
        initiallyExpanded: initiallyExpanded,
        iconColor: AppTheme.mutedForeground,
        collapsedIconColor: AppTheme.mutedForeground,
        trailing: const Icon(LucideIcons.chevronDown, size: 16),
        children: [Align(alignment: Alignment.centerLeft, child: content)],
      ),
    );
  }
}
