import 'package:flutter/material.dart';

extension AppDimensions on BuildContext {
  double get screenHeight {
    final double height = MediaQuery.sizeOf(this).height;

    return height;
  }

  double get screenWidth {
    final double width = MediaQuery.sizeOf(this).width;

    return width;
  }

  bool get isOpen => screenWidth >= 1200;

  bool get showTarget => screenWidth >= 900;
}
