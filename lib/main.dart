import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:proto/board_edit.dart';
import 'package:proto/game_board.dart';

void main() {
  GetIt.I.registerSingleton<List<int?>>([
    null, null, null, null, null,
    null, 2, null, null, 5,
    null, 1, null, null, null,
    null, null, null, null, null,
    null, 3, null, null, 3
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(    
      initialRoute: "game",  
      routes: {
        "game": (context) => const GameBoard(),
        "edit": (context) => const BoardEdit()
      }
    );
  }
}
