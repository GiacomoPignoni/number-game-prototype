import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proto/models/board_model.dart';

class BoardsService {
  static const boardsBoxName = "boardsBox";

  final Box _boardsBox = Hive.box(boardsBoxName);

  late final ValueNotifier<BoardModel> _selectedBoard;
  ValueNotifier<BoardModel> get selectedBoard => _selectedBoard;

  BoardsService() {
    if(_boardsBox.isEmpty) {
      _boardsBox.put(
        "Main", 
        BoardModel(
          name: "Main", 
          numbers: [
            null, null, null, null, null,
            null, 2, null, null, 5,
            null, 1, null, null, null,
            null, null, null, null, null,
            null, 3, null, null, 3
          ]
        )
      );
    }

    _selectedBoard = ValueNotifier(_boardsBox.get("Main"));
  }

  void put(BoardModel board) {
    _boardsBox.put(
      board.name,
      board
    );
    _selectedBoard.value = board;
  }

  List<String> getBoardsList() {
    return _boardsBox.keys.map((e) => e.toString()).toList();
  }

  void selectBoard(String name) {
    _selectedBoard.value = _boardsBox.get(name);
  }
}