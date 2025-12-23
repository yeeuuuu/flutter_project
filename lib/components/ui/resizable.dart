import 'package:flutter/material.dart';

class AppResizablePanelGroup extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;
  final List<int> flexes; // 각 패널의 비율

  const AppResizablePanelGroup({
    super.key,
    required this.children,
    this.direction = Axis.vertical,
    this.flexes = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      children: List.generate(children.length, (index) {
        final flex = (flexes.length > index) ? flexes[index] : 1;
        return Expanded(
          flex: flex,
          child: children[index],
        );
      }),
    );
  }
}