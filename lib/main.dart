import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const NeonBettingApp());
}

class NeonBettingApp extends StatelessWidget {
  const NeonBettingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Neon Betting App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkNeon(),
      home: const Placeholder(),
    );
  }
}
