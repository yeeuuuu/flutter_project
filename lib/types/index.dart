// lib/types/index.dart

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
  final String type; // 'todo' 또는 'routine'
  final bool completed; // 완료 여부 (기존 isCompleted 대신 completed 사용)
  final String date; // 'yyyy-MM-dd' 형식의 문자열
  final String color; // Hex Color String (예: '#FF0000')
  final String createdAt; // 생성일

  Task({
    required this.id,
    required this.title,
    required this.type,
    required this.completed,
    required this.date,
    required this.color,
    required this.createdAt,
  });

  // 복사본 생성을 위한 copyWith 메서드 (수정 모드 및 토글 시 사용)
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

// records_tab.dart에서 사용하는 루틴 스트릭 모델
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
