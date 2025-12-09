enum TaskCategory { food, travel, entertainment, education, health }

class Task {
  final String title;
  final String description;
  final DateTime createdDateTime;
  bool isCompleted;
  final TaskCategory category;
  final String id;

  Task({
    required this.title,
    required this.description,
    required this.createdDateTime,
    required this.category,
    required this.id,
    this.isCompleted = false,
  });
}
