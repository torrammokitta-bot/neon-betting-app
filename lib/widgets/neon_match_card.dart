import 'package:flutter/material.dart';

class NeonMatchCard extends StatelessWidget {
  final String home;
  final String away;
  final String score;

  const NeonMatchCard({
    super.key,
    required this.home,
    required this.away,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0A0F2C),
            Color(0xFF11193E),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(home,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(away,
                  style: const TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
          Text(
            score,
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(color: Colors.cyan, blurRadius: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
