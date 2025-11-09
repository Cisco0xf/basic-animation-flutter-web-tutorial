import 'package:basic_web_animation/constants/enums.dart';
import 'package:flutter/material.dart';

EdgeInsetsGeometry padding(double padding, {From from = From.both}) {
  switch (from) {
    case From.horizontal:
      {
        return EdgeInsets.symmetric(horizontal: padding);
      }
    case From.vertical:
      {
        return EdgeInsets.symmetric(vertical: padding);
      }
    case From.both:
      {
        return EdgeInsets.all(padding);
      }
  }
}

BorderRadius borderRadius(double radius, {RadiusSide side = RadiusSide.all}) {
  switch (side) {
    case RadiusSide.all:
      {
        return BorderRadius.circular(radius);
      }
    case RadiusSide.top:
      {
        return BorderRadius.vertical(top: Radius.circular(radius));
      }
    case RadiusSide.right:
      {
        return BorderRadius.horizontal(right: Radius.circular(radius));
      }
    case RadiusSide.left:
      {
        return BorderRadius.horizontal(left: Radius.circular(radius));
      }
    case RadiusSide.bottom:
      {
        return BorderRadius.vertical(bottom: Radius.circular(radius));
      }
  }
}

class Clicker extends StatelessWidget {
  const Clicker({
    super.key,
    required this.child,
    required this.onClick,
    this.innerPadding = 5.0,
    this.isCirclar = false,
    this.radius = 10.0,
  });

  final void Function() onClick;
  final double innerPadding;
  final bool isCirclar;
  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        borderRadius: isCirclar ? null : borderRadius(radius),
        customBorder: isCirclar ? const CircleBorder() : null,
        child: Padding(
          padding: padding(innerPadding),
          child: child,
        ),
      ),
    );
  }
}
