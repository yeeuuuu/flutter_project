import 'package:flutter/material.dart';
import 'package:flutter_project2/styles/theme.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? fallbackText;
  final double size;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.fallbackText,
    this.size = 40, // h-10 w-10
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.muted, // bg-muted
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildFallback(),
            )
          : _buildFallback(),
    );
  }

  Widget _buildFallback() {
    return Center(
      child: Text(
        fallbackText ?? '',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppTheme.mutedForeground,
        ),
      ),
    );
  }
}
