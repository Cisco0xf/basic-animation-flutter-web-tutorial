import 'package:basic_web_animation/commons/screen_dimensions.dart';
import 'package:basic_web_animation/constants/colors.dart';
import 'package:flutter/material.dart';

class MouseTracking extends StatefulWidget {
  const MouseTracking({super.key});

  @override
  State<MouseTracking> createState() => _MouseTrackingState();
}

class _MouseTrackingState extends State<MouseTracking> {
  double topPosition = 0.0;
  double leftPositio = 0.0;

  double get _lightDiameter => context.screenHeight * .4;
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          topPosition = event.localPosition.dy;
          leftPositio = event.localPosition.dx;
        });
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            top: topPosition - (_lightDiameter / 2),
            left: leftPositio - (_lightDiameter / 2),
            child: SizedBox.square(
              dimension: _lightDiameter,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 100,
                      offset: const Offset(0, 0),
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: topPosition - 8.0,
            left: leftPositio - 8.0,
            child: SizedBox.square(
              dimension: 16,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
