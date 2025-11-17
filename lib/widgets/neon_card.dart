import 'package:flutter/material.dart';

class NeonCard extends StatelessWidget {
  final String title;
  final Color color;
  final Widget? child;

  const NeonCard({
    super.key,
    required this.title,
    required this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: color.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: color,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
