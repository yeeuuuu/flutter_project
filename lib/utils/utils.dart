import 'package:intl/intl.dart';

// React의 cn (Tailwind merge)은 Flutter에서 필요 없으므로 생략
// 날짜 포맷팅 로직 변환
class Utils {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  static String getDateLabel(DateTime date) {
    if (isToday(date)) return '오늘';
    if (isTomorrow(date)) return '내일';
    return DateFormat('M월 d일').format(date);
  }

  static String generateId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}
