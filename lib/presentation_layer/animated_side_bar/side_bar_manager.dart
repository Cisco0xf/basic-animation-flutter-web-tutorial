import 'dart:developer';

import 'package:basic_web_animation/commons/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBarNavManager extends Notifier<int> {
  @override
  int build() => 0;

  void navigateTo(int nav) => state = nav;
}

class CheckNavState extends Notifier<bool> {
  @override
  bool build() => true;

  final BuildContext context = navigatorKey.currentContext as BuildContext;

  void changeState() => state = !state;
}

final sideBarNavProvider =
    NotifierProvider<SideBarNavManager, int>(SideBarNavManager.new);

final scrollableSectionProvider =
    NotifierProvider<SideBarNavManager, int>(SideBarNavManager.new);

final sideBarStateProvider =
    NotifierProvider<CheckNavState, bool>(CheckNavState.new);

class OpenUrl {
  static Future<void> launchWebUrl({
    required String target,
    bool isEmail = false,
  }) async {
    try {
      if (isEmail) {
        final Uri emailUri = Uri(
          path: "mahmoudalshehyby@gmail.com",
          scheme: "mailto",
        );

        final bool canLaunchEmail = await launchUrl(emailUri);

        if (!canLaunchEmail) {
          return;
        }

        await launchUrl(emailUri);

        return;
      }

      final Uri uri = Uri.parse(target);

      final bool canlaunch = await canLaunchUrl(uri);

      if (!canlaunch) {
        log("Can not Launch the target !!");
        return;
      }

      await launchUrl(uri);
    } catch (error) {
      log("Error while launching the target a=> $error");
    }
  }
}
