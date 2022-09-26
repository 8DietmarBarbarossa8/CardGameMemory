import 'package:card_memory_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Center(
        child: Text(
          'Error :(\n Check your internet connection',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}
