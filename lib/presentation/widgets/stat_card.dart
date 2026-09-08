import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final bool isPositive;
  final String? subtitle;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.isPositive = true,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: AppTheme.getCardDecoration(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        value,
                        style: const TextStyle(
                          color: AppTheme.textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (iconColor ?? AppTheme.accentColor).withValues(
                      alpha: 0.15,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? AppTheme.accentColor,
                    size: 24,
                  ),
                ),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 12),
              Text(
                subtitle!,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class StatGridCard extends StatelessWidget {
  final String tlTitle;
  final String tlValue;
  final String trTitle;
  final String trValue;
  final String blTitle;
  final String blValue;
  final String brTitle;
  final String brValue;

  const StatGridCard({
    super.key,
    required this.tlTitle,
    required this.tlValue,
    required this.trTitle,
    required this.trValue,
    required this.blTitle,
    required this.blValue,
    required this.brTitle,
    required this.brValue,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildGridItem(tlTitle, tlValue),
        _buildGridItem(trTitle, trValue),
        _buildGridItem(blTitle, blValue),
        _buildGridItem(brTitle, brValue),
      ],
    );
  }

  Widget _buildGridItem(String title, String value) {
    return Container(
      decoration: AppTheme.getCardDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class TrendCard extends StatelessWidget {
  final String title;
  final String value;
  final double change;
  final bool isPositive;
  final IconData trendIcon;

  const TrendCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.trendIcon,
  });

  @override
  Widget build(BuildContext context) {
    final trendColor = isPositive ? AppTheme.successColor : AppTheme.errorColor;

    return Container(
      decoration: AppTheme.getCardDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(trendIcon, color: trendColor, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: trendColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%',
              style: TextStyle(
                color: trendColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
