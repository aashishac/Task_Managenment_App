enum TaskCategory { food, travel, entertainment, education }

class Task {
  final String name;
  final String description;
  final DateTime date;
  final TaskCategory category;

  Task({
    required this.name,
    required this.description,
    required this.date,
    required this.category,
  });
}
