import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NeonShimmer extends StatelessWidget {
  const NeonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blueGrey.shade900,
      highlightColor: Colors.blueGrey.shade700,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
