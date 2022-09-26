import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Text(
        'Error :(\n Check your internet connection',
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      ),
    );
  }
}
