import 'package:basic_web_animation/commons/navigator_key.dart';
import 'package:basic_web_animation/constants/colors.dart';
import 'package:basic_web_animation/presentation_layer/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: AppRoot()));
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ValidLayout(),
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
