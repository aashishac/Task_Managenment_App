import 'package:flutter/material.dart';

class TaskSection extends StatelessWidget {
  const TaskSection({
    super.key,
    required this.labelText,
    required this.content,
  });
  final String labelText;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
