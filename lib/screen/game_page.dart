import 'package:card_memory_game/managers/game_manager.dart';
import 'package:card_memory_game/models/word.dart';
import 'package:card_memory_game/main.dart';
import 'package:card_memory_game/screen/error_page.dart';
import 'package:card_memory_game/screen/loading_page.dart';
import 'package:card_memory_game/tools/replay_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/word_tile.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    _setUp();
    super.initState();
  }

  final List<Word> _gridWords = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthPadding = size.width * 0.1;
    return FutureBuilder(
        future: _cacheImages(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorPage();
          }
          if (snapshot.hasData) {
            return Selector<GameManager, bool>(
              selector: (_, gameManager) => gameManager.roundCompleted,
              builder: (_, roundCompleted, __) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (roundCompleted) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Colors.transparent,
                        builder: (context) => const ReplayPopUp());
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
                            itemCount: 6,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
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
                  ],
                );
              },
            );
          } else {
            return const LoadingPage();
          }
        });
  }

  _setUp() {
    sourceWords.shuffle();
    for (int i = 0; i < 3; i++) {
      _gridWords.add(sourceWords[i]);
      _gridWords.add(Word(
          text: sourceWords[i].text,
          url: sourceWords[i].url,
          displayText: true));
    }
  }

  Future<int> _cacheImages() async {
    for (var w in _gridWords) {
      final image = Image.network(w.url);
      await precacheImage(image.image, context);
    }

    return 1;
  }
}
