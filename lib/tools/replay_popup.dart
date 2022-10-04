import 'dart:math';

import 'package:card_memory_game/animations/spin_animation.dart';
import 'package:card_memory_game/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'exit_dialog.dart';

const messages = ['Awesome!', 'Fantastic!', 'Nice!', 'Great!'];
const smiles = ['😲', '🤩', '😮', '😯'];

class ReplayPopUp extends StatelessWidget {
  const ReplayPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int random = _getRandom(messages.length);
    String message = messages[random];
    random = _getRandom(smiles.length);
    String emoji = smiles[random];

    return WillPopScope(
      onWillPop: ExitDialog(context).onWillPop,
      child: SpinAnimation(
        child: AlertDialog(
          title: Text(
            message,
            textAlign: TextAlign.center,
          ),
          content: Text(
            emoji,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 60),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => _replay(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Replay'),
                    )))
          ],
        ),
      ),
    );
  }

  int _getRandom(int size) => Random().nextInt(size);

  void _replay(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => const MyApp()),
        (route) => false);
  }
}
