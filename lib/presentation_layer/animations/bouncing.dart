import 'package:basic_web_animation/commons/commons.dart';
import 'package:basic_web_animation/commons/gaps.dart';
import 'package:basic_web_animation/commons/screen_dimensions.dart';
import 'package:basic_web_animation/constants/colors.dart';
import 'package:basic_web_animation/constants/paths.dart';
import 'package:basic_web_animation/constants/texts.dart';
import 'package:flutter/material.dart';

class BouncingAnimation extends StatelessWidget {
  const BouncingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Bouncing(),
        Bouncing2(),
        
      ],
    );
  }
}

class Bouncing extends StatefulWidget {
  const Bouncing({super.key});

  @override
  State<Bouncing> createState() => _BouncingState();
}

class _BouncingState extends State<Bouncing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _animation = Tween<double>(begin: 0.9, end: 1.0).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(knooz, style: Styles.titleStyle()),
        const Gap(height: 20),
        ScaleTransition(
          scale: _animation,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: context.screenHeight * .6,
                width: context.screenWidth * .23,
                child: Image.network(Assets.darkHome),
              ),
              SizedBox(
                height: context.screenHeight * .6,
                width: context.screenWidth * .23,
                child: Image.network(Assets.darkQuran),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Bouncing2 extends StatefulWidget {
  const Bouncing2({super.key});

  @override
  State<Bouncing2> createState() => _Bouncing2State();
}

class _Bouncing2State extends State<Bouncing2>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _animation = Tween<double>(begin: 0.0, end: 50).animate(_controller);

    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(knooz, style: Styles.titleStyle()),
        const Gap(height: 100),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -_animation.value),
              child: const FlutterLogo(size: 300.0),
            );
          },
        ),
        Container(
          width: 100 * (_animation.value / 50),
          height: 10,
          decoration: BoxDecoration(
            borderRadius: borderRadius(10),
            color: AppColors.accent,
          ),
        )
      ],
    );
  }
}
