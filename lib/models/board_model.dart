import 'package:hive_flutter/hive_flutter.dart';

part 'board_model.g.dart';

@HiveType(typeId: 0)
class BoardModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  final List<int?> numbers;

  BoardModel({
    required this.name,
    required this.numbers
  });
}