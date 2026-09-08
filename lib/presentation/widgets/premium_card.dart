import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool withGradient;
  final LinearGradient? customGradient;
  final Color? backgroundColor;

  const PremiumCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 20,
    this.onTap,
    this.withGradient = true,
    this.customGradient,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: withGradient
            ? AppTheme.getCardDecoration(borderRadius: borderRadius)
            : BoxDecoration(
                color: backgroundColor ?? AppTheme.cardDark,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: AppTheme.borderColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final double opacity;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
    this.opacity = 0.08,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: AppTheme.getGlassyDecoration(
          opacity: opacity,
          borderRadius: borderRadius,
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class GradientCard extends StatelessWidget {
  final Widget child;
  final LinearGradient gradient;
  final EdgeInsets padding;
  final double borderRadius;
  final VoidCallback? onTap;

  const GradientCard({
    super.key,
    required this.child,
    required this.gradient,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: AppTheme.getGradientDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
