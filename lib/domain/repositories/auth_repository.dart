import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> login(String username, String password);
  Future<UserEntity?> signInWithGoogle();
  Future<UserEntity> register(String username, String password);
  Future<UserEntity> updateProfile(int userId, String newUsername);
  Future<UserEntity> updateInitialBalance(int userId, double balance);
  Future<void> changePassword(
    int userId,
    String currentPassword,
    String newPassword,
  );
  Future<UserEntity?> getCurrentUser();
  Future<void> logout();
}
