class UserEntity {
  final int id;
  final String username;
  final String? email;
  final String? firebaseUid;
  final double initialBalance;
  final DateTime createdAt;

  UserEntity({
    required this.id,
    required this.username,
    this.email,
    this.firebaseUid,
    this.initialBalance = 0.0,
    required this.createdAt,
  });
}
