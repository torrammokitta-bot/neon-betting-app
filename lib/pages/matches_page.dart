import 'package:flutter/material.dart';
import '../services/sportsdata_service.dart';
import '../models/match_game.dart';
import '../widgets/match_tile.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final SportsDataService api = SportsDataService();

  List<MatchGame> matches = [];
  bool loading = false;

  Future<void> loadMatches() async {
    setState(() => loading = true);

    // FIXED FORMAT → Flutter & APIs accept YYYY-MM-DD
    String date = "2024-01-01";

    try {
      final jsonList = await api.loadMatchesByDate(date);

      List<MatchGame> temp = [];
      for (var j in jsonList) {
        try {
          temp.add(MatchGame.fromJson(j));
        } catch (_) {}
      }

      setState(() {
        matches = temp;
      });
    } catch (e) {
      setState(() {
        matches = [];
      });
    }

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
              "Matches",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: loading ? null : loadMatches,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Load Matches"),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: matches.isEmpty
                  ? const Center(
                      child: Text(
                        "No matches loaded",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: matches.length,
                      itemBuilder: (context, i) {
                        return MatchTile(
                          match: matches[i],
                          onTap: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
