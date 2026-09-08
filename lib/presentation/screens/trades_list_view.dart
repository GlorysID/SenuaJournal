import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/trade_provider.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../core/routing/app_router.dart';
import '../providers/auth_provider.dart';

class TradesListView extends ConsumerStatefulWidget {
  const TradesListView({super.key});

  @override
  ConsumerState<TradesListView> createState() => _TradesListViewState();
}

class _TradesListViewState extends ConsumerState<TradesListView> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(tradesProvider.notifier).loadTrades());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tradesState = ref.watch(tradesProvider);

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.accentColor,
        onPressed: () => Navigator.pushNamed(context, AppRouter.addTrade),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Text(
                'My Trades',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search pair or notes...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(tradesProvider.notifier).searchTrades('');
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                onSubmitted: (value) =>
                    ref.read(tradesProvider.notifier).searchTrades(value),
              ),
            ),
            Expanded(
              child: tradesState.when(
                data: (trades) {
                  if (trades.isEmpty) {
                    return const Center(
                      child: Text(
                        'No trades found. Tap + to add one!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: trades.length,
                    itemBuilder: (context, index) {
                      final trade = trades[index];
                      final isProfit = (trade.pnl ?? 0) >= 0;
                      return Dismissible(
                        key: Key(trade.uuid),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.errorColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.delete_outline, color: AppTheme.errorColor),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: AppTheme.cardDark,
                              title: const Text('Delete Trade?', style: TextStyle(color: AppTheme.textColor)),
                              content: const Text('Remove this trade from history?', style: TextStyle(color: AppTheme.textSecondary)),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: AppTheme.errorColor))),
                              ],
                            ),
                          );
                        },
                        onDismissed: (direction) {
                          ref.read(tradesProvider.notifier).deleteTrade(trade.id);
                        },
                        child: Card(
                          color: AppTheme.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          title: Text(
                            '${trade.pair} (${trade.marketType})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            '${trade.direction} | ${DateFormat.yMd().format(trade.date)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                trade.pnl != null
                                    ? '\$${trade.pnl!.toStringAsFixed(2)}'
                                    : 'Open',
                                style: TextStyle(
                                  color: trade.pnl == null
                                      ? Colors.grey
                                      : (isProfit
                                            ? AppTheme.accentColor
                                            : AppTheme.errorColor),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  final user = ref.watch(authProvider).value;
                                  final initialBalance = user?.initialBalance ?? 0.0;
                                  
                                  // Calculate cumulative balance up to this trade
                                  final sortedTrades = [...trades];
                                  sortedTrades.sort((a, b) => a.date.compareTo(b.date));
                                  
                                  double runningBalance = initialBalance;
                                  for (var t in sortedTrades) {
                                    runningBalance += (t.pnl ?? 0);
                                    if (t.id == trade.id) break;
                                  }

                                  return Text(
                                    'Balance: \$${runningBalance.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white.withValues(alpha: 0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRouter.tradeDetail,
                              arguments: trade,
                            );
                          },
                        ),
                      ),
                    );
                  },
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(color: AppTheme.accentColor),
                ),
                error: (e, st) => Center(
                  child: Text(
                    'Error: $e',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
