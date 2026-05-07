import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BubblePopApp());
}

class BubblePopApp extends StatelessWidget {
  const BubblePopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bubble Pop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A1B9A),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1A0033),
      ),
      home: const HomeScreen(),
    );
  }
}
