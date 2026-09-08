import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String username;

  late String passwordHash;

  String? email;
  String? firebaseUid;

  double initialBalance = 0.0;
  
  late DateTime createdAt;
}
