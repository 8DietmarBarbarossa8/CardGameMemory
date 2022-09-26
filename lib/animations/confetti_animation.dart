import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiAnimation extends StatefulWidget {
  final bool animate;

  const ConfettiAnimation({Key? key, required this.animate}) : super(key: key);

  @override
  State<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation> {
  final _controller = ConfettiController(
    duration: const Duration(milliseconds: 1500)
  );

  @override
  void didUpdateWidget(covariant ConfettiAnimation oldWidget) {
    if (widget.animate) {
      _controller.play();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1.5),
      child: ConfettiWidget(
        minimumSize: const Size(10, 100),
        maximumSize: const Size(30, 100),
        numberOfParticles: 60,
        blastDirectionality: BlastDirectionality.explosive,
        gravity: 0.5,
        confettiController: _controller,
      ),
    );
  }
}
