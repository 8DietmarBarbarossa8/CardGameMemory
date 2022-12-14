import 'package:card_memory_game/animations/confetti_animation.dart';
import 'package:card_memory_game/managers/game_manager.dart';
import 'package:card_memory_game/models/word.dart';
import 'package:card_memory_game/main.dart';
import 'package:card_memory_game/screen/error_page.dart';
import 'package:card_memory_game/screen/loading_page.dart';
import 'package:card_memory_game/tools/exit_dialog.dart';
import 'package:card_memory_game/tools/replay_popup.dart';
import 'package:card_memory_game/models/word_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _isFinishedGame = false;

  @override
  void initState() {
    _setUp();
    super.initState();
  }

  final List<Word> _gridWords = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthPadding = size.width * 0.05;
    return WillPopScope(
      onWillPop: ExitDialog(context).onWillPop,
      child: FutureBuilder(
          future: _cacheImages(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ErrorPage(title: 'Check your internet connection');
            }
            if (snapshot.hasData) {
              return Selector<GameManager, bool>(
                selector: (_, gameManager) => gameManager.roundCompleted,
                builder: (_, roundCompleted, __) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    if (roundCompleted && !_isFinishedGame) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Colors.transparent,
                        builder: (context) => const ReplayPopUp(),
                      );
                      _isFinishedGame = true;
                    }
                  });

                  return Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/cloud.jpg')),
                        ),
                      ),
                      SafeArea(
                        child: Center(
                          child: GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                  left: widthPadding, right: widthPadding),
                              itemCount: 8,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: size.height * 0.38,
                              ),
                              itemBuilder: (context, index) => WordTile(
                                    index: index,
                                    word: _gridWords[index],
                                  )),
                        ),
                      ),
                      ConfettiAnimation(animate: roundCompleted)
                    ],
                  );
                },
              );
            } else {
              return const LoadingPage();
            }
          }),
    );
  }

  _setUp() {
    sourceWords.shuffle();
    Set<Word> uniqueWords = sourceWords.toSet();
    for (int i = 0; i < 4; i++) {
      Word word = uniqueWords.first;
      _gridWords.add(word);
      _gridWords.add(Word(text: word.text, url: word.url, displayText: true));
      uniqueWords.remove(word);
    }
    _gridWords.shuffle();
  }

  Future<int> _cacheImages() async {
    for (var w in _gridWords) {
      final image = Image.network(w.url);
      await precacheImage(image.image, context);
    }

    return 1;
  }
}
