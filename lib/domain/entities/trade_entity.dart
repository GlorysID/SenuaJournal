class TradeEntity {
  final int id;
  final int userId;
  final DateTime date;
  final String pair;
  final String marketType; // 'Futures', 'Spot DEX'
  final String direction; // 'Long', 'Short', 'Buy'
  final double entryPrice;
  final double? exitPrice;
  final double? stopLoss;
  final double? takeProfit;
  final double positionSize; // in USD
  final int? leverage;
  final String? riskRewardRatio;
  final double? pnl;
  final int? strategyId;
  final String? notes;
  final String? emotion;
  final String? reason;
  final String? screenshotPath;
  final String uuid;
  final DateTime createdAt;

  TradeEntity({
    required this.id,
    this.uuid = '',
    required this.userId,
    required this.date,
    required this.pair,
    required this.marketType,
    required this.direction,
    required this.entryPrice,
    this.exitPrice,
    this.stopLoss,
    this.takeProfit,
    required this.positionSize,
    this.leverage,
    this.riskRewardRatio,
    this.pnl,
    this.strategyId,
    this.notes,
    this.emotion,
    this.reason,
    this.screenshotPath,
    required this.createdAt,
  });
}
