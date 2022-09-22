import 'package:flutter/material.dart';

class MatchedAnimation extends StatefulWidget {
  final Widget child;
  final bool animate;
  final int numberOfWordsAnswered;

  const MatchedAnimation(
      {required this.child,
      required this.animate,
      required this.numberOfWordsAnswered,
      Key? key})
      : super(key: key);

  @override
  State<MatchedAnimation> createState() => _MatchedAnimationState();
}

class _MatchedAnimationState extends State<MatchedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shake, _scale;

  final Color _defaultColor = Colors.blueAccent;
  Color _correctColor = Colors.green;
  bool _correctColorIsSet = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);

    double p1 = 0, p2 = .12, p3 = -.08, p4 = .04;
    _shake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: p1, end: p2), weight: 3),
      TweenSequenceItem(tween: Tween<double>(begin: p2, end: p3), weight: 5),
      TweenSequenceItem(tween: Tween<double>(begin: p3, end: p4), weight: 5),
      TweenSequenceItem(tween: Tween<double>(begin: p4, end: p1), weight: 6),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    p1 = 1;
    p2 = .9;
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: p1, end: p2), weight: 7),
      TweenSequenceItem(tween: Tween<double>(begin: p2, end: p1), weight: 3),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant MatchedAnimation oldWidget) {
    if (widget.animate) {
      if (!_correctColorIsSet) {
        if (widget.numberOfWordsAnswered == 4) {
          _correctColor = Colors.pink;
        }
        if (widget.numberOfWordsAnswered == 6) {
          _correctColor = Colors.amber;
        }
      }

      _correctColorIsSet = true;
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateZ(_shake.value)
          ..scale(_scale.value)
          ..setEntry(3, 2, 0.003),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: widget.animate ? _correctColor : _defaultColor,
            ),
            child: widget.child),
      ),
    );
  }
}
