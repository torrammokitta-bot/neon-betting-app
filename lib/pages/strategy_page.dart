import 'package:flutter/material.dart';

class StrategyPage extends StatelessWidget {
  const StrategyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "Strategy Page",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
