import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:isar/isar.dart';
import 'isar_service.dart';
import '../models/trade.dart';
import '../models/strategy.dart';

class SyncService {
  final IsarService _isarService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isPulling = false;

  SyncService(this._isarService);

  String? get _userId => fb.FirebaseAuth.instance.currentUser?.uid;

  /// Push all local data to Firestore
  Future<void> pushLocalToCloud() async {
    if (_isPulling) return; // Don't push while pulling

    final userId = _userId;
    if (userId == null) return;

    final isar = await _isarService.db;

    // Sync Trades
    final trades = await isar.collection<Trade>().where().findAll();
    for (var trade in trades) {
      if (trade.uuid.isEmpty) continue;
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('trades')
          .doc(trade.uuid) // Use UUID instead of auto-increment ID
          .set(trade.toMap());
    }

    // Sync Strategies
    final strategies = await isar.collection<Strategy>().where().findAll();
    for (var strategy in strategies) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('strategies')
          .doc(strategy.id.toString())
          .set(strategy.toMap());
    }
  }

  /// Pull all cloud data to local Isar
  Future<void> pullCloudToLocal() async {
    final userId = _userId;
    if (userId == null) return;

    _isPulling = true;
    try {
      final isar = await _isarService.db;

      // Pull Strategies first
      final strategiesSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('strategies')
          .get();

      for (var doc in strategiesSnapshot.docs) {
        final data = doc.data();
        final strategy = Strategy.fromMap(data);
        await isar.writeTxn(() async {
          await isar.collection<Strategy>().put(strategy);
        });
      }

      // Pull Trades
      final tradesSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('trades')
          .get();

      if (tradesSnapshot.docs.isNotEmpty) {
        await isar.writeTxn(() async {
          for (var doc in tradesSnapshot.docs) {
            final data = doc.data();
            final trade = Trade.fromMap(data);
            
            // Check if already exists by uuid to avoid duplicates
            final existing = await isar.collection<Trade>().filter().uuidEqualTo(trade.uuid).findFirst();
            if (existing != null) {
              trade.id = existing.id;
            }
            await isar.collection<Trade>().put(trade);
          }
        });
      }
    } finally {
      _isPulling = false;
    }
  }

  /// Listen for local changes and push to cloud
  void startAutoSync() async {
    final isar = await _isarService.db;

    // Listen to trades
    isar.collection<Trade>().watchLazy().listen((_) {
      pushLocalToCloud();
    });

    // Listen to strategies
    isar.collection<Strategy>().watchLazy().listen((_) {
      pushLocalToCloud();
    });
  }
}
