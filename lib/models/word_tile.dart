import 'dart:math';

import 'package:card_memory_game/animation/flip_animation.dart';
import 'package:card_memory_game/models/word.dart';
import 'package:flutter/material.dart';

class WordTile extends StatelessWidget {
  const WordTile({Key? key, required this.index, required this.word})
      : super(key: key);

  final int index;
  final Word word;

  @override
  Widget build(BuildContext context) {
    return FlipAnimation(
      animationCompleted: (completed) {},
      animate: false,
      reverse: false,
      word: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.deepPurple,
        child: !word.displayText
            ? Image.network(word.url)
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Transform(
                    transform: Matrix4.rotationY(pi),
                    alignment: Alignment.center,
                    child: Text(word.text))),
      ),
    );
  }
}
