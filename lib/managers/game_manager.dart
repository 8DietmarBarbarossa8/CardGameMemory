import 'package:card_memory_game/managers/audio_manager.dart';
import 'package:card_memory_game/models/word.dart';
import 'package:flutter/material.dart';

class GameManager extends ChangeNotifier {
  Map<int, Word> tappedWords = {};
  bool canFlip = false,
      reverseFlip = false,
      ignoredTaps = false,
      roundCompleted = false;
  List<int> answeredWords = [];

  titleTapped({required int index, required Word word}) {
    ignoredTaps = true;
    if (tappedWords.length <= 1) {
      tappedWords.addEntries([MapEntry(index, word)]);
      canFlip = true;
    } else {
      canFlip = false;
    }

    notifyListeners();
  }

  onAnimationCompleted({required bool isForward}) async {
    if (tappedWords.length == 2) {
      if (isForward) {
        if (tappedWords.entries.elementAt(0).value.text ==
            tappedWords.entries.elementAt(1).value.text) {
          answeredWords.addAll(tappedWords.keys);
          if (answeredWords.length == 8) {
            await AudioManager.playAudio('round');
            roundCompleted = true;
          } else {
            await AudioManager.playAudio('correct');
          }
          tappedWords.clear();
          canFlip = true;
          ignoredTaps = false;
        } else {
          await AudioManager.playAudio('incorrect');
          reverseFlip = true;
        }
      } else {
        reverseFlip = false;
        tappedWords.clear();
        ignoredTaps = false;
      }
    } else {
      canFlip = false;
      ignoredTaps = false;
    }

    notifyListeners();
  }
}
