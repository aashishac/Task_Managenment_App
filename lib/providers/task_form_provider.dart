import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';

class TaskFormProvider extends ChangeNotifier {
  DateTime? _selectedDate;
  TaskCategory _selectedCategory = TaskCategory.food;

  DateTime? get selectedDate => _selectedDate;
  TaskCategory get selectedCategory => _selectedCategory;

  /// Set category
  void setCategory(TaskCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  // Validation method
  String? validateDate() {
    if (_selectedDate == null) {
      return 'Please select a date';
    }
    return null;
  }

  void reset() {
    _selectedDate = null;
    _selectedCategory = TaskCategory.food;
    notifyListeners();
  }
}
