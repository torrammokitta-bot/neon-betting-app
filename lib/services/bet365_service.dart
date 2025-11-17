import 'dart:convert';
import 'package:http/http.dart' as http;

class Bet365Service {
  static const String apiKey = "58f7545c71mshae89a022f0b1555p1cba2ajsn4f6eced60198";
  static const String baseUrl = "https://odds.p.rapidapi.com/v4";

  // Fetch upcoming football matches (FREE ENDPOINT)
  Future<List<Map<String, dynamic>>> getUpcomingMatches() async {
    final url = Uri.parse("$baseUrl/sports/soccer/odds?regions=eu&oddsFormat=decimal");

    final response = await http.get(
      url,
      headers: {
        "x-rapidapi-key": apiKey,
        "x-rapidapi-host": "odds.p.rapidapi.com",
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((m) => {
        "home": m["home_team"],
        "away": m["away_team"],
        "commence_time": m["commence_time"],
      }).toList();
    } else {
      print("API error: ${response.body}");
      return [];
    }
  }
}
