// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/task.dart';

// class TaskProvider extends ChangeNotifier {
//   final List<Task> _tasks = [];

//   List<Task> get tasks => _tasks;

//   /// Add a new task
//   void addNewTask({required Task newtask}) {
//     final index = _tasks.indexWhere((task) => task.id == newtask.id);
//     if (index != -1) {
//       _tasks[index] = newtask;
//     } else {
//       _tasks.add(newtask);
//     }
//     notifyListeners();
//   }

//   /// Update an existing task
//   void updateTask(Task updatedTask) {
//     final index = _tasks.indexWhere((t) => t.id == updatedTask.id);
//     if (index != -1) {
//       _tasks[index] = updatedTask;
//       notifyListeners();
//     }
//   }

//   /// Remove a task
//   void removeTask({required Task existedTask}) {
//     _tasks.removeWhere((t) => t.id == existedTask.id);
//     notifyListeners();
//   }

//   /// Past tasks (before today)
//   List<Task> get pastTasks {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     return _tasks
//         .where((task) => task.createdDateTime.isBefore(today))
//         .toList();
//   }

//   /// Today tasks
//   List<Task> get getTodayTasks {
//     final now = DateTime.now();
//     return _tasks
//         .where(
//           (task) =>
//               task.createdDateTime.year == now.year &&
//               task.createdDateTime.month == now.month &&
//               task.createdDateTime.day == now.day,
//         )
//         .toList();
//   }

//   /// Upcoming tasks (tomorrow onwards)
//   List<Task> get upComingTask {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);

//     return _tasks.where((task) {
//       final taskDate = DateTime(
//         task.createdDateTime.year,
//         task.createdDateTime.month,
//         task.createdDateTime.day,
//       );
//       return taskDate.isAfter(today);
//     }).toList();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/services/db_service.dart';

class TaskProvider extends ChangeNotifier {
  final dbService = DbService();
  // to store list of task in a variable
  List<Task> _allTasks = [];

  bool _isLoading = false;

  // getter functions
  List<Task> get allTask => _allTasks;
  bool get isLoading => _isLoading;

  // load all todos from database
  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();
    _allTasks = await dbService.readAllTasks();
    _isLoading = false;
    notifyListeners();
  }

  /// Add new task
  Future<bool> addNewTask({required Task newtask}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final task = await dbService.create(todo: newtask);
      _allTasks.insert(0, task);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print("failed to add new task : $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // update task
  Future<bool> updateTask({required Task todo}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await dbService.update(todo: todo);
      final index = _allTasks.indexWhere((task) => task.id == todo.id);
      print('index value : $index');
      if (index != -1) {
        _allTasks[index] = todo;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print("failed to update existed task : $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  List<Task> get getTodayTasks {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    return _allTasks.where((task) {
      final taskDate = DateTime(
        task.createdDateTime.year,
        task.createdDateTime.month,
        task.createdDateTime.day,
      );
      return taskDate.isAtSameMomentAs(todayDate);
    }).toList();
  }

  List<Task> get upComingTask {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return _allTasks
        .where((task) => task.createdDateTime.isAfter(today))
        .toList();
  }

  // Past tasks (before today)
  List<Task> get pastTasks {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return _allTasks
        .where((task) => task.createdDateTime.isBefore(today))
        .toList();
  }

  /// Remove existing task
  Future<void> removeTask({required int id}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await dbService.delete(id);
      _allTasks.removeWhere((task) => task.id == id);

      notifyListeners();
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
