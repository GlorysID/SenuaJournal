import 'package:isar/isar.dart';

part 'session.g.dart';

@collection
class Session {
  Id id = 1; // Singleton ID
  int? currentUserId;
}
