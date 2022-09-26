import 'dart:math';

import 'package:card_memory_game/main.dart';
import 'package:flutter/material.dart';

const messages = ['Awesome!', 'Fantastic!', 'Nice!', 'Great!'];

class ReplayPopUp extends StatelessWidget {
  const ReplayPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Random().nextInt(messages.length);
    String message = messages[r];
    return AlertDialog(
      title: Text(
        message,
        textAlign: TextAlign.center,
      ),
      content: const Text(
        '😲',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 60),
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
    );
  }

  void _replay(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => const MyApp()),
        (route) => false);
  }
}
