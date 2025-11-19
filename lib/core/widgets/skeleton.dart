import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.height = 16, this.width = double.infinity});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceVariant;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: baseColor.withOpacity(.5),
        borderRadius: BorderRadius.circular(12),
      ),
    ).animate(onPlay: (c) => c.repeat()).shimmer(
          colors: [baseColor.withOpacity(.3), baseColor.withOpacity(.6)],
          duration: 1200.ms,
        );
  }
}

class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: const [
          SkeletonBox(height: 64, width: 64),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 160),
                SizedBox(height: 8),
                SkeletonBox(width: 120),
              ],
            ),
          )
        ],
      ),
    );
  }
}
