import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF29B6F6);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color errorColor = Color(0xFFEF5350);
  static const Color successColor = Color(0xFF66BB6A);
  static const Color iconColor = Color(0xFF29B6F6);
  static const Color iconBackgroundColor = Color(0xFFE3F2FD);
  static const Color errorBackgroundColor = Color(0xFFFFEBEE);
  static const Color completedCheckColor = Color(0xFF29B6F6);
  static const Color boxColor = Color(0xFFDBF0FA);

  // Text Styles
  static final TextStyle appBarTitle = GoogleFonts.inter(
    color: textPrimary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle screenTitle = appBarTitle.copyWith(fontSize: 20);

  static final TextStyle sectionHeader = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: textSecondary,
    letterSpacing: 1.2,
  );

  static final TextStyle taskTitle = GoogleFonts.inter(
    fontSize: 16,
    color: textPrimary,
  );

  static final TextStyle taskTitleCompleted = GoogleFonts.inter(
    fontSize: 16,
    color: textSecondary,
    decoration: TextDecoration.lineThrough,
    decorationColor: textSecondary,
    decorationThickness: 2,
  );

  static final TextStyle settingItemTitle = appBarTitle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle settingItemTitleError = settingItemTitle.copyWith(
    color: errorColor,
  );

  static final TextStyle dialogTitle = appBarTitle.copyWith(fontSize: 20);

  static final TextStyle dialogContent = GoogleFonts.inter(
    fontSize: 16,
    color: textPrimary,
  );

  static final TextStyle buttonText = dialogContent.copyWith(
    fontWeight: FontWeight.w600,
  );

  static final TextStyle buttonTextPrimary = buttonText.copyWith(
    color: Colors.white,
  );

  static final TextStyle inputLabel = GoogleFonts.inter(
    fontSize: 14,
    color: textSecondary,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle hintText = TextStyle(color: Color(0xFFBDBDBD));

  static final TextStyle completionTitle = appBarTitle.copyWith(fontSize: 20);

  static final TextStyle completionSubtitle = GoogleFonts.inter(
    fontSize: 16,
    color: textSecondary,
  );

  // Theme Data
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    brightness: Brightness.light,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: appBarTitle,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(16),
      hintStyle: hintText,
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: buttonTextPrimary,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: textSecondary),

    // Divider Theme
    dividerTheme: DividerThemeData(color: dividerColor, thickness: 1),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: dialogTitle,
      contentTextStyle: dialogContent,
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor;
        }
        return dividerColor;
      }),
    ),

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: primaryColor,
      error: errorColor,
      surface: cardColor,
    ),
  );

  // Box Decorations
  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration iconContainerDecoration = BoxDecoration(
    color: iconBackgroundColor,
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration errorIconContainerDecoration = BoxDecoration(
    color: errorBackgroundColor,
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration checkboxDecoration({required bool isCompleted}) {
    return BoxDecoration(
      color: isCompleted ? completedCheckColor : Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: isCompleted ? completedCheckColor : dividerColor,
        width: 2,
      ),
    );
  }

  static BoxDecoration completionIconDecoration = BoxDecoration(
    color: primaryColor.withValues(alpha: 0.1),
    shape: BoxShape.circle,
  );

  static ThemeData? get darkTheme => null;
}
