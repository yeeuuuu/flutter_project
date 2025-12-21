import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(padding: padding, child: child),
    );
  }
}

class CardHeader extends StatelessWidget {
  final String title;
  final String? description;

  const CardHeader({super.key, required this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        if (description != null) ...[
          const SizedBox(height: 6),
          Text(
            description!,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.mutedForeground,
            ),
          ),
        ],
      ],
    );
  }
}
