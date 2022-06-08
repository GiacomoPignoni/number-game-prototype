import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:proto/boards_service.dart';

class MyDrawer extends StatelessWidget {
  final _boardsService =  GetIt.I.get<BoardsService>();

  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardsList = _boardsService.getBoardsList();

    return Drawer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
              child: const Center(
                child: FlutterLogo(
                  size: 100,
                ),
              )
            )
          ),
          SliverToBoxAdapter(
            child: ListTile(
              title: const Text("New"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("edit");
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 25,
            )
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                boardsList.length, 
                (index) => ListTile(
                  title: Text(boardsList[index]),
                  selected: _boardsService.selectedBoard.value.name == boardsList[index],
                  onTap: () {
                    _boardsService.selectBoard(boardsList[index]);
                    Navigator.pop(context);
                  },
                )
              )
            )
          )
        ],
      ),
    );
  }
}