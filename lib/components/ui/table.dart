import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows; // 각 셀의 위젯 리스트
  final List<double>? columnWidths; // Flex 비율

  const AppTable({
    super.key,
    required this.headers,
    required this.rows,
    this.columnWidths,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.border)),
            ),
            child: Row(
              children: List.generate(headers.length, (index) {
                return Expanded(
                  flex: (columnWidths != null && columnWidths!.length > index)
                      ? columnWidths![index].toInt()
                      : 1,
                  child: Text(
                    headers[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.mutedForeground,
                      fontSize: 14,
                    ),
                  ),
                );
              }),
            ),
          ),
          // Rows
          ...rows.map((rowCells) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppTheme.border)),
              ),
              child: Row(
                children: List.generate(rowCells.length, (index) {
                  return Expanded(
                    flex: (columnWidths != null && columnWidths!.length > index)
                        ? columnWidths![index].toInt()
                        : 1,
                    child: rowCells[index],
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
