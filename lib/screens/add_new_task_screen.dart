import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/providers/task_form_provider.dart';
import 'package:flutter_application_1/providers/task_provider.dart';
import 'package:flutter_application_1/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, this.task});
  final Task? task;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final formProvider = context.read<TaskFormProvider>();

      if (widget.task != null) {
        _titleController.text = widget.task!.title;
        _descController.text = widget.task!.description;
        formProvider.setDate(widget.task!.createdDateTime);
        formProvider.setCategory(widget.task!.category);
      } else {
        formProvider.setDate(DateTime.now());
        formProvider.setCategory(TaskCategory.values.first);
      }
    });
  }

  void selectDateForTask() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && mounted) {
      context.read<TaskFormProvider>().setDate(pickedDate);
    }
  }

  void saveTask(Task task) {
    if (_formKey.currentState!.validate()) {
      context.read<TaskProvider>().addNewTask(newtask: task);
      Navigator.pop(context);
    }
  }

  void updateTask(Task task) {
    if (_formKey.currentState!.validate()) {
      context.read<TaskProvider>().updateTask(task);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isExisted = widget.task != null;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(isExisted ? 'Update Task' : 'Add New Task'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter task title',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter title' : null,
                ),
                const SizedBox(height: 20),

                // Description
                TextFormField(
                  controller: _descController,
                  maxLines: 3,
                  maxLength: 50,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter task description',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter description'
                      : null,
                ),
                const SizedBox(height: 20),

                // Date selector
                Selector<TaskFormProvider, DateTime?>(
                  selector: (_, provider) => provider.selectedDate,
                  builder: (context, date, child) {
                    final selected = date ?? DateTime.now();
                    final formattedDate = DateFormat(
                      'dd MMM yyyy',
                    ).format(selected);

                    return InkWell(
                      onTap: selectDateForTask,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Date',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formattedDate),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Category dropdown
                Selector<TaskFormProvider, TaskCategory>(
                  selector: (_, provider) => provider.selectedCategory,
                  builder: (context, category, child) {
                    return DropdownButtonFormField<TaskCategory>(
                      value: category,
                      items: TaskCategory.values
                          .map(
                            (cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context.read<TaskFormProvider>().setCategory(value);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Category',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Consumer<TaskFormProvider>(
                        builder: (context, provider, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.iconColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              final task = Task(
                                id: isExisted
                                    ? widget.task!.id
                                    : UniqueKey().toString(),
                                title: _titleController.text.trim(),
                                description: _descController.text.trim(),
                                createdDateTime: provider.selectedDate!,
                                category: provider.selectedCategory,
                              );

                              isExisted ? updateTask(task) : saveTask(task);
                            },
                            child: Text(
                              isExisted ? 'Update' : 'Add',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50), // extra padding bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
