import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/storage_provider.dart';
import 'package:flutter_application_1/providers/task_provider.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/screens/splashscreen.dart';
import 'package:flutter_application_1/themes/app_theme.dart';
import 'package:flutter_application_1/themes/dark_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => StorageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StorageProvider>();
    return MaterialApp(
      theme: provider.isDarktheme ? AppTheme.lightTheme : DarkTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
