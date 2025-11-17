import 'dart:convert';
import 'package:http/http.dart' as http;

class SportsDataService {
  // IMPORTANT: Replace with your API key
  final String apiKey = "YOUR_API_KEY";

  // Safer: Always returns a LIST and never throws
  Future<List<dynamic>> loadMatchesByDate(String date) async {
    try {
      final url = Uri.parse(
        "https://api.sportsdata.io/v3/soccer/scores/json/GamesByDate/$date?key=$apiKey",
      );

      final response = await http.get(url);

      if (response.statusCode != 200) {
        return [];
      }

      final body = jsonDecode(response.body);

      if (body is List) {
        return body;
      }

      return [];
    } catch (e) {
      return []; // NEVER crash Flutter Web build
    }
  }
}
