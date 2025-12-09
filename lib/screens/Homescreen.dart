import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/app_theme.dart';
import 'package:flutter_application_1/screens/settings.dart';
import 'package:flutter_application_1/models/task.dart';

class TaskAppBarTitle extends StatelessWidget {
  final bool selectAll;
  final List<Task> tasks;
  final ValueChanged<bool> onSelectAllChanged;
  final VoidCallback onDeleteChecked;

  const TaskAppBarTitle({
    super.key,
    required this.selectAll,
    required this.tasks,
    required this.onSelectAllChanged,
    required this.onDeleteChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: selectAll,
          onChanged: (value) {
            onSelectAllChanged(value ?? false);
          },
        ),
        const Text('My Tasks'),
        const Spacer(),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: AppTheme.iconColor),
          onSelected: (value) async {
            if (value == 'delete') {
              final hasCheckedTasks = tasks.any((task) => task.isCompleted);

              if (!hasCheckedTasks) {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('No Tasks Selected'),
                    content: const Text(
                      'Please check at least one task before deleting.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                return;
              }

              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Checked Tasks'),
                  content: const Text(
                    'Are you sure you want to delete all checked tasks?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );

              if (confirmed ?? false) {
                onDeleteChecked();
              }
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete all Tasks'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'Settings',
              child: InkWell(
                onTap: () {
                  Navigator.pop(context); // close popup
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                child: Row(
                  children: const [
                    Icon(Icons.settings, color: AppTheme.iconColor),
                    SizedBox(width: 8),
                    Text('Settings'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
