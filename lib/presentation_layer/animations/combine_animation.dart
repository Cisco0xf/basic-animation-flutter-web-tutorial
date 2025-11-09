import 'package:basic_web_animation/commons/screen_dimensions.dart';
import 'package:flutter/material.dart';

class CombineAnimation extends StatelessWidget {
  const CombineAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedPositioned(
              right: (context.screenWidth * .2) * value,
              top: 0.0,
              bottom: 0.0,
              duration: const Duration(milliseconds: 500),
              child: AnimatedCombineWidget(value: value),
            ),
            AnimatedPositioned(
              left: (context.screenWidth * .2) * value,
              top: 0.0,
              bottom: 0.0,
              duration: const Duration(milliseconds: 500),
              child: AnimatedCombineWidget(value: value),
            ),
            AnimatedPositioned(
              left: 0.0,
              right: 0.0,
              bottom: (context.screenHeight * .1) * value,
              duration: const Duration(milliseconds: 500),
              child: AnimatedCombineWidget(value: value),
            ),
            AnimatedPositioned(
              left: 0.0,
              right: 0.0,
              top: (context.screenHeight * .1) * value,
              duration: const Duration(milliseconds: 500),
              child: AnimatedCombineWidget(value: value),
            ),
          ],
        );
      },
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0.0, end: 1.0),
    );
  }
}

class AnimatedCombineWidget extends StatelessWidget {
  const AnimatedCombineWidget({
    super.key,
    required this.value,
  });
  final double value;

  double get _animation => 0.5 + (0.5 * value);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation,
      child: AnimatedOpacity(
        opacity: _animation,
        duration: const Duration(milliseconds: 500),
        child: const FlutterLogo(size: 150.0),
      ),
    );
  }
}
