import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/isar_service.dart';
import '../../data/database/sync_service.dart';
import 'auth_provider.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(IsarService());
});

final syncProvider = Provider<void>((ref) {
  final auth = ref.watch(authProvider);
  final syncService = ref.read(syncServiceProvider);

  if (auth.hasValue && auth.value != null) {
    // Start auto sync when user is logged in
    syncService.startAutoSync();
    
    // Initial pull to get data from cloud
    syncService.pullCloudToLocal();
  }
});
