import 'package:basic_web_animation/commons/commons.dart';
import 'package:basic_web_animation/commons/gaps.dart';
import 'package:basic_web_animation/constants/texts.dart';
import 'package:flutter/material.dart';

class AnimatedTextShadow extends StatelessWidget {
  const AnimatedTextShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Styles.titleStyle()),
          const Gap(height: 20.0),
          const ShadowText(shadowColor: Colors.red, label: text1),
          const Gap(height: 20.0),
          const ShadowText(shadowColor: Colors.amber, label: text2),
          const Gap(height: 20.0),
          const ShadowText(shadowColor: Colors.green, label: text3),
        ],
      ),
    );
  }
}

class ShadowText extends StatefulWidget {
  const ShadowText({
    super.key,
    required this.shadowColor,
    required this.label,
    this.fontSize = 21,
    this.textAlign,
  });

  final Color shadowColor;
  final String label;
  final double fontSize;
  final TextAlign? textAlign;

  @override
  State<ShadowText> createState() => _ShadowTextState();
}

class _ShadowTextState extends State<ShadowText> {
  bool _active = false;

  List<Shadow> get _shadows => [
        for (int i = 0; i < 4; i++) ...{
          Shadow(
            blurRadius: i * 3,
            color: widget.shadowColor.withOpacity(0.8),
          ),
        }
      ];
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _active = true),
      onExit: (_) => setState(() => _active = false),
      child: Text(
        "${widget.label}\n",
        textAlign: widget.textAlign,
        style: TextStyle(
          fontSize: widget.fontSize,
          shadows: _active ? _shadows : null,
          fontWeight: _active ? FontWeight.bold : null,
        ),
      ),
    );
  }
}
