enum Priority { low, medium, high }

enum Category { work, personal, study }

class Task {
  final String id;
  final String title;
  final bool completed;
  final DateTime date;
  final String? description;
  final Category category;
  final Priority priority;

  Task({
    required this.id,
    required this.title,
    this.completed = false,
    required this.date,
    this.description,
    required this.category,
    required this.priority,
  });

  // 데이터 변경을 위한 copyWith (React의 ...spread와 유사)
  Task copyWith({
    String? id,
    String? title,
    bool? completed,
    DateTime? date,
    String? description,
    Category? category,
    Priority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      date: date ?? this.date,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
    );
  }
}

class User {
  final String name;
  final String? avatar;

  User({required this.name, this.avatar});
}
