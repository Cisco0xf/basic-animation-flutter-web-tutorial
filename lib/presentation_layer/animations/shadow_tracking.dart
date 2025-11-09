import 'package:basic_web_animation/commons/commons.dart';
import 'package:basic_web_animation/commons/gaps.dart';
import 'package:basic_web_animation/commons/screen_dimensions.dart';
import 'package:basic_web_animation/constants/colors.dart';
import 'package:basic_web_animation/constants/texts.dart';
import 'package:flutter/material.dart';

class ShadowTracker extends StatelessWidget {
  const ShadowTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(shadow, style: Styles.titleStyle()),
          const Gap(height: 100.0),
          const ShadowMouseTracking(),
        ],
      ),
    );
  }
}

class ShadowMouseTracking extends StatefulWidget {
  const ShadowMouseTracking({super.key});

  @override
  State<ShadowMouseTracking> createState() => _ShadowMouseTrackingState();
}

class _ShadowMouseTrackingState extends State<ShadowMouseTracking> {
  double get _dimensions => context.screenHeight * .5;

  double offsetX = 0.0;
  double offsetY = 0.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final Offset localePosition = event.localPosition;

        final double center = _dimensions / 2;

        setState(() {
          offsetX = (localePosition.dx - center) / 3;
          offsetY = (localePosition.dy - center) / 3;
        });
      },
      onExit: (event) {
        setState(() {
          offsetX = 0.0;
          offsetY = 0.0;
        });
      },
      child: SizedBox.square(
        dimension: _dimensions,
        child: AnimatedContainer(
          padding: padding(10.0),
          duration: const Duration(
            milliseconds: 300,
          ),
          decoration: BoxDecoration(
            borderRadius: borderRadius(20.0),
            color: AppColors.primary,
            border: Border.all(color: AppColors.borderColor),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.3),
                offset: Offset(offsetX, offsetY),
                blurRadius: 60,
                spreadRadius: 15.0,
              ),
            ],
          ),
          child: const FlutterLogo(size: 130),
        ),
      ),
    );
  }
}
