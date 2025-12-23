import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppTabs extends StatefulWidget {
  final List<String> tabs;
  final Map<String, Widget> views; // 탭 이름과 매칭되는 화면
  final String initialTab;

  const AppTabs({
    super.key,
    required this.tabs,
    required this.views,
    required this.initialTab,
  });

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> {
  late String _currentTab;

  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tabs List (Trigger Area)
        Container(
          height: 40,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppTheme.muted,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: widget.tabs.map((tab) {
              final isActive = _currentTab == tab;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentTab = tab),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          isActive ? AppTheme.background : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      tab,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? AppTheme.foreground
                            : AppTheme.mutedForeground,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        // Tab Content
        widget.views[_currentTab] ?? const SizedBox(),
      ],
    );
  }
}
