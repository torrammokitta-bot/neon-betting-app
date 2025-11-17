import 'package:flutter/material.dart';
import '../models/match_game.dart';
import '../services/recommender_service.dart';
import '../widgets/odds_chip.dart';

class MatchDetailPage extends StatelessWidget {
  final MatchGame match;

  const MatchDetailPage({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final rec = RecommenderService.instance;
    final recommendation = rec.recommend(match);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${match.homeTeam} vs ${match.awayTeam}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            Text(
              "Start Time:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              match.startTime.toString(),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),

            Text(
              "Odds:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                if (match.homeOdds != null)
                  OddsChip(
                    odds: match.homeOdds!,
                    color: Colors.greenAccent,
                  ),
                const SizedBox(width: 10),
                if (match.awayOdds != null)
                  OddsChip(
                    odds: match.awayOdds!,
                    color: Colors.blueAccent,
                  ),
                const SizedBox(width: 10),
                if (match.drawOdds != null)
                  OddsChip(
                    odds: match.drawOdds!,
                    color: Colors.amberAccent,
                  ),
              ],
            ),

            const SizedBox(height: 32),

            Text(
              "AI Recommendation:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              recommendation,
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
