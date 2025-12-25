import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/local_storage_service.dart';

class StorageProvider extends ChangeNotifier {
  final storageService = LocalStorageService();

  bool _isdarktheme = false;
  bool _hasSeenOnBoarding = false;
  bool _isLoaded = false;

  // Getters
  bool get isDarktheme => _isdarktheme;
  bool get hasSeenOnBoarding => _hasSeenOnBoarding;
  bool get isLoaded => _isLoaded;

  StorageProvider() {
    _init();
  }

  Future<void> _init() async {
    // Load theme
    _isdarktheme = await storageService.getdarktheme();

    // Load onboarding flag
    _hasSeenOnBoarding = await storageService.getOnBoardingSeen();

    _isLoaded = true;
    notifyListeners(); // only once
  }

  // Dark theme
  Future<void> setdarktheme(bool value) async {
    _isdarktheme = value;
    await storageService.setdarktheme(value);
    notifyListeners();
  }

  // Onboarding
  Future<void> markOnBoardingSeen() async {
    _hasSeenOnBoarding = true;
    await storageService.setOnBoardingSeen();
    notifyListeners();
  }
}
