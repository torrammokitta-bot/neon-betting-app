import 'package:flutter/material.dart';
import '../services/bet365_service.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final Bet365Service api = Bet365Service();
  List matches = [];
  bool loading = false;

  Future<void> loadMatches() async {
    setState(() => loading = true);

    final data = await api.getUpcomingMatches();

    setState(() {
      matches = data;
      loading = false;
    });
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

            const SizedBox(height: 20),

            Expanded(
              child: matches.isEmpty
                  ? const Center(
                      child: Text(
                        "No matches loaded.",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : ListView.builder(
                      itemCount: matches.length,
                      itemBuilder: (context, i) {
                        final m = matches[i];
                        return Card(
                          color: Colors.black26,
                          child: ListTile(
                            title: Text(
                              "${m['home']} vs ${m['away']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Starts: ${m['commence_time']}",
                              style:
                                  const TextStyle(color: Colors.white70),
                            ),
                          ),
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
