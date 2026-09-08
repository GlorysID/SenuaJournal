import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;
  final Widget? trailing;
  final MainAxisAlignment alignment;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
    this.trailing,
    this.alignment = MainAxisAlignment.spaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: alignment,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                        letterSpacing: 0.3,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else if (onSeeAll != null)
                GestureDetector(
                  onTap: onSeeAll,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.accentColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const AnimatedChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  State<AnimatedChip> createState() => _AnimatedChipState();
}

class _AnimatedChipState extends State<AnimatedChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1).animate(_controller);

    if (widget.isSelected) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: widget.isSelected ? AppTheme.accentGradient : null,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.isSelected
                  ? AppTheme.accentColor.withValues(alpha: 0.5)
                  : AppTheme.borderColor.withValues(alpha: 0.2),
              width: 1.2,
            ),
            boxShadow: widget.isSelected
                ? AppTheme.getNeonShadow(opacity: 0.2)
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 14,
                  color: widget.isSelected
                      ? Colors.black
                      : AppTheme.textSecondary,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isSelected
                      ? Colors.black
                      : AppTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: widget.isSelected
                      ? FontWeight.bold
                      : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final LinearGradient? gradient;
  final IconData? icon;
  final Size minimumSize;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.gradient,
    this.icon,
    this.minimumSize = const Size(double.infinity, 56),
    this.borderRadius = 16,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.isEnabled) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1, end: 0.95).animate(_controller),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.isEnabled && !widget.isLoading ? widget.onPressed : null,
        child: Container(
          constraints: BoxConstraints(minWidth: widget.minimumSize.width),
          height: widget.minimumSize.height,
          decoration: widget.gradient != null
              ? BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: AppTheme.getNeonShadow(opacity: 0.35),
                )
              : BoxDecoration(
                  color: widget.isEnabled
                      ? AppTheme.accentColor
                      : AppTheme.accentColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: widget.isEnabled ? AppTheme.getNeonShadow() : [],
                ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.isEnabled ? AppTheme.primaryColor : Colors.grey,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: widget.isEnabled
                              ? AppTheme.primaryColor
                              : Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: widget.isEnabled
                              ? AppTheme.primaryColor
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
