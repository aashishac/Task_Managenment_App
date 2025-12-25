import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/storage_provider.dart';
import 'package:flutter_application_1/screens/on_boarding_screen.dart';
import 'package:flutter_application_1/screens/taskListScreen.dart';
import 'package:flutter_application_1/themes/app_theme.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;

      // ✅ Read StorageProvider
      final storage = context.read<StorageProvider>();

      // ✅ Decide which screen to navigate
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => storage.hasSeenOnBoarding
              ? const TaskListScreen() // if onboarding seen → go to home
              : const OnBoardingScreen(), // if not → go to onboarding
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryColor,
              const Color.fromARGB(255, 107, 185, 222),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.67],
          ),
        ),
        child: Center(
          child: Image.asset('assets/app_logo.png', width: 150, height: 150),
        ),
      ),
    );
  }
}
