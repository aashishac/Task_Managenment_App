import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/task_form_provider.dart';
import 'package:flutter_application_1/providers/task_provider.dart';
import 'package:flutter_application_1/screens/Homescreen.dart';
import 'package:flutter_application_1/screens/add_new_task_screen.dart';
import 'package:flutter_application_1/themes/app_theme.dart';
import 'package:flutter_application_1/widgets/task_list.dart';
import 'package:flutter_application_1/widgets/task_section.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();

    // Load tasks after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final taskProvider = context.read<TaskProvider>();
      await taskProvider.loadTodos(); // Load tasks from SQLite
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final allTasks = taskProvider.allTask;

            return TaskAppBarTitle(
              selectAll: _selectAll,
              tasks: allTasks,
              onSelectAllChanged: (value) async {
                setState(() {
                  _selectAll = value;
                });

                // Update all tasks in DB
                for (var task in allTasks) {
                  task.isCompleted = _selectAll;
                  await taskProvider.updateTask(todo: task);
                }
              },
              onDeleteChecked: () async {
                final checkedTasks = allTasks
                    .where((task) => task.isCompleted)
                    .toList();

                for (var task in checkedTasks) {
                  await taskProvider.removeTask(id: task.id!);
                }

                setState(() {
                  _selectAll = false;
                });
              },
            );
          },
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final todayTasks = taskProvider.getTodayTasks;
          final upComingTasks = taskProvider.upComingTask;
          final pastTasks = taskProvider.pastTasks;

          if (todayTasks.isEmpty &&
              upComingTasks.isEmpty &&
              pastTasks.isEmpty) {
            return const Center(child: Text('No task added yet!!'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                if (todayTasks.isNotEmpty)
                  TaskSection(
                    labelText: 'Today Tasks',
                    content: TaskList(allTaskList: todayTasks),
                  ),
                if (upComingTasks.isNotEmpty)
                  TaskSection(
                    labelText: 'Upcoming Tasks',
                    content: TaskList(allTaskList: upComingTasks),
                  ),
                if (pastTasks.isNotEmpty)
                  TaskSection(
                    labelText: 'Past Tasks',
                    content: TaskList(allTaskList: pastTasks),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.iconBackgroundColor,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => TaskFormProvider(),
                child: const AddNewTaskScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
