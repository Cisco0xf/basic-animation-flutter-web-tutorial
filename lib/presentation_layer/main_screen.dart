import 'package:basic_web_animation/commons/gaps.dart';
import 'package:basic_web_animation/constants/texts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:basic_web_animation/commons/screen_dimensions.dart';
import 'package:basic_web_animation/constants/colors.dart';
import 'package:basic_web_animation/presentation_layer/animated_side_bar/side_bar_manager.dart';
import 'package:basic_web_animation/presentation_layer/animated_side_bar/side_bar_item.dart';
import 'package:basic_web_animation/presentation_layer/animated_side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ValidLayout extends StatelessWidget {
  const ValidLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // log("Screen Width => ${context.screenWidth}");
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!context.showTarget || !kIsWeb) {
          return const NotValid();
        }

        return const MainScreen();
      },
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentNav = ref.watch(sideBarNavProvider);
    return Scaffold(
      body: Row(
        children: <Widget>[
          const AnimatedSideBar(),
          Expanded(child: sideItems[currentNav].target),
        ],
      ),
    );
  }
}

class NotValid extends StatelessWidget {
  const NotValid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gap(height: 30),
            Icon(
              Icons.monitor,
              size: 190,
              color: AppColors.primary,
            ),
            Gap(height: 20),
            Text(
              unValid,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
