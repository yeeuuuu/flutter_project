import 'package:flutter/material.dart';

class AppScrollArea extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final Axis orientation;

  const AppScrollArea({
    super.key,
    required this.child,
    this.controller,
    this.orientation = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = controller ?? ScrollController();

    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      thickness: 6,
      radius: const Radius.circular(10),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: orientation,
        child: child,
      ),
    );
  }
}
