import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/trade_entity.dart';
import '../../domain/entities/analytics_entity.dart';
import 'trade_provider.dart';
import 'auth_provider.dart';

final analyticsProvider = Provider.family<AnalyticsEntity, int?>((ref, year) {
  final tradesAsync = ref.watch(tradesProvider);
  final user = ref.watch(authProvider).value;
  final initialBalance = user?.initialBalance ?? 0.0;

  return tradesAsync.maybeWhen(
    data: (trades) {
      final filteredTrades = year == null
          ? trades
          : trades.where((t) => t.date.year == year).toList();
      return _calculateAnalytics(filteredTrades, initialBalance);
    },
    orElse: () => AnalyticsEntity.empty(),
  );
});

AnalyticsEntity _calculateAnalytics(List<TradeEntity> trades, double initialBalance) {
  final closedTrades = trades.where((t) => t.pnl != null).toList();
  // Sort oldest to newest for equity curve
  closedTrades.sort((a, b) => a.date.compareTo(b.date));

  if (closedTrades.isEmpty) return AnalyticsEntity.empty();

  double totalPnl = 0;
  int winningTrades = 0;
  int losingTrades = 0;
  List<double> equityCurve = [initialBalance];

  double peakEquity = initialBalance;
  double maxDrawdown = 0;

  double currentEquity = initialBalance;

  int maxWinStreak = 0;
  int maxLossStreak = 0;
  int currentWinStreak = 0;
  int currentLossStreak = 0;

  for (var trade in closedTrades) {
    double pnl = trade.pnl ?? 0;
    if (pnl.isNaN || pnl.isInfinite) pnl = 0;

    totalPnl += pnl;
    currentEquity += pnl;

    equityCurve.add(currentEquity);

    if (pnl > 0) {
      winningTrades++;
      currentWinStreak++;
      currentLossStreak = 0;
      if (currentWinStreak > maxWinStreak) maxWinStreak = currentWinStreak;
    } else if (pnl < 0) {
      losingTrades++;
      currentLossStreak++;
      currentWinStreak = 0;
      if (currentLossStreak > maxLossStreak) maxLossStreak = currentLossStreak;
    }

    if (currentEquity.isFinite && currentEquity > peakEquity) {
      peakEquity = currentEquity;
    }

    if (currentEquity.isFinite) {
      double drawdown = peakEquity - currentEquity;
      if (drawdown > maxDrawdown) {
        maxDrawdown = drawdown;
      }
    }
  }

  int total = closedTrades.length;
  double winRate = (winningTrades / total) * 100;
  double expectedValue = totalPnl / total;

  return AnalyticsEntity(
    totalPnl: totalPnl,
    totalTrades: total,
    winningTrades: winningTrades,
    losingTrades: losingTrades,
    winRate: winRate,
    maxDrawdown: maxDrawdown,
    expectedValue: expectedValue,
    equityCurve: equityCurve,
    winningStreak: maxWinStreak,
    losingStreak: maxLossStreak,
  );
}
