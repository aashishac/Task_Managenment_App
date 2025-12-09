import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  /// Add a new task
  void addNewTask({required Task newtask}) {
    final index = _tasks.indexWhere((task) => task.id == newtask.id);
    if (index != -1) {
      _tasks[index] = newtask;
    } else {
      _tasks.add(newtask);
    }
    notifyListeners();
  }

  /// Update an existing task
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  /// Remove a task
  void removeTask({required Task existedTask}) {
    _tasks.removeWhere((t) => t.id == existedTask.id);
    notifyListeners();
  }

  /// Past tasks (before today)
  List<Task> get pastTasks {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return _tasks
        .where((task) => task.createdDateTime.isBefore(today))
        .toList();
  }

  /// Today tasks
  List<Task> get getTodayTasks {
    final now = DateTime.now();
    return _tasks
        .where(
          (task) =>
              task.createdDateTime.year == now.year &&
              task.createdDateTime.month == now.month &&
              task.createdDateTime.day == now.day,
        )
        .toList();
  }

  /// Upcoming tasks (tomorrow onwards)
  List<Task> get upComingTask {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return _tasks.where((task) {
      final taskDate = DateTime(
        task.createdDateTime.year,
        task.createdDateTime.month,
        task.createdDateTime.day,
      );
      return taskDate.isAfter(today);
    }).toList();
  }
}
