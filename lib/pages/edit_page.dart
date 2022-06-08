import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:proto/boards_service.dart';
import 'package:proto/models/board_model.dart';

class EditPage extends StatelessWidget {
  static const String path = "edit";

  final _boardsService = GetIt.I.get<BoardsService>();

  final List<TextEditingController> _controllers = [];
  final TextEditingController _nameController = TextEditingController();

  BoardModel _board = BoardModel(
    name: "",
    numbers: [
      null, null, null, null, null,
      null, null, null, null, null,
      null, null, null, null, null,
      null, null, null, null, null,
      null, null, null, null, null,
    ]
  ); 

  bool editing = false;

  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)!.settings.arguments != null) {
      _board = ModalRoute.of(context)!.settings.arguments as BoardModel;
      editing = true;
    }
    _nameController.text = _board.name;

    return Scaffold(
      appBar: AppBar(
        title: (editing)
          ? Text(_board.name)
          : TextField(
            controller: _nameController,
            style: const TextStyle(
              color: Colors.white
            ),
            cursorColor: Colors.white,
            onChanged: (String newValue) {
              _board.name = newValue;
            },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_rounded),
        onPressed: () {
          if(_board.name.isNotEmpty) {
            if(editing) {
              _boardsService.updateBoard(_board);
            } else {
              _boardsService.addBoard(_board);
            }
            Navigator.of(context).pop();
          }
        },
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            final currentFocus = FocusScope.of(context);
            if(currentFocus.hasPrimaryFocus == false) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.transparent,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
                maxWidth: 300
              ),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                ),
                itemCount: _board.numbers.length,
                itemBuilder: (context, index) {
                  if(index > _controllers.length - 1) {
                    _controllers.add(TextEditingController());
                  }
                
                  _controllers[index].text = _board.numbers[index]?.toString() ?? "";
                
                  return Container(
                    width: 10,
                    height: 10,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 1)
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (String newValue) {
                        if(newValue.isEmpty) {
                          _board.numbers[index] = null;
                        }
                
                        final n = int.tryParse(newValue);
                        _board.numbers[index] = n;
                      },
                    )
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
