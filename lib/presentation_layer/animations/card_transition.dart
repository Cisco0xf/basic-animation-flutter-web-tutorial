import 'package:basic_web_animation/commons/commons.dart';
import 'package:basic_web_animation/commons/gaps.dart';
import 'package:basic_web_animation/commons/screen_dimensions.dart';
import 'package:basic_web_animation/constants/colors.dart';
import 'package:basic_web_animation/constants/texts.dart';
import 'package:basic_web_animation/presentation_layer/animated_side_bar/side_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeveloperData {
  final String targetUrl;
  final String label;
  final Color color;
  final IconData icon;

  const DeveloperData({
    required this.color,
    required this.icon,
    required this.label,
    required this.targetUrl,
  });
}

const List<DeveloperData> devData = [
  DeveloperData(
    color: Colors.grey,
    icon: FontAwesomeIcons.github,
    label: "GitHub",
    targetUrl: "https://github.com/Cisco0xf",
  ),
  DeveloperData(
    color: Colors.blue,
    icon: FontAwesomeIcons.linkedinIn,
    label: "LinkedIn",
    targetUrl: "http://www.linkedin.com/in/mahmoud-al-shehyby",
  ),
  DeveloperData(
    color: Colors.green,
    icon: FontAwesomeIcons.whatsapp,
    label: "WhatsApp",
    targetUrl: "http://wa.me/+201207269113",
  ),
  DeveloperData(
    color: Colors.red,
    icon: Icons.email,
    label: "Gmail",
    targetUrl: "NULL",
  ),
  DeveloperData(
    color: Colors.amber,
    icon: FontAwesomeIcons.stackOverflow,
    label: "StackOverflow",
    targetUrl:
        "https://stackoverflow.com/users/23598383/mahmoud-al-shehyby?tab=summary",
  ),
];

class WidgetTransetion extends StatelessWidget {
  const WidgetTransetion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(clickable, style: Styles.titleStyle()),
        const Gap(height: 50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(
            devData.length,
            (index) {
              return AnimatedCard(
                devItem: devData[index],
                onClick: () async {
                  if (devData[index].label == "GitHub") {
                    await OpenUrl.launchWebUrl(
                      target: devData[index].targetUrl,
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class AnimatedCard extends StatefulWidget {
  const AnimatedCard({
    super.key,
    required this.devItem,
    required this.onClick,
  });

  final DeveloperData devItem;
  final void Function() onClick;

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
    super.initState();
  }

  bool _active = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _active = true),
      onExit: (_) => setState(() => _active = false),
      child: ScaleTransition(
        scale: _animation,
        child: SizedBox.square(
          dimension: context.screenHeight * .18,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: borderRadius(_active ? 25.0 : 15.0),
              border: Border.all(
                color: _active ? widget.devItem.color : AppColors.borderColor,
              ),
              color: AppColors.bgColor,
              boxShadow: _active
                  ? [
                      const BoxShadow(
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(4, 4),
                        color: Colors.transparent,
                      ),
                      BoxShadow(
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: const Offset(4, 4),
                        color: widget.devItem.color.withOpacity(0.4),
                      ),
                    ]
                  : null,
            ),
            child: Clicker(
              onClick: () async {
                await _controller.forward();
                await _controller.reverse();

                widget.onClick.call();
              },
              radius: 25.0,
              innerPadding: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(widget.devItem.icon),
                  const Gap(height: 10.0),
                  Text(widget.devItem.label),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
