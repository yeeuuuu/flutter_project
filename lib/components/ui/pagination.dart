import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const AppPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed:
              currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          color: AppTheme.foreground,
          disabledColor: AppTheme.mutedForeground,
        ),

        // 페이지 번호 표시 (간단히 현재/전체 표시, 필요 시 버튼 나열 로직 추가 가능)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "$currentPage / $totalPages",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),

        IconButton(
          icon: const Icon(LucideIcons.chevronRight),
          onPressed: currentPage < totalPages
              ? () => onPageChanged(currentPage + 1)
              : null,
          color: AppTheme.foreground,
          disabledColor: AppTheme.mutedForeground,
        ),
      ],
    );
  }
}
