import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SpinAnimation extends StatefulWidget {
  final Widget child;

  const SpinAnimation({Key? key, required this.child}) : super(key: key);

  @override
  State<SpinAnimation> createState() => _SpinAnimationState();
}

class _SpinAnimationState extends State<SpinAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    Duration duration = const Duration(milliseconds: 600);
    _animationController = AnimationController(
      duration: duration,
      vsync: this,
    );
    Future.delayed(duration, () {
      if (mounted && !_animationController.isAnimating) {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceInOut,
      ),
      child: RotationTransition(
        turns: CurvedAnimation(
          parent: _animationController,
          curve: Curves.bounceInOut,
        ),
        child: widget.child,
      ),
    );
  }
}
