import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proto/boards_service.dart';
import 'package:proto/models/board_model.dart';
import 'package:proto/pages/edit_page.dart';
import 'package:proto/pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BoardModelAdapter());

  await Hive.openBox(BoardsService.boardsBoxName);

  GetIt.I.registerSingleton(BoardsService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(    
      initialRoute: HomePage.path,  
      routes: {
        HomePage.path: (_) => HomePage(),
        EditPage.path: (_) => EditPage()
      }
    );
  }
}
