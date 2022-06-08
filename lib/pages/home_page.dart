import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:proto/boards_service.dart';
import 'package:proto/models/board_model.dart';
import 'package:proto/pages/edit_page.dart';
import 'package:proto/widgets/drawer.dart';
import 'package:proto/widgets/game_board.dart';

class HomePage extends StatelessWidget {
  static const String path = "home";

  final _boardsService = GetIt.I.get<BoardsService>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BoardModel>(
      valueListenable: _boardsService.selectedBoard,
      builder: (context, board, child)  {
        return Scaffold(
          appBar: AppBar(
            title: Text(board.name),
          ),
          drawer: MyDrawer(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.edit_rounded),
            onPressed: () async {
              await Navigator.of(context).pushNamed(
                EditPage.path,
                arguments: board
              );
              
            },
          ),
          body: SafeArea(
            child: GameBoard(
              numbers: board.numbers,
            )
          ),
        );
      }
    );
  }
}