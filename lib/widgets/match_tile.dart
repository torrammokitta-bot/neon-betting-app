import 'package:flutter/material.dart';
import '../models/match_game.dart';
import 'odds_chip.dart';

class MatchTile extends StatelessWidget {
  final MatchGame match;
  final VoidCallback? onTap;

  const MatchTile({
    super.key,
    required this.match,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1020),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0x33FFFFFF)),
        ),
        child: Row(
          children: [
            // TEAMS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    match.homeTeam,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    match.awayTeam,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // ODDS DISPLAY (best side)
            if (match.homeOdds != null)
              OddsChip(
                odds: match.homeOdds!,
                color: Colors.greenAccent,
              ),

            const SizedBox(width: 4),

            if (match.awayOdds != null)
              OddsChip(
                odds: match.awayOdds!,
                color: Colors.blueAccent,
              ),
          ],
        ),
      ),
    );
  }
}
