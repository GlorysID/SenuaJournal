import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/analytics_provider.dart';
import '../widgets/section_header.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/contribution_heatmap.dart';
import '../providers/trade_provider.dart';
import '../providers/auth_provider.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  int selectedYear = 2024;

  Widget _buildQuickAction(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor.withValues(alpha: 0.3)),
      ),
      child: IconButton(
        icon: const Icon(Icons.tune_rounded, color: AppTheme.accentColor),
        onPressed: () {},
      ),
    );
  }

  Widget _buildStreakCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        if (label == 'Less') ...[
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary),
          ),
          const SizedBox(width: 8),
        ],
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        if (label == 'More') ...[
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary),
          ),
        ],
        if (label != 'Less' && label != 'More') const SizedBox(width: 4),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final analytics = ref.watch(analyticsProvider(selectedYear));

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Premium Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Performance Summary',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                        Text(
                          'Trading Analytics',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                            letterSpacing: -0.5,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${analytics.totalTrades} signals recorded in $selectedYear',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    _buildQuickAction(context),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Current Balance Card
              Consumer(
                builder: (context, ref, child) {
                  final overallAnalytics = ref.watch(analyticsProvider(null));
                  final user = ref.watch(authProvider).value;
                  final initialBalance = user?.initialBalance ?? 0.0;
                  final currentBalance = initialBalance + overallAnalytics.totalPnl;
                  final pnlPercentage = initialBalance > 0 
                      ? (overallAnalytics.totalPnl / initialBalance) * 100 
                      : 0.0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: AppTheme.accentGradient,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: AppTheme.getNeonShadow(opacity: 0.3),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'CURRENT BALANCE',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${pnlPercentage >= 0 ? '+' : ''}${pnlPercentage.toStringAsFixed(1)}%',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${currentBalance >= 0 ? '' : '-'}\$${currentBalance.abs().toStringAsFixed(2)}',
                            style: GoogleFonts.outfit(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                overallAnalytics.totalPnl >= 0 
                                  ? Icons.trending_up_rounded 
                                  : Icons.trending_down_rounded,
                                size: 16,
                                color: Colors.black.withValues(alpha: 0.7),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${overallAnalytics.totalPnl >= 0 ? 'Profit' : 'Loss'} of \$${overallAnalytics.totalPnl.abs().toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Trading Streaks (Gacor Row)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildStreakCard(
                      'Win Streak',
                      '${analytics.winningStreak}',
                      Icons.keyboard_double_arrow_up_rounded,
                      AppTheme.successColor,
                    ),
                    const SizedBox(width: 12),
                    _buildStreakCard(
                      'Loss Streak',
                      '${analytics.losingStreak}',
                      Icons.keyboard_double_arrow_down_rounded,
                      AppTheme.errorColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Enhanced Year Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildYearChip(
                        DateTime.now().year,
                        selectedYear == DateTime.now().year,
                      ),
                      const SizedBox(width: 12),
                      _buildYearChip(2024, selectedYear == 2024),
                      const SizedBox(width: 12),
                      _buildYearChip(2023, selectedYear == 2023),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Enhanced Heatmap Section
              SectionHeader(
                title: 'Activity Heatmap',
                subtitle: 'Daily consistency tracking',
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.cardDark,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppTheme.borderColor.withValues(alpha: 0.2),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      ref.watch(tradesProvider).maybeWhen(
                        data: (trades) => ContributionHeatmap(
                          trades: trades,
                          year: selectedYear,
                        ),
                        orElse: () => const CircularProgressIndicator(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLegendItem(
                            'Less',
                            AppTheme.cardDark.withValues(alpha: 0.5),
                          ),
                          _buildLegendItem(
                            '',
                            AppTheme.accentColor.withValues(alpha: 0.3),
                          ),
                          _buildLegendItem(
                            '',
                            AppTheme.accentColor.withValues(alpha: 0.6),
                          ),
                          _buildLegendItem('More', AppTheme.accentColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Key Metrics Section
              SectionHeader(
                title: 'Efficiency Metrics',
                subtitle: 'Profitability indicators',
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetricDiamond(
                      '${analytics.winRate.toStringAsFixed(1)}%',
                      'Win Rate',
                      isGreen: true,
                    ),
                    _buildMetricDiamond(
                      '${analytics.expectedValue >= 0 ? '' : '-'}\$${analytics.expectedValue.abs().toStringAsFixed(2)}',
                      'Expectancy',
                      isGreen: false,
                    ),
                    _buildMetricDiamond(
                      '${analytics.totalTrades}',
                      'Total',
                      isGreen: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricDiamond(
    String value,
    String label, {
    required bool isGreen,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: isGreen ? AppTheme.accentGradient : null,
          color: isGreen ? null : AppTheme.cardDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isGreen
                ? AppTheme.accentColor.withValues(alpha: 0.5)
                : AppTheme.borderColor.withValues(alpha: 0.2),
            width: 1.2,
          ),
          boxShadow: isGreen
              ? AppTheme.getNeonShadow(opacity: 0.25)
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isGreen ? Colors.black : AppTheme.textColor,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isGreen
                      ? Colors.black.withValues(alpha: 0.7)
                      : AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYearChip(int year, bool isSelected) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => selectedYear = year),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected ? AppTheme.accentGradient : null,
          color: isSelected ? null : AppTheme.cardDark.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppTheme.accentColor.withValues(alpha: 0.5)
                : AppTheme.borderColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.accentColor.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          year.toString(),
          style: TextStyle(
            color: isSelected ? Colors.black : AppTheme.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
