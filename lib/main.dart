import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

import 'pages/strategy_page.dart';
import 'pages/matches_page.dart';
import 'pages/acca_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const NeonBettingApp());
}

class NeonBettingApp extends StatefulWidget {
  const NeonBettingApp({super.key});

  @override
  State<NeonBettingApp> createState() => _NeonBettingAppState();
}

class _NeonBettingAppState extends State<NeonBettingApp> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    StrategyPage(),
    MatchesPage(),
    AccaPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Betting App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: pages[currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) => setState(() => currentIndex = i),
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.white38,
          backgroundColor: const Color(0xFF0B1020),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart),
              label: "Strategy",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer),
              label: "Matches",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_add),
              label: "ACCA",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
