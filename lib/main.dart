import 'package:flutter/material.dart';
import 'services/bet365_service.dart';

void main() {
  runApp(const NeonBettingApp());
}

class NeonBettingApp extends StatelessWidget {
  const NeonBettingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Betting',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF050816),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00FFB0),
          brightness: Brightness.dark,
        ),
      ),
      home: const MatchesPage(),
    );
  }
}

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final Bet365Service _service = Bet365Service();

  List<Bet365Event> _events = [];
  Bet365Event? _selected;
  Bet365Odds? _odds;
  String? _recommendation;
  bool _loadingEvents = false;
  bool _loadingOdds = false;
  String? _error;

  Future<void> _loadEvents() async {
    setState(() {
      _loadingEvents = true;
      _error = null;
      _events = [];
      _selected = null;
      _odds = null;
      _recommendation = null;
    });

    try {
      final events = await _service.loadLiveEvents();
      setState(() {
        _events = events;
        if (events.isEmpty) {
          _error = "No live matches found right now.";
        }
      });
    } catch (e) {
      setState(() {
        _error = "Failed to load matches: $e";
      });
    } finally {
      setState(() {
        _loadingEvents = false;
      });
    }
  }

  Future<void> _loadOdds(Bet365Event event) async {
    setState(() {
      _loadingOdds = true;
      _selected = event;
      _odds = null;
      _recommendation = null;
      _error = null;
    });

    try {
      final odds = await _service.loadOdds(event.id);
      setState(() {
        _odds = odds;
        if (odds == null) {
          _error = "No odds data for this match.";
        } else {
          _recommendation = _makeRecommendation(odds);
        }
      });
    } catch (e) {
      setState(() {
        _error = "Failed to load odds: $e";
      });
    } finally {
      setState(() {
        _loadingOdds = false;
      });
    }
  }

  String _makeRecommendation(Bet365Odds odds) {
    // very simple: pick the lowest odds = favourite
    final home = odds.home ?? double.infinity;
    final draw = odds.draw ?? double.infinity;
    final away = odds.away ?? double.infinity;

    if (home <= draw && home <= away) {
      return "Recommendation: Bet on HOME team";
    } else if (away <= home && away <= draw) {
      return "Recommendation: Bet on AWAY team";
    } else {
      return "Recommendation: Bet on DRAW";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loadingEvents ? null : _loadEvents,
                child: _loadingEvents
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Load Matches"),
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.redAccent),
              ),
            if (_events.isEmpty && !_loadingEvents && _error == null)
              const Text("No matches loaded"),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final e = _events[index];
                  final selected = e == _selected;
                  return Card(
                    color: selected
                        ? const Color(0xFF111827)
                        : const Color(0xFF020617),
                    child: ListTile(
                      title: Text("${e.homeTeam} vs ${e.awayTeam}"),
                      subtitle: Text("Event ID: ${e.id}"),
                      onTap: () => _loadOdds(e),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            if (_loadingOdds)
              const CircularProgressIndicator()
            else if (_odds != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Odds:",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text("Home: ${_odds!.home ?? '-'}"),
                  Text("Draw: ${_odds!.draw ?? '-'}"),
                  Text("Away: ${_odds!.away ?? '-'}"),
                  const SizedBox(height: 8),
                  if (_recommendation != null)
                    Text(
                      _recommendation!,
                      style: const TextStyle(
                        color: Color(0xFF00FFB0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
