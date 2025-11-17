import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/TaskListScreen.dart';
// adjust if your file name is different

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: TaskListScreen(),
    );
  }
}
