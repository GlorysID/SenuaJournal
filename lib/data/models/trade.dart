import 'package:isar/isar.dart';

part 'trade.g.dart';

@collection
class Trade {
  Id id = Isar.autoIncrement;

  @Index()
  late int userId;

  @Index()
  late DateTime date;

  late String pair;
  late String marketType; // 'Futures', 'Spot DEX'
  late String direction; // 'Long', 'Short', 'Buy'

  late double entryPrice;
  double? exitPrice;
  double? stopLoss;
  double? takeProfit;

  late double positionSize; // in USD
  int? leverage;
  String? riskRewardRatio;

  double? pnl;

  int? strategyId;
  String? notes;
  String? emotion;
  String? reason;
  String? screenshotPath;

  @Index(unique: true)
  late String uuid;

  late DateTime createdAt;

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'pair': pair,
      'marketType': marketType,
      'direction': direction,
      'entryPrice': entryPrice,
      'exitPrice': exitPrice,
      'stopLoss': stopLoss,
      'takeProfit': takeProfit,
      'positionSize': positionSize,
      'leverage': leverage,
      'riskRewardRatio': riskRewardRatio,
      'pnl': pnl,
      'strategyId': strategyId,
      'notes': notes,
      'emotion': emotion,
      'reason': reason,
      'screenshotPath': screenshotPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static Trade fromMap(Map<String, dynamic> map) {
    return Trade()
      ..uuid = map['uuid'] ?? ''
      ..id = map['id'] ?? Isar.autoIncrement
      ..userId = map['userId']
      ..date = DateTime.parse(map['date'])
      ..pair = map['pair']
      ..marketType = map['marketType']
      ..direction = map['direction']
      ..entryPrice = (map['entryPrice'] as num).toDouble()
      ..exitPrice = (map['exitPrice'] as num?)?.toDouble()
      ..stopLoss = (map['stopLoss'] as num?)?.toDouble()
      ..takeProfit = (map['takeProfit'] as num?)?.toDouble()
      ..positionSize = (map['positionSize'] as num).toDouble()
      ..leverage = map['leverage']
      ..riskRewardRatio = map['riskRewardRatio']
      ..pnl = (map['pnl'] as num?)?.toDouble()
      ..strategyId = map['strategyId']
      ..notes = map['notes']
      ..emotion = map['emotion']
      ..reason = map['reason']
      ..screenshotPath = map['screenshotPath']
      ..createdAt = DateTime.parse(map['createdAt']);
  }
}
