import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation(
      {Key? key,
      required this.word,
      required this.animate,
      required this.reverse,
      required this.animationCompleted})
      : super(key: key);

  final Widget word;
  final bool animate;
  final bool reverse;
  final Function(int) animationCompleted;

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2600),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.animationCompleted.call(0);
        }
        if (status == AnimationStatus.dismissed) {
          widget.animationCompleted.call(1);
        }
      });
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    if (widget.animate && widget.reverse) {
      _controller.reverse();
    } else {
      _controller.reset();
      _controller.forward();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (BuildContext context, Widget? child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateY(_animation.value * pi)
          ..setEntry(3, 2, 0.005),
        child: _controller.value >= .5
            ? widget.word
            : const Icon(
                Icons.question_mark,
                size: 50,
                color: Colors.white,
              ),
      ),
      animation: _controller,
    );
  }
}
