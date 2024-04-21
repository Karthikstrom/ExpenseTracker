import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(193, 14, 150, 84),
);

var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
    runApp(MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
            color: const HsbColor(150, 24, 68),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        // appBarTheme: const AppBarTheme().copyWith(
        //     backgroundColor: kColorScheme.primaryContainer,
        //     foregroundColor: kColorScheme.secondaryContainer),
        cardTheme: const CardTheme().copyWith(
            color: const HsbColor(150, 24, 68),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const ExpensesTracker(),
    ));
  // });
}
