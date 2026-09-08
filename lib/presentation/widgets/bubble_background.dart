import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BubbleBackground extends StatelessWidget {
  final Widget child;
  const BubbleBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base dark background
        Container(color: AppTheme.primaryColor),
        // Glowing Green Bubbles
        Positioned(
          top: -100,
          left: -100,
          child: _buildBubble(
            300,
            AppTheme.accentColor.withValues(alpha: 0.15),
          ),
        ),
        Positioned(
          bottom: -150,
          right: -50,
          child: _buildBubble(400, AppTheme.accentColor.withValues(alpha: 0.1)),
        ),
        Positioned(
          top: 200,
          right: -200,
          child: _buildBubble(
            350,
            AppTheme.successColor.withValues(alpha: 0.12),
          ),
        ),
        Positioned(
          bottom: 200,
          left: -150,
          child: _buildBubble(
            250,
            AppTheme.accentColor.withValues(alpha: 0.08),
          ),
        ),
        // Glassmorphism overlay for content
        SafeArea(child: Center(child: child)),
      ],
    );
  }

  Widget _buildBubble(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
          stops: const [0.2, 1.0],
        ),
      ),
    );
  }
}
