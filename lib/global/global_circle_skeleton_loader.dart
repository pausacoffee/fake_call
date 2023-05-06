import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalCircleSkeletonLoader extends StatelessWidget {
  final double? width;
  final double? height;

  const GlobalCircleSkeletonLoader({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromRGBO(240, 240, 240, 1),
      highlightColor: Colors.white,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      ),
    );
  }
}
