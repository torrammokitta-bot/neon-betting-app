import 'package:flutter/material.dart';
import '../services/sportsdata_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController apiController =
      TextEditingController(text: SportsDataService.apiKey);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            Text(
              "API Key:",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 10),

            TextField(
              controller: apiController,
              decoration: InputDecoration(
                hintText: "Enter your SportsData.io API key",
                hintStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: const Color(0xFF0B1020),
              ),
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  SportsDataService.apiKey = apiController.text.trim();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("API Key Updated"),
                  ),
                );
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
