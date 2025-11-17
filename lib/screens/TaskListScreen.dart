import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/add_new_task_screen.dart';
import 'package:flutter_application_1/models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];

  void _navigateToAddTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );

    if (result is Map && result['task'] is Task) {
      setState(() {
        _tasks.add(result['task']);
      });
    }
  }

  void _navigateToEditTask(Task task, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTaskScreen(existingTask: task),
      ),
    );

    if (result is Map) {
      if (result['delete'] == true) {
        setState(() {
          _tasks.removeAt(index);
        });
      } else if (result['task'] is Task) {
        setState(() {
          _tasks[index] = result['task'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Center(
          child: Text('Task Manager', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text('No tasks yet!'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return GestureDetector(
                  onTap: () => _navigateToEditTask(task, index),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.description,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.label,
                                    size: 16,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    task.category.name,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 10,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${task.date.year}-${task.date.month.toString().padLeft(2, '0')}-${task.date.day.toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
