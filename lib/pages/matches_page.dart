import 'package:flutter/material.dart';
import '../services/bet365_service.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final Bet365Service api = Bet365Service();

  List<dynamic> liveMatches = [];
  bool loading = false;
  String errorMessage = "";

  Future<void> loadLiveMatches() async {
    setState(() {
      loading = true;
      errorMessage = "";
    });

    try {
      final data = await api.getLiveScores();

      setState(() {
        liveMatches = data["results"] ?? [];
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }

    setState(() {
      loading = false;
    });
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
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: loading ? null : loadLiveMatches,
            child: loading
                ? const CircularProgressIndicator()
                : const Text("Load Live Matches"),
          ),

          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),

          Expanded(
            child: liveMatches.isEmpty && !loading
                ? const Center(
                    child: Text("No matches loaded"),
                  )
                : ListView.builder(
                    itemCount: liveMatches.length,
                    itemBuilder: (context, i) {
                      final match = liveMatches[i];

                      String home = match["home"]["name"] ?? "Home";
                      String away = match["away"]["name"] ?? "Away";
                      String score =
                          "${match["home"]["score"] ?? 0} - ${match["away"]["score"] ?? 0}";

                      return ListTile(
                        title: Text("$home vs $away"),
                        subtitle: Text("Score: $score"),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
