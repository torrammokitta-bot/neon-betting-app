import 'dart:convert';
import 'package:http/http.dart' as http;

class SportsDataService {
  static String apiKey = ""; // <-- this fixes the missing variable

  static const String baseUrl = "https://api.sportsdata.io/v4/soccer/scores/json";

  Future<List<dynamic>> loadMatchesByDate(String date) async {
    final url = Uri.parse("$baseUrl/GamesByDate/$date?key=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
}
