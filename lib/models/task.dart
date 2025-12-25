enum TaskCategory { food, travel, entertainment, education, health }

class Task {
  final String title;
  final String description;
  final DateTime createdDateTime;
  bool isCompleted;
  final TaskCategory category;
  final int? id;

  Task({
    required this.title,
    required this.description,
    required this.createdDateTime,
    required this.category,
    this.id,
    this.isCompleted = false,
    required String createdAt,
  });

  // Task.toMap()
  // id , date, category
  /// Convert Task to Map for database
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isCompleted": isCompleted ? 1 : 0,
      "category": category.name,
      "createdAt": createdDateTime.toIso8601String(),
    };
  }

  /// Create Task from Map
  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['title'],
    description: map['description'],
    createdDateTime: DateTime.parse(map['createdAt']),
    category: TaskCategory.values.byName(map['category']),
    createdAt: '',
  );

  /// Copy with method for updates
  Task copyWith({
    int? id,
    String? title,
    String? description,
    TaskCategory? category,
    DateTime? createdDateTime,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdDateTime: createdDateTime ?? this.createdDateTime,
      category: category ?? this.category,
      createdAt: '',
    );
  }
}
