import 'package:basic_web_animation/presentation_layer/animations/bouncing.dart';
import 'package:basic_web_animation/presentation_layer/animations/combine_animation.dart';
import 'package:basic_web_animation/presentation_layer/animations/end.dart';
import 'package:basic_web_animation/presentation_layer/animations/mous_tracking.dart';
import 'package:basic_web_animation/presentation_layer/animations/scroll_to_section.dart';
import 'package:basic_web_animation/presentation_layer/animations/shadow_tracking.dart';
import 'package:basic_web_animation/presentation_layer/animations/text_shadow.dart';
import 'package:basic_web_animation/presentation_layer/animations/card_transition.dart';
import 'package:flutter/material.dart';

class SideBarModel {
  final String title;
  final Widget target;
  final Widget icon;

  const SideBarModel({
    required this.icon,
    required this.target,
    required this.title,
  });
}

const List<SideBarModel> sideItems = [
  SideBarModel(
    icon: Icon(Icons.ads_click_rounded),
    target: MouseTracking(),
    title: "Mouse Track",
  ),
  SideBarModel(
    icon: Icon(Icons.text_fields_rounded),
    target: AnimatedTextShadow(),
    title: "Text Shadow",
  ),
  SideBarModel(
    icon: Icon(Icons.amp_stories_rounded),
    target: BouncingAnimation(),
    title: "Bouncing",
  ),
  SideBarModel(
    icon: Icon(Icons.motion_photos_auto_rounded),
    target: WidgetTransetion(),
    title: "Scale Click",
  ),
  SideBarModel(
    icon: Icon(Icons.shape_line_outlined),
    target: ShadowTracker(),
    title: "Shadow Track",
  ),
  SideBarModel(
    icon: Icon(Icons.all_inbox_outlined),
    target: CombineAnimation(),
    title: "Directions",
  ),
  SideBarModel(
    icon: Icon(Icons.screenshot_monitor),
    target: ScrollToSection(),
    title: "Scrollable",
  ),
  SideBarModel(
    icon: Icon(Icons.stacked_bar_chart),
    target: EndScreen(),
    title: "Create Yours",
  ),
];
