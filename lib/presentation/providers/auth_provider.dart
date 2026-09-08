import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/database/isar_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(IsarService());
});

class AuthNotifier extends AsyncNotifier<UserEntity?> {
  late AuthRepository _repository;

  @override
  FutureOr<UserEntity?> build() async {
    _repository = ref.watch(authRepositoryProvider);
    return _repository.getCurrentUser();
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _repository.login(username, password);
      if (user == null) {
        throw Exception('Invalid username or password');
      }
      return user;
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _repository.signInWithGoogle();
      if (user == null) {
        return null; // Silent cancel or custom error
      }
      return user;
    });
  }

  Future<void> register(String username, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.register(username, password);
    });
  }

  Future<void> updateProfile(String newUsername) async {
    final currentUser = state.value;
    if (currentUser == null) throw Exception('Not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.updateProfile(currentUser.id, newUsername);
    });
  }

  Future<void> updateInitialBalance(double balance) async {
    final currentUser = state.value;
    if (currentUser == null) throw Exception('Not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.updateInitialBalance(currentUser.id, balance);
    });
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final currentUser = state.value;
    if (currentUser == null) throw Exception('Not logged in');

    await _repository.changePassword(
      currentUser.id,
      currentPassword,
      newPassword,
    );
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.logout();
      return null;
    });
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, UserEntity?>(() {
  return AuthNotifier();
});
