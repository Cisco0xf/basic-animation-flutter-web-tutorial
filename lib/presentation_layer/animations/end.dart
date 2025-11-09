import 'package:basic_web_animation/commons/gaps.dart';
import 'package:basic_web_animation/commons/screen_dimensions.dart';
import 'package:basic_web_animation/constants/texts.dart';
import 'package:basic_web_animation/presentation_layer/animated_side_bar/side_bar_manager.dart';
import 'package:basic_web_animation/presentation_layer/animations/card_transition.dart';
import 'package:basic_web_animation/presentation_layer/animations/text_shadow.dart';
import 'package:flutter/material.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Gap(height: 50.0),
        const ShadowText(
          shadowColor: Colors.blue,
          fontSize: 25.0,
          label: endText,
          textAlign: TextAlign.center,
        ),
        const Gap(height: 50.0),
        TweenAnimationBuilder(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(
                devData.length,
                (index) {
                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: value,
                      child: AnimatedCard(
                        devItem: devData[index],
                        onClick: () async {
                          await OpenUrl.launchWebUrl(
                            target: devData[index].targetUrl,
                            isEmail: devData[index].targetUrl == "NULL",
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
          duration: const Duration(milliseconds: 300),
          tween: Tween(end: 1.0, begin: 0.3),
        ),
        const Expanded(child: SizedBox()),
        SizedBox(
          width: context.screenWidth * .6,
          child: const Divider(thickness: 2.0),
        ),
        const Footer(),
        const Gap(height: 20),
      ],
    );
  }
}

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool animate = false;

  List<Shadow>? copyRightShadow({Color color = Colors.green}) {
    if (animate) {
      return List.generate(
        4,
        (index) {
          return Shadow(
            color: color,
            blurRadius: index * 3,
          );
        },
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          animate = true;
        });
      },
      onExit: (_) {
        setState(() {
          animate = false;
        });
      },
      child: Transform.scale(
        scale: animate ? 1.1 : 1.0,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              const Text(
                copyRight,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const Gap(height: 10.0),
              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: devWith,
                      style: TextStyle(
                        shadows: copyRightShadow(),
                      ),
                    ),
                    TextSpan(
                      text: "Flutter ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        shadows: copyRightShadow(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: made,
                      style: TextStyle(
                        shadows: copyRightShadow(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
