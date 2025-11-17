import 'package:flutter/material.dart';
import '../services/bet365_service.dart';
import '../widgets/neon_match_card.dart';
// import '../widgets/neon_shimmer.dart';  // ← Uncomment if you created shimmer

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final Bet365Service api = Bet365Service();

  List liveMatches = [];
  bool loading = false;

  Future<void> loadMatches() async {
    setState(() => loading = true);

    final data = await api.fetchLiveMatches();

    setState(() {
      liveMatches = data;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadMatches();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            "Live Matches",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),

          // Reload button
          ElevatedButton(
            onPressed: loading ? null : loadMatches,
            child: loading
                ? const CircularProgressIndicator()
                : const Text("Refresh Matches"),
          ),

          const SizedBox(height: 16),

          // MAIN MATCH LIST
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())

                /*
                🔥 If shimmer is added, replace above with:

                const Column(
                  children: [
                    NeonShimmer(),
                    NeonShimmer(),
                    NeonShimmer(),
                  ],
                )
                */

                : liveMatches.isEmpty
                    ? const Center(
                        child: Text(
                          "No matches loaded",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.builder(
                        itemCount: liveMatches.length,
                        itemBuilder: (context, i) {
                          final match = liveMatches[i];

                          String home =
                              match["home"]["name"] ?? "Home";

                          String away =
                              match["away"]["name"] ?? "Away";

                          String score =
                              "${match["home"]["score"] ?? 0} - ${match["away"]["score"] ?? 0}";

                          return NeonMatchCard(
                            home: home,
                            away: away,
                            score: score,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
