import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/analytics_provider.dart';
import '../providers/trade_provider.dart';
import '../../core/routing/app_router.dart';
import '../../domain/entities/trade_filter.dart';
import '../widgets/section_header.dart';
import '../widgets/performance_trend_chart.dart';
import '../../core/utils/version_service.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/contribution_heatmap.dart';

class HomeOverviewView extends ConsumerStatefulWidget {
  const HomeOverviewView({super.key});

  @override
  ConsumerState<HomeOverviewView> createState() => _HomeOverviewViewState();
}

class _HomeOverviewViewState extends ConsumerState<HomeOverviewView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      VersionService().checkForUpdate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(authProvider);
    final username = userState.value?.username ?? 'Trader';
    final analytics = ref.watch(analyticsProvider(null));
    final currentFilter = ref.watch(tradesProvider.notifier).currentFilter;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back! 👋',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                          Text(
                            'Hello $username',
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: AppTheme.accentGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppTheme.getNeonShadow(opacity: 0.4),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRouter.notifications,
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.black.withValues(alpha: 0.8),
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Stats Section with Modern Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    _buildStatGridItem(
                      title: 'Total PnL',
                      value: '${analytics.totalPnl >= 0 ? '' : '-'}\$${analytics.totalPnl.abs().toStringAsFixed(2)}',
                      icon: Icons.trending_up_rounded,
                      isHighlight: true,
                    ),
                    _buildStatGridItem(
                      title: 'Total Trades',
                      value: '${analytics.totalTrades}',
                      icon: Icons.swap_horiz_rounded,
                      isHighlight: false,
                    ),
                    _buildStatGridItem(
                      title: 'Win Rate',
                      value: '${analytics.winRate.toStringAsFixed(1)}%',
                      icon: Icons.show_chart_rounded,
                      isHighlight: true,
                    ),
                    _buildStatGridItem(
                      title: 'Max Drawdown',
                      value: '\$${analytics.maxDrawdown.abs().toStringAsFixed(2)}',
                      icon: Icons.trending_down_rounded,
                      isHighlight: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Performance Trend Section
              SectionHeader(
                title: 'Performance Trend',
                subtitle: 'Equity curve visualization',
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PerformanceTrendChart(
                  equityCurve: analytics.equityCurve,
                ),
              ),
              const SizedBox(height: 40),

              // Filter Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filter Trades',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          AnimatedChip(
                            label: 'All Trades',
                            isSelected: currentFilter == TradeFilter.all,
                            onTap: () {
                              ref
                                  .read(tradesProvider.notifier)
                                  .filterBy(TradeFilter.all);
                            },
                          ),
                          const SizedBox(width: 10),
                          AnimatedChip(
                            label: 'Winning',
                            isSelected: currentFilter == TradeFilter.winning,
                            onTap: () {
                              ref
                                  .read(tradesProvider.notifier)
                                  .filterBy(TradeFilter.winning);
                            },
                            icon: Icons.trending_up,
                          ),
                          const SizedBox(width: 10),
                          AnimatedChip(
                            label: 'Losing',
                            isSelected: currentFilter == TradeFilter.losing,
                            onTap: () {
                              ref
                                  .read(tradesProvider.notifier)
                                  .filterBy(TradeFilter.losing);
                            },
                            icon: Icons.trending_down,
                          ),
                          const SizedBox(width: 10),
                          AnimatedChip(
                            label: 'Today',
                            isSelected: currentFilter == TradeFilter.today,
                            onTap: () {
                              ref
                                  .read(tradesProvider.notifier)
                                  .filterBy(TradeFilter.today);
                            },
                            icon: Icons.calendar_today,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Performance Summary Section - Removed for cleaner layout

              // Analytics Heatmap
              SectionHeader(
                title: 'Activity Heatmap',
                subtitle: 'Daily consistency tracking',
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  decoration: AppTheme.getCardDecoration(),
                  padding: const EdgeInsets.all(16),
                  child: ref.watch(tradesProvider).maybeWhen(
                    data: (trades) => ContributionHeatmap(trades: trades),
                    orElse: () => const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatGridItem({
    required String title,
    required String value,
    required IconData icon,
    required bool isHighlight,
  }) {
    final iconColor = isHighlight ? Colors.black : AppTheme.accentColor;
    final valueColor = isHighlight ? Colors.black : AppTheme.textColor;
    final labelColor = isHighlight
        ? Colors.black.withValues(alpha: 0.7)
        : AppTheme.textSecondary;

    return Container(
      decoration: BoxDecoration(
        color: isHighlight ? null : AppTheme.cardDark,
        gradient: isHighlight ? AppTheme.accentGradient : null,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isHighlight
              ? AppTheme.accentColor.withValues(alpha: 0.5)
              : AppTheme.borderColor.withValues(alpha: 0.2),
          width: 1.2,
        ),
        boxShadow: [
          if (isHighlight)
            ...AppTheme.getNeonShadow(opacity: 0.25)
          else
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: labelColor,
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
}
