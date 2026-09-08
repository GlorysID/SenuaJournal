import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/trade_entity.dart';
import '../../presentation/providers/trade_provider.dart';
import '../../presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../data/database/isar_service.dart';
import 'package:share_plus/share_plus.dart';

class DataManager {
  final Ref ref;

  DataManager(this.ref);

  Future<void> exportCsv() async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception("User not logged in");

    final tradesState = ref.read(tradesProvider);
    if (!tradesState.hasValue || tradesState.value!.isEmpty) {
      throw Exception("No trades to export");
    }

    final trades = tradesState.value!;

    // Simple CSV construction
    StringBuffer csvData = StringBuffer();
    csvData.writeln(
      "Id,Date,Pair,MarketType,Direction,EntryPrice,ExitPrice,StopLoss,TakeProfit,PositionSize,Leverage,RiskRewardRatio,PnL,StrategyId,Emotion,Reason,Notes",
    );

    for (var t in trades) {
      csvData.writeln(
        "${t.id},${t.date.toIso8601String()},${t.pair},${t.marketType},${t.direction},${t.entryPrice},${t.exitPrice ?? ''},${t.stopLoss ?? ''},${t.takeProfit ?? ''},${t.positionSize},${t.leverage ?? ''},${t.riskRewardRatio ?? ''},${t.pnl ?? ''},${t.strategyId ?? ''},\"${t.emotion ?? ''}\",\"${t.reason ?? ''}\",\"${t.notes?.replaceAll('"', '""') ?? ''}\"",
      );
    }

    final directory = await getTemporaryDirectory(); // Use temp dir for sharing
    final path =
        "${directory.path}/trading_journal_export_${DateTime.now().millisecondsSinceEpoch}.csv";
    final file = File(path);
    await file.writeAsString(csvData.toString());

    // Use share_plus to let user choose where to save/send the file
    await Share.shareXFiles(
      [XFile(path)],
      subject: 'Trading Journal Export',
      text: 'Here is my trading journal export in CSV format.',
    );
  }

  Future<void> importCsv() async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception("User not logged in");

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null || result.files.single.path == null) return;

    final file = File(result.files.single.path!);
    final lines = await file.readAsLines();

    if (lines.length <= 1) throw Exception("CSV is empty or invalid");

    // Skip header line
    int importedCount = 0;
    for (int i = 1; i < lines.length; i++) {
      final line = lines[i];
      final parts = _parseCsvLine(line);
      if (parts.length < 10) continue;

      try {
        final trade = TradeEntity(
          id: 0,
          userId: user.id,
          date: DateTime.parse(parts[1]),
          pair: parts[2],
          marketType: parts[3],
          direction: parts[4],
          entryPrice: double.parse(parts[5]),
          exitPrice: parts[6].isNotEmpty ? double.parse(parts[6]) : null,
          stopLoss: parts[7].isNotEmpty ? double.parse(parts[7]) : null,
          takeProfit: parts[8].isNotEmpty ? double.parse(parts[8]) : null,
          positionSize: double.parse(parts[9]),
          leverage: parts[10].isNotEmpty ? int.tryParse(parts[10]) : null,
          riskRewardRatio: parts[11],
          pnl: parts[12].isNotEmpty ? double.parse(parts[12]) : null,
          strategyId: parts[13].isNotEmpty ? int.tryParse(parts[13]) : null,
          emotion: parts.length > 14 ? parts[14] : null,
          reason: parts.length > 15 ? parts[15] : null,
          notes: parts.length > 16 ? parts[16].replaceAll('"', '') : null,
          createdAt: DateTime.now(),
        );

        await ref.read(tradesProvider.notifier).addTrade(trade);
        importedCount++;
      } catch (e) {
        // Skip malformed rows
      }
    }

    throw Exception("Imported $importedCount trades successfully!");
  }

  List<String> _parseCsvLine(String line) {
    // Simple CSV parser that handles quoted strings
    List<String> result = [];
    bool inQuotes = false;
    StringBuffer currentPart = StringBuffer();

    for (int i = 0; i < line.length; i++) {
      String char = line[i];
      if (char == '"') {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        result.add(currentPart.toString());
        currentPart.clear();
      } else {
        currentPart.write(char);
      }
    }
    result.add(currentPart.toString());
    return result;
  }

  Future<void> generateDummyData() async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception("User not logged in");

    final random = Random();
    final pairs = ['BTC/USDT', 'ETH/USDT', 'SOL/USDT', 'DOGE/USDT', 'BNB/USDT'];
    final directions = ['Long', 'Short'];

    double currentEquity = 1000.0;

    // Generate 50 trades over the last 30 days
    for (int i = 0; i < 50; i++) {
      final pair = pairs[random.nextInt(pairs.length)];
      final dir = directions[random.nextInt(directions.length)];

      final daysAgo = 30 - i * (30 / 50);
      final date = DateTime.now().subtract(
        Duration(days: daysAgo.toInt(), hours: random.nextInt(24)),
      );

      final entry = 10 + random.nextDouble() * 1000;
      final isWin = random.nextBool();

      // Win rate ~50%, RR ~1:1.5
      double pnl = 0;
      if (isWin) {
        pnl =
            currentEquity *
            0.01 *
            (1 + random.nextDouble() * 1.5); // 1-2.5% gain
      } else {
        pnl =
            -currentEquity *
            0.01 *
            (0.5 + random.nextDouble() * 0.5); // 0.5-1% loss
      }

      currentEquity += pnl;

      final exit = dir == 'Long' ? entry + (pnl / 100) : entry - (pnl / 100);

      final trade = TradeEntity(
        id: 0,
        userId: user.id,
        date: date,
        pair: pair,
        marketType: 'Futures',
        direction: dir,
        entryPrice: entry,
        exitPrice: exit,
        positionSize: 100,
        leverage: 10,
        pnl: pnl,
        createdAt: DateTime.now(),
      );

      await ref.read(tradesProvider.notifier).addTrade(trade);
    }
  }

  Future<void> backupDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final backupPath =
        "${directory.path}/trading_journal_backup_${DateTime.now().millisecondsSinceEpoch}.isar";

    final isar = await IsarService().db;
    await isar.copyToFile(backupPath);

    throw Exception("Backup saved to: $backupPath");
  }

  Future<void> restoreDatabase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType
          .any, // .isar files might not be recognized as a custom type easily
    );

    if (result == null || result.files.single.path == null) return;

    final backupFile = File(result.files.single.path!);
    if (!backupFile.path.endsWith('.isar')) {
      throw Exception("Selected file is not a valid .isar backup");
    }

    final directory = await getApplicationDocumentsDirectory();
    final dbPath = "${directory.path}/default.isar"; // Default Isar filename

    // Close DB first if possible
    final isar = await IsarService().db;
    // Note: Re-opening Isar after replacement usually requires an app restart or
    // careful instance management. For this locally-offline app, we'll replace the file.

    await isar.close();
    await backupFile.copy(dbPath);

    throw Exception(
      "Database restored! Please restart the app to see changes.",
    );
  }

  Future<void> clearAllTrades() async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception("User not logged in");

    await ref.read(tradesProvider.notifier).deleteAllTrades();
  }
}

final dataManagerProvider = Provider<DataManager>((ref) {
  return DataManager(ref);
});
