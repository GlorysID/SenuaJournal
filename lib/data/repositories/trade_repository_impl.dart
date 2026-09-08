import 'package:isar/isar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:uuid/uuid.dart';
import '../../domain/entities/trade_entity.dart';
import '../../domain/entities/trade_filter.dart';
import '../../domain/repositories/trade_repository.dart';
import '../database/isar_service.dart';
import '../models/trade.dart';

class TradeRepositoryImpl implements TradeRepository {
  final IsarService _isarService;
  final _uuid = const Uuid();

  TradeRepositoryImpl(this._isarService);

  @override
  Future<List<TradeEntity>> getTrades(int userId) async {
    final isar = await _isarService.db;
    final trades = await isar.trades
        .filter()
        .userIdEqualTo(userId)
        .sortByDateDesc()
        .findAll();
    return trades.map(_mapToEntity).toList();
  }

  @override
  Future<TradeEntity> createTrade(TradeEntity entity) async {
    final isar = await _isarService.db;
    final model = _mapToModel(entity);
    
    // Generate UUID for new trade
    model.uuid = _uuid.v4();

    await isar.writeTxn(() async {
      final id = await isar.trades.put(model);
      model.id = id;
    });

    return _mapToEntity(model);
  }

  @override
  Future<TradeEntity> updateTrade(TradeEntity entity) async {
    final isar = await _isarService.db;
    final model = _mapToModel(entity);
    model.id = entity.id; // ensure ID is set for update

    await isar.writeTxn(() async {
      await isar.trades.put(model);
    });

    return _mapToEntity(model);
  }

  @override
  Future<void> deleteTrade(int tradeId) async {
    final isar = await _isarService.db;
    
    // Get the trade first to find its UUID for cloud deletion
    final trade = await isar.collection<Trade>().get(tradeId);
    final uuid = trade?.uuid;
    final fbUser = fb.FirebaseAuth.instance.currentUser;

    await isar.writeTxn(() async {
      await isar.collection<Trade>().delete(tradeId);
    });

    // Delete from Cloud (Firestore)
    if (uuid != null && fbUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(fbUser.uid)
          .collection('trades')
          .doc(uuid)
          .delete();
    }
  }

  @override
  Future<List<TradeEntity>> searchTrades(int userId, String query) async {
    final isar = await _isarService.db;
    final q = query.toLowerCase();

    final trades = await isar.trades
        .filter()
        .userIdEqualTo(userId)
        .and()
        .group(
          (qBuilder) => qBuilder
              .pairContains(q, caseSensitive: false)
              .or()
              .notesContains(q, caseSensitive: false),
        )
        .sortByDateDesc()
        .findAll();

    return trades.map(_mapToEntity).toList();
  }

  @override
  Future<List<TradeEntity>> getFilteredTrades(
    int userId,
    TradeFilter filter,
  ) async {
    final isar = await _isarService.db;
    var query = isar.trades.filter().userIdEqualTo(userId);

    switch (filter) {
      case TradeFilter.all:
        // Already filtered by userId
        break;
      case TradeFilter.winning:
        query = query.and().pnlGreaterThan(0);
        break;
      case TradeFilter.losing:
        query = query.and().pnlLessThan(0);
        break;
      case TradeFilter.today:
        final now = DateTime.now();
        final startOfDay = DateTime(now.year, now.month, now.day);
        final endOfDay = startOfDay.add(const Duration(days: 1));
        query = query.and().dateBetween(startOfDay, endOfDay);
        break;
    }

    final trades = await query.sortByDateDesc().findAll();
    return trades.map(_mapToEntity).toList();
  }

  @override
  Future<void> deleteAllTrades(int userId) async {
    final isar = await _isarService.db;
    
    // Delete locally
    await isar.writeTxn(() async {
      await isar.collection<Trade>().filter().userIdEqualTo(userId).deleteAll();
    });

    // Delete from Cloud (Firestore)
    final fbUser = fb.FirebaseAuth.instance.currentUser;
    if (fbUser != null) {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore
          .collection('users')
          .doc(fbUser.uid)
          .collection('trades')
          .get();
      
      final batch = firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }

  TradeEntity _mapToEntity(Trade model) {
    return TradeEntity(
      id: model.id,
      uuid: model.uuid,
      userId: model.userId,
      date: model.date,
      pair: model.pair,
      marketType: model.marketType,
      direction: model.direction,
      entryPrice: model.entryPrice,
      exitPrice: model.exitPrice,
      stopLoss: model.stopLoss,
      takeProfit: model.takeProfit,
      positionSize: model.positionSize,
      leverage: model.leverage,
      riskRewardRatio: model.riskRewardRatio,
      pnl: model.pnl,
      strategyId: model.strategyId,
      notes: model.notes,
      emotion: model.emotion,
      reason: model.reason,
      screenshotPath: model.screenshotPath,
      createdAt: model.createdAt,
    );
  }

  Trade _mapToModel(TradeEntity entity) {
    return Trade()
      ..uuid = entity.uuid
      ..userId = entity.userId
      ..date = entity.date
      ..pair = entity.pair
      ..marketType = entity.marketType
      ..direction = entity.direction
      ..entryPrice = entity.entryPrice
      ..exitPrice = entity.exitPrice
      ..stopLoss = entity.stopLoss
      ..takeProfit = entity.takeProfit
      ..positionSize = entity.positionSize
      ..leverage = entity.leverage
      ..riskRewardRatio = entity.riskRewardRatio
      ..pnl = entity.pnl
      ..strategyId = entity.strategyId
      ..notes = entity.notes
      ..emotion = entity.emotion
      ..reason = entity.reason
      ..screenshotPath = entity.screenshotPath
      ..createdAt = entity.createdAt;
  }
}
