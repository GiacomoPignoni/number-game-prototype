import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class BoardEdit extends StatefulWidget {
  const BoardEdit({Key? key}) : super(key: key);

  @override
  State<BoardEdit> createState() => _BoardEditState();
}

class _BoardEditState extends State<BoardEdit> {
  final List<TextEditingController> _controllers = [];

  late List<int?> _numbers;

  @override
  void initState() {
    _numbers = GetIt.I.get<List<int?>>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
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
              itemCount: _numbers.length,
              itemBuilder: (context, index) {
                if(index > _controllers.length - 1) {
                  _controllers.add(TextEditingController());
                }

                _controllers[index].text = _numbers[index]?.toString() ?? "";

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
                        _numbers[index] = null;
                      }

                      final n = int.tryParse(newValue);
                      _numbers[index] = n;
                    },
                  )
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
