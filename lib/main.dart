import 'package:flutter/material.dart';
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
  bool isDark = false; //

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<ThemeProvider>().isDarktheme;

    return MaterialApp(
      theme: isDarkTheme ? DarkTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
