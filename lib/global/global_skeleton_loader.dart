import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class GlobalSkeletonLoader extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;

  const GlobalSkeletonLoader({super.key, this.width, this.height, this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white54,
      highlightColor: Colors.white,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 8.r),
            color: Colors.grey),
      ),
    );
  }
}
