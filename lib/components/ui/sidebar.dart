import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppSidebar extends StatelessWidget {
  final Widget header;
  final Widget content;
  final Widget? footer;
  final bool isCollapsed;

  const AppSidebar({
    super.key,
    required this.header,
    required this.content,
    this.footer,
    this.isCollapsed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCollapsed ? 70 : 250,
      color: AppTheme.muted.withOpacity(0.3), // sidebar background
      child: Column(
        children: [
          // Sidebar Header
          Padding(padding: const EdgeInsets.all(16), child: header),
          const Divider(height: 1),

          // Sidebar Content (Menu Items)
          Expanded(child: content),

          // Sidebar Footer
          if (footer != null) ...[
            const Divider(height: 1),
            Padding(padding: const EdgeInsets.all(16), child: footer!),
          ],
        ],
      ),
    );
  }
}

class AppSidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isCollapsed;
  final bool isActive;
  final VoidCallback onTap;

  const AppSidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isCollapsed = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: isActive ? AppTheme.muted : Colors.transparent,
        child: Row(
          mainAxisAlignment:
              isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? AppTheme.foreground : AppTheme.mutedForeground,
            ),
            if (!isCollapsed) ...[
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color:
                      isActive ? AppTheme.foreground : AppTheme.mutedForeground,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
