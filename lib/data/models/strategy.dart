import 'package:isar/isar.dart';

part 'strategy.g.dart';

@collection
class Strategy {
  Id id = Isar.autoIncrement;

  @Index()
  late int userId;

  late String name;
  String? description;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
    };
  }

  static Strategy fromMap(Map<String, dynamic> map) {
    return Strategy()
      ..id = map['id'] ?? Isar.autoIncrement
      ..userId = map['userId']
      ..name = map['name']
      ..description = map['description'];
  }
}
