import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service to talk to Bet365 via RapidAPI.
class Bet365Service {
  // TODO: replace this with your *new* RapidAPI key for Bet365
  static const String _apiKey = "YOUR_RAPIDAPI_KEY_HERE";

  static const String _host = "bet3652.p.rapidapi.com";

  /// Load a list of live soccer events (you can change sport/league later)
  Future<List<Bet365Event>> loadLiveEvents() async {
    final uri = Uri.https(
      _host,
      "/v1/events/inplay",
      {
        "sport_id": "1", // 1 = soccer in many Bet365 APIs (check RapidAPI docs)
      },
    );

    final response = await http.get(
      uri,
      headers: {
        "X-RapidAPI-Key": _apiKey,
        "X-RapidAPI-Host": _host,
      },
    );

    if (response.statusCode != 200) {
      print(
          "Bet365 events error ${response.statusCode}: ${response.body}");
      return [];
    }

    final data = jsonDecode(response.body);
    final List list = data["results"] ?? [];

    return list
        .map((e) => Bet365Event.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Load odds for a single event by eventId.
  Future<Bet365Odds?> loadOdds(String eventId) async {
    final uri = Uri.https(
      _host,
      "/v1/event/odds",
      {
        "event_id": eventId,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        "X-RapidAPI-Key": _apiKey,
        "X-RapidAPI-Host": _host,
      },
    );

    if (response.statusCode != 200) {
      print("Bet365 odds error ${response.statusCode}: ${response.body}");
      return null;
    }

    final data = jsonDecode(response.body);
    final List results = data["results"] ?? [];
    if (results.isEmpty) return null;

    final oddsJson = results[0];

    return Bet365Odds.fromJson(oddsJson as Map<String, dynamic>);
  }
}

class Bet365Event {
  final String id;
  final String homeTeam;
  final String awayTeam;

  Bet365Event({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory Bet365Event.fromJson(Map<String, dynamic> json) {
    return Bet365Event(
      id: json["id"].toString(),
      homeTeam: json["home"]["name"]?.toString() ?? "Home",
      awayTeam: json["away"]["name"]?.toString() ?? "Away",
    );
  }
}

class Bet365Odds {
  final double? home;
  final double? draw;
  final double? away;

  Bet365Odds({
    required this.home,
    required this.draw,
    required this.away,
  });

  factory Bet365Odds.fromJson(Map<String, dynamic> json) {
    // NOTE: the exact JSON structure depends on Bet365 API.
    // This is a generic example – you may need to adjust field names
    // after you see a sample response in RapidAPI console.
    final main = json["main"] ?? json;

    double? parse(dynamic v) {
      if (v == null) return null;
      return double.tryParse(v.toString());
    }

    return Bet365Odds(
      home: parse(main["home"]),
      draw: parse(main["draw"]),
      away: parse(main["away"]),
    );
  }
}
