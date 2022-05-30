import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    Key? key
  }) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late List<int?> _numbers;

  int? _selectedIndex;

  @override
  void initState() {
    _numbers = [...GetIt.I.get<List<int?>>()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 300
                ),
                child: GameGrid(
                  numbers: _numbers,
                  selectedIndex: _selectedIndex,
                  onCellPressed: _onCellPressed,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_upward_rounded),
              onPressed: _upPressed, 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: _leftPressed, 
                ),
                IconButton(
                  icon: const Icon(Icons.replay_outlined),
                  onPressed: _reset, 
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_rounded),
                  onPressed: _rightPressed, 
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.arrow_downward_rounded),
              onPressed: _downPressed, 
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit_rounded),
        onPressed: () async {
          await Navigator.of(context).pushNamed("edit");
          _reset();
        }
      ),
    );
  }

  _upPressed() {
    if(_selectedIndex == null) return;

    final indexsToCheck = [];
    for(int i = _selectedIndex! - 5; i >= 0; i -= 5) {
      indexsToCheck.add(i);
    }

    if(indexsToCheck.isEmpty) return;

    for(int i = 0; i < indexsToCheck.length; i++) {
      if(_numbers[indexsToCheck[i]] == null) continue;

      setState(() {
        _numbers[indexsToCheck[i]] = _numbers[indexsToCheck[i]]! + _numbers[_selectedIndex!]!;
        _numbers[_selectedIndex!] = null;
        _selectedIndex = indexsToCheck[i];
      });
      break;
    }
  }

  _rightPressed() {
    if(_selectedIndex == null) return;

    final indexsToCheck = [];
    for(int i = _selectedIndex! + 1; i % 5 != 0 && i < _numbers.length; i++) {
      indexsToCheck.add(i);
    }

    if(indexsToCheck.isEmpty) return;

    for(int i = 0; i < indexsToCheck.length; i++) {
      if(_numbers[indexsToCheck[i]] == null) continue;

      setState(() {
        _numbers[indexsToCheck[i]] = _numbers[indexsToCheck[i]]! + _numbers[_selectedIndex!]!;
        _numbers[_selectedIndex!] = null;
        _selectedIndex = indexsToCheck[i];
      });
      break;
    }
  }

  _downPressed() {
    if(_selectedIndex == null) return;

    final indexsToCheck = [];
    for(int i = _selectedIndex! + 5; i < _numbers.length; i += 5) {
      indexsToCheck.add(i);
    }

    if(indexsToCheck.isEmpty) return;

    for(int i = 0; i < indexsToCheck.length; i++) {
      if(_numbers[indexsToCheck[i]] == null) continue;

      setState(() {
        _numbers[indexsToCheck[i]] = _numbers[indexsToCheck[i]]! + _numbers[_selectedIndex!]!;
        _numbers[_selectedIndex!] = null;
        _selectedIndex = indexsToCheck[i];
      });
      break;
    }
  }

  _leftPressed() {
    if(_selectedIndex == null) return;

    final indexsToCheck = [];
    for(int i = _selectedIndex! - 1; (i % 5 != 0 || i == 0) && i >= 0; i--) {
      indexsToCheck.add(i);
    }

    if(indexsToCheck.isEmpty) return;

    for(int i = 0; i < indexsToCheck.length; i++) {
      if(_numbers[indexsToCheck[i]] == null) continue;

      setState(() {
        _numbers[indexsToCheck[i]] = _numbers[indexsToCheck[i]]! + _numbers[_selectedIndex!]!;
        _numbers[_selectedIndex!] = null;
        _selectedIndex = indexsToCheck[i];
      });
      break;
    }
  }

  _onCellPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _reset() {
    setState(() {
      _numbers = [...GetIt.I.get<List<int?>>()];
      _selectedIndex = null;
    });
  }
}

class GameGrid extends StatelessWidget {
  final List<int?> numbers;
  final int? selectedIndex;
  final Function(int index) onCellPressed;

  const GameGrid({
    required this.numbers,
    required this.selectedIndex,
    required this.onCellPressed,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1,
      ),
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onCellPressed(index),
          child: Container(
            width: 10,
            height: 10,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: _getBorder(index)
            ),
            child: Text(numbers[index]?.toString() ?? ""),
          ),
        );
      },
    );
  }

  Border _getBorder(int index) {
    if(selectedIndex == index) {
      return Border.all(color: Colors.red, width: 2);
    }

    return Border.all(color: Colors.black45, width: 1);
  }
}