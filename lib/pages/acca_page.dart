import 'package:flutter/material.dart';
import '../services/recommender_service.dart';

class AccaPage extends StatefulWidget {
  const AccaPage({super.key});

  @override
  State<AccaPage> createState() => _AccaPageState();
}

class _AccaPageState extends State<AccaPage> {
  final rec = RecommenderService.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "ACCA Page",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
