import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';

class AddNewTaskScreen extends StatefulWidget {
  final Task? existingTask;

  const AddNewTaskScreen({super.key, this.existingTask});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late TaskCategory _selectedCategory;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.existingTask?.name ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.existingTask?.description ?? '',
    );
    _selectedDate = widget.existingTask?.date ?? DateTime.now();
    _selectedCategory = widget.existingTask?.category ?? TaskCategory.food;
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        date: _selectedDate,
        category: _selectedCategory,
      );
      Navigator.pop(context, {'task': task});
    }
  }

  void _deletecancelAction() {
    if (widget.existingTask != null) {
      Navigator.pop(context, {'delete': true});
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTask != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Task' : 'Add Task',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter a task name'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TaskCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: TaskCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Date'),
                subtitle: Text(
                  '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitTask,
                icon: const Icon(Icons.save),
                label: Text(isEditing ? 'Update Task' : 'Add Task'),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: _deletecancelAction,
                icon: Icon(isEditing ? Icons.delete : Icons.cancel),
                label: Text(isEditing ? 'Delete Task' : 'Cancel'),
                style: TextButton.styleFrom(
                  foregroundColor: isEditing ? Colors.red : Colors.grey[700],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
