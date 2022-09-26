import 'dart:math';

import 'package:card_memory_game/animations/matched_animation.dart';
import 'package:card_memory_game/animations/spin_animation.dart';
import 'package:card_memory_game/models/word.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../animations/flip_animation.dart';
import '../managers/game_manager.dart';

class WordTile extends StatelessWidget {
  const WordTile({Key? key, required this.index, required this.word})
      : super(key: key);

  final int index;
  final Word word;

  @override
  Widget build(BuildContext context) {
    return SpinAnimation(
      child: Consumer<GameManager>(
        builder: ((_, notifier, __) {
          bool animate = checkAnimationRun(notifier);
    
          return GestureDetector(
            onTap: (() {
              if (!notifier.ignoredTaps &&
                  !notifier.answeredWords.contains(index) &&
                  !notifier.tappedWords.containsKey(index)) {
                notifier.titleTapped(index: index, word: word);
              }
            }),
            child: FlipAnimation(
              delay: notifier.reverseFlip ? 1500 : 0,
              animationCompleted: (completed) {
                notifier.onAnimationCompleted(isForward: completed);
              },
              animate: animate,
              reverse: notifier.reverseFlip,
              word: MatchedAnimation(
                animate: notifier.answeredWords.contains(index),
                numberOfWordsAnswered: notifier.answeredWords.length,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: !word.displayText
                      ? Image.network(word.url)
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Transform(
                              transform: Matrix4.rotationY(pi),
                              alignment: Alignment.center,
                              child: Text(word.text))),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  bool checkAnimationRun(GameManager notifier) {
    bool animate = false;

    if (notifier.canFlip) {
      if (notifier.tappedWords.isNotEmpty &&
          notifier.tappedWords.keys.last == index) {
        animate = true;
      }
      if (notifier.reverseFlip && !notifier.answeredWords.contains(index)) {
        animate = true;
      }
    }
    return animate;
  }
}
