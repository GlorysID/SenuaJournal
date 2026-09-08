import 'package:isar/isar.dart';
import '../../core/utils/hash_util.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../database/isar_service.dart';
import '../models/user.dart';
import '../models/session.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final IsarService _isarService;

  AuthRepositoryImpl(this._isarService);

  @override
  Future<UserEntity?> login(String username, String password) async {
    final isar = await _isarService.db;
    final hashedPassword = HashUtil.hashPassword(password);

    final user = await isar.users
        .filter()
        .usernameEqualTo(username)
        .passwordHashEqualTo(hashedPassword)
        .findFirst();

    if (user != null) {
      await _saveSession(user.id);
      return UserEntity(
        id: user.id,
        username: user.username,
        email: user.email,
        firebaseUid: user.firebaseUid,
        initialBalance: user.initialBalance,
        createdAt: user.createdAt,
      );
    }
    return null;
  }

  @override
  Future<UserEntity?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final fb.UserCredential userCredential =
          await fb.FirebaseAuth.instance.signInWithCredential(credential);
      final fb.User? firebaseUser = userCredential.user;

      if (firebaseUser == null) return null;

      final isar = await _isarService.db;
      
      // Check if user exists by email or firebaseUid
      var user = await isar.users
          .filter()
          .emailEqualTo(firebaseUser.email)
          .or()
          .firebaseUidEqualTo(firebaseUser.uid)
          .findFirst();

      if (user == null) {
        // Create new local user
        user = User()
          ..username = firebaseUser.displayName ?? firebaseUser.email?.split('@')[0] ?? 'User'
          ..email = firebaseUser.email
          ..firebaseUid = firebaseUser.uid
          ..passwordHash = '' // No password for Google users
          ..createdAt = DateTime.now();

        await isar.writeTxn(() async {
          await isar.users.put(user!);
        });
      } else {
        // Update existing user with firebase info if missing
        if (user.firebaseUid == null || user.email == null) {
          user.firebaseUid = firebaseUser.uid;
          user.email = firebaseUser.email;
          await isar.writeTxn(() async {
            await isar.users.put(user!);
          });
        }
      }

      await _saveSession(user.id);

      return UserEntity(
        id: user.id,
        username: user.username,
        email: user.email,
        firebaseUid: user.firebaseUid,
        initialBalance: user.initialBalance,
        createdAt: user.createdAt,
      );
    } catch (e) {
      print('Error Google Sign-In: $e');
      return null;
    }
  }

  @override
  Future<UserEntity> updateInitialBalance(int userId, double balance) async {
    final isar = await _isarService.db;
    final user = await isar.users.get(userId);
    if (user == null) throw Exception('User not found');

    user.initialBalance = balance;
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });

    return UserEntity(
      id: user.id,
      username: user.username,
      email: user.email,
      firebaseUid: user.firebaseUid,
      initialBalance: user.initialBalance,
      createdAt: user.createdAt,
    );
  }

  @override
  Future<UserEntity> register(String username, String password) async {
    final isar = await _isarService.db;

    final existingUser = await isar.users
        .filter()
        .usernameEqualTo(username)
        .findFirst();
    if (existingUser != null) {
      throw Exception('Username already exists');
    }

    final hashedPassword = HashUtil.hashPassword(password);
    final newUser = User()
      ..username = username
      ..passwordHash = hashedPassword
      ..createdAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.users.put(newUser);
    });

    await _saveSession(newUser.id);

    return UserEntity(
      id: newUser.id,
      username: newUser.username,
      email: newUser.email,
      firebaseUid: newUser.firebaseUid,
      initialBalance: newUser.initialBalance,
      createdAt: newUser.createdAt,
    );
  }

  @override
  Future<UserEntity> updateProfile(int userId, String newUsername) async {
    final isar = await _isarService.db;
    final user = await isar.users.get(userId);
    if (user == null) throw Exception('User not found');

    if (user.username != newUsername) {
      final existingUser = await isar.users
          .filter()
          .usernameEqualTo(newUsername)
          .findFirst();
      if (existingUser != null) {
        throw Exception('Username already exists');
      }
    }

    user.username = newUsername;
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });

    return UserEntity(
      id: user.id,
      username: user.username,
      email: user.email,
      firebaseUid: user.firebaseUid,
      initialBalance: user.initialBalance,
      createdAt: user.createdAt,
    );
  }

  @override
  Future<void> changePassword(
    int userId,
    String currentPassword,
    String newPassword,
  ) async {
    final isar = await _isarService.db;
    final user = await isar.users.get(userId);
    if (user == null) throw Exception('User not found');

    if (user.passwordHash != HashUtil.hashPassword(currentPassword)) {
      throw Exception('Current password is incorrect');
    }

    user.passwordHash = HashUtil.hashPassword(newPassword);
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final isar = await _isarService.db;
    final session = await isar.sessions.get(1);

    if (session != null && session.currentUserId != null) {
      final user = await isar.users.get(session.currentUserId!);
      if (user != null) {
        return UserEntity(
          id: user.id,
          username: user.username,
          email: user.email,
          firebaseUid: user.firebaseUid,
          initialBalance: user.initialBalance,
          createdAt: user.createdAt,
        );
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final session = await isar.sessions.get(1);
      if (session != null) {
        session.currentUserId = null;
        await isar.sessions.put(session);
      }
    });
    // Also logout from Firebase
    await fb.FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> _saveSession(int userId) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      var session = await isar.sessions.get(1);
      session ??= Session()..id = 1;
      session.currentUserId = userId;
      await isar.sessions.put(session);
    });
  }
}
