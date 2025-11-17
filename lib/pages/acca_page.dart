import 'package:flutter/material.dart';
import '../services/recommender_service.dart';
import '../models/match_game.dart';
import '../widgets/neon_card.dart';

class ACCAPage extends StatefulWidget {
  const ACCAPage({super.key});

  @override
  State<ACCAPage> createState() => _ACCAPageState();
}

class _ACCAPageState extends State<ACCAPage> {
  List<MatchGame> allMatches = [];
  List<MatchGame> ultra = [];
  List<MatchGame> medium = [];
  List<MatchGame> high = [];

  bool loading = false;

  void generateACCA() {
    if (allMatches.isEmpty) return;

    setState(() => loading = true);

    final rec = RecommenderService.instance;

    ultra = rec.buildUltraSafeAcca(allMatches);
    medium = rec.buildMediumAcca(allMatches);
    high = rec.buildHighRiskAcca(allMatches);

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "ACCA Builder",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: generateACCA,
              child: const Text("Generate ACCA"),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  NeonCard(
                    title: "Ultra-Safe ACCA",
                    color: Colors.greenAccent,
                    child: buildList(ultra),
                  ),
                  const SizedBox(height: 12),
                  NeonCard(
                    title: "Medium-Risk ACCA",
                    color: Colors.orangeAccent,
                    child: buildList(medium),
                  ),
                  const SizedBox(height: 12),
                  NeonCard(
                    title: "High-Risk ACCA",
                    color: Colors.pinkAccent,
                    child: buildList(high),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(List<MatchGame> list) {
    if (list.isEmpty) {
      return const Text("No data yet", style: TextStyle(color: Colors.white70));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list.map((m) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            "${m.homeTeam} vs ${m.awayTeam}",
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
