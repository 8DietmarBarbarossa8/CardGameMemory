import 'package:flutter/material.dart';

class WordTile extends StatelessWidget {
  const WordTile({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Text(index.toString()),
    );
  }
}