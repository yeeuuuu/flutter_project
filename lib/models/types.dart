enum Priority { low, medium, high }
// enum TaskType { todo, routine }
enum Category { work, personal, study }

// Task 데이터 모델
class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime date; // React의 string/Date를 DateTime으로
  final bool isCompleted;
  final Priority priority;
  final String color; // 추가됨: Hex Color String
  final String type;  // 추가됨: 'todo' or 'routine' (문자열로 저장하거나 enum 사용)
  final bool completed;
  final Category category;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.priority = Priority.medium,
    this.color = '#10B981', // 기본값 초록
    this.type = 'todo',
  });

  // 데이터를 복사하며 수정할 때 유용한 메서드 (React의 Spread 연산자 대체)
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isCompleted,
    Priority? priority,
    String? color,
    String? type,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      color: color ?? this.color,
      type: type ?? this.type,
    );
  }
}
