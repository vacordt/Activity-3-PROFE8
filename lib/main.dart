import 'package:flutter/material.dart';
import 'screens/screens.dart';

void main() {
  runApp(const LawFirmApp());
}

class LawFirmApp extends StatelessWidget {
  const LawFirmApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brandPrimary = Color(0xFF1E3A8A); // navy
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Law Firm Management',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandPrimary,
          primary: brandPrimary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
