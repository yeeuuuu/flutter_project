class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });
}

class Task {
  final String id;
  final String title;
  final String type;
  final bool completed;
  final String date;
  final String color;
  final String createdAt;

  Task({
    required this.id,
    required this.title,
    required this.type,
    required this.completed,
    required this.date,
    required this.color,
    required this.createdAt,
  });

  // 복사본 생성을 위한 메서드 (수정 모드)
  Task copyWith({
    String? id,
    String? title,
    String? type,
    bool? completed,
    String? date,
    String? color,
    String? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      completed: completed ?? this.completed,
      date: date ?? this.date,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// records_tab.dart에서 사용
class RoutineStreak {
  final String routineId;
  final int currentStreak;
  final int longestStreak;

  RoutineStreak({
    required this.routineId,
    required this.currentStreak,
    required this.longestStreak, required String lastCompletedDate,
  });
}
