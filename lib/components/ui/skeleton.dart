import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final double radius;

  const AppSkeleton({
    super.key,
    this.width,
    this.height,
    this.radius = 4, // rounded-md
  });

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.5, end: 1.0).animate(_controller),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: AppTheme.muted, // bg-muted/accent
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}
