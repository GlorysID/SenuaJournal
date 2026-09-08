import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';
import '../models/trade.dart';
import '../models/strategy.dart';
import '../models/session.dart';

class IsarService {
  late Future<Isar> db;

  static final IsarService _instance = IsarService._internal();

  factory IsarService() {
    return _instance;
  }

  IsarService._internal() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([
        UserSchema,
        TradeSchema,
        StrategySchema,
        SessionSchema,
      ], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
