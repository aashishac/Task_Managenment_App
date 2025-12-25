import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/date_format.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/providers/task_form_provider.dart';
import 'package:flutter_application_1/providers/task_provider.dart';
import 'package:flutter_application_1/screens/add_new_task_screen.dart';
import 'package:flutter_application_1/themes/app_theme.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.allTaskList});
  final List<Task> allTaskList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allTaskList.length,
      itemBuilder: (context, index) {
        final task = allTaskList[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Checkbox updates provider
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.blue,
                  value: task.isCompleted,
                  onChanged: (value) {
                    task.isCompleted = value!;
                    context.read<TaskProvider>().updateTask(todo: task);
                  },
                ),

                // Title + Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: Text(
                                'Task Preview',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name: ${task.title}"),
                                  const SizedBox(height: 8),
                                  Text("Description: ${task.description}"),
                                  const SizedBox(height: 8),
                                  Text("Category: ${task.category.name}"),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Date: ${task.createdDateTime.toMMMdyyyy()}",
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Close"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(task.title),
                      ),

                      // Text(
                      //   task.description,
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                // Category + Date
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Text(task.category.name.toCapitalized()),
                //     Text(task.createdDateTime.toMMMdyyyy()),
                //   ],
                // ),

                // Popup menu for Edit/Delete
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => TaskFormProvider(),
                            child: AddNewTaskScreen(task: task),
                          ),
                        ),
                      );
                    } else if (value == 'delete') {
                      if (task.isCompleted) {
                        getConfirmation(context: context).then((confirmed) {
                          if (confirmed == true) {
                            context.read<TaskProvider>().removeTask(
                              id: task.id!,
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppTheme.errorColor,
                            content: Text(
                              'Only completed tasks can be deleted',
                            ),
                          ),
                        );
                      }
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: AppTheme.iconColor),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<bool?> getConfirmation({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete task'),
      content: const Text('Are you sure you want to delete this task?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ],
    ),
  );
}
