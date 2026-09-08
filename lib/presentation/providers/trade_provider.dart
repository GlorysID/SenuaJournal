import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/trade_entity.dart';
import '../../domain/repositories/trade_repository.dart';
import '../../data/repositories/trade_repository_impl.dart';
import '../../data/database/isar_service.dart';
import '../../domain/entities/trade_filter.dart';
import '../../data/models/trade.dart';
import 'auth_provider.dart';

final tradeRepositoryProvider = Provider<TradeRepository>((ref) {
  return TradeRepositoryImpl(IsarService());
});

final tradesProvider = AsyncNotifierProvider<TradesNotifier, List<TradeEntity>>(
  () {
    return TradesNotifier();
  },
);

class TradesNotifier extends AsyncNotifier<List<TradeEntity>> {
  late TradeRepository _repository;
  TradeFilter _currentFilter = TradeFilter.all;
  StreamSubscription? _subscription;

  TradeFilter get currentFilter => _currentFilter;

  @override
  FutureOr<List<TradeEntity>> build() async {
    _repository = ref.watch(tradeRepositoryProvider);
    
    // Listen for database changes to update UI automatically
    final isar = await IsarService().db;
    _subscription?.cancel();
    _subscription = isar.collection<Trade>().watchLazy().listen((_) async {
      state = await AsyncValue.guard(() => _fetchTrades());
    });

    ref.onDispose(() => _subscription?.cancel());

    return _fetchTrades();
  }

  Future<List<TradeEntity>> _fetchTrades() async {
    final user = ref.read(authProvider).value;
    if (user == null) return [];
    
    if (_currentFilter == TradeFilter.all) {
      return await _repository.getTrades(user.id);
    } else {
      return await _repository.getFilteredTrades(user.id, _currentFilter);
    }
  }

  Future<void> loadTrades() async {
    state = await AsyncValue.guard(() async => await _fetchTrades());
  }

  Future<void> addTrade(TradeEntity trade) async {
    try {
      await _repository.createTrade(trade);
      // No need to update state manually, watchLazy handles it
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTrade(TradeEntity trade) async {
    try {
      await _repository.updateTrade(trade);
      // No need to update state manually, watchLazy handles it
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTrade(int tradeId) async {
    try {
      await _repository.deleteTrade(tradeId);
      // No need to update state manually, watchLazy handles it
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteAllTrades() async {
    try {
      final user = ref.read(authProvider).value;
      if (user == null) return;
      await _repository.deleteAllTrades(user.id);
      // No need to update state manually, watchLazy handles it
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> searchTrades(String query) async {
    if (query.isEmpty) {
      await loadTrades();
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(authProvider).value;
      if (user == null) return [];
      return await _repository.searchTrades(user.id, query);
    });
  }

  Future<void> filterBy(TradeFilter filter) async {
    _currentFilter = filter;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _fetchTrades());
  }
}
