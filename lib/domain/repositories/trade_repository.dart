import '../entities/trade_entity.dart';
import '../entities/trade_filter.dart';

abstract class TradeRepository {
  Future<List<TradeEntity>> getTrades(int userId);
  Future<TradeEntity> createTrade(TradeEntity trade);
  Future<TradeEntity> updateTrade(TradeEntity trade);
  Future<void> deleteTrade(int tradeId);
  Future<List<TradeEntity>> searchTrades(int userId, String query);
  Future<List<TradeEntity>> getFilteredTrades(int userId, TradeFilter filter);
  Future<void> deleteAllTrades(int userId);
}
