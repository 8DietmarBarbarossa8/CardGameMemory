import 'package:card_memory_game/managers/game_manager.dart';
import 'package:card_memory_game/models/word.dart';
import 'package:card_memory_game/screen/error_page.dart';
import 'package:card_memory_game/screen/loading_page.dart';
import 'package:card_memory_game/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screen/game_page.dart';

List<Word> sourceWords = [];

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    FutureBuilder(
      future: populateSourceWords(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return const ErrorPage(title: 'Check your internet connection');
        }

        return snapshot.hasData
            ? (sourceWords.length > 4
                ? const MyApp()
                : const ErrorPage(
                    title: 'There are too little words! Check your restore!',
                  ))
            : const LoadingPage();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory Game',
      theme: appTheme,
      home: Material(
        child: ChangeNotifierProvider(
          create: (_) => GameManager(),
          child: const GamePage(),
        ),
      ),
    );
  }
}

Future<int> populateSourceWords() async {
  final ref = FirebaseStorage.instance.ref();
  final all = await ref.listAll();

  for (var item in all.items) {
    sourceWords.add(
      Word(
        text: item.name.substring(0, item.name.indexOf('.')),
        url: await item.getDownloadURL(),
        displayText: false,
      ),
    );
  }

  return 1;
}
