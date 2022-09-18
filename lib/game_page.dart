import 'package:card_memory_game/word_tile.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthPadding = size.width * 0.1;
    return SafeArea(
      child: Center(
        child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: widthPadding, right: widthPadding),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: size.height * 0.38,
            ),
            itemBuilder: (context, index) => WordTile(
                  index: index,
                )),
      ),
    );
  }
}
