import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Utils {
  // 날짜 포맷 (yyyy-MM-dd)
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // 오늘 날짜인지 확인
  static bool isToday(String dateString) {
    final today = formatDate(DateTime.now());
    return dateString == today;
  }

  // 내일 날짜인지 확인
  static bool isTomorrow(String dateString) {
    final tomorrow = formatDate(DateTime.now().add(const Duration(days: 1)));
    return dateString == tomorrow;
  }

  // 날짜 레이블 (오늘, 내일, M월 d일)
  static String getDateLabel(String dateString) {
    if (isToday(dateString)) return '오늘';
    if (isTomorrow(dateString)) return '내일';

    try {
      final date = DateTime.parse(dateString);
      return '${date.month}월 ${date.day}일';
    } catch (e) {
      return dateString;
    }
  }

  // 고유 ID 생성 (uuid 패키지 사용 권장)
  static String generateId() {
    return const Uuid().v4(); 
    // 패키지 설치가 안 된 경우 임시: return DateTime.now().millisecondsSinceEpoch.toString();
  }
}