import 'dart:ui';

import 'package:basic_web_animation/commons/commons.dart';
import 'package:basic_web_animation/commons/gaps.dart';
import 'package:basic_web_animation/commons/screen_dimensions.dart';
import 'package:basic_web_animation/constants/colors.dart';
import 'package:basic_web_animation/constants/enums.dart';
import 'package:basic_web_animation/constants/texts.dart';
import 'package:basic_web_animation/presentation_layer/animated_side_bar/side_bar_manager.dart';
import 'package:basic_web_animation/presentation_layer/animations/text_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SectionModel {
  final IconData icon;
  final Color color;
  final String title;
  final GlobalKey scrollKey;
  final List<String> subTitle;

  SectionModel({
    required this.icon,
    required this.subTitle,
    required this.title,
    required this.color,
    required this.scrollKey,
  });
}

final List<SectionModel> sections = [
  SectionModel(
    icon: Icons.all_inclusive_rounded,
    color: Colors.red,
    scrollKey: GlobalKey(),
    subTitle: [
      "From the frozen Arctic to the dense rainforests, bears command a unique presence in the wild.",
      "They are creatures of paradox: immense in strength yet capable of surprising gentleness.",
      "To understand the bear is to understand a keystone of the natural world.",
    ],
    title: "Section 1",
  ),
  SectionModel(
    icon: Icons.account_tree_rounded,
    color: Colors.amber,
    scrollKey: GlobalKey(),
    subTitle: [
      "Contrary to popular belief, the bear family (Ursidae) is not a monolithic group.",
      "It comprises eight distinct species, from the massive Kodiak brown bear to the small Sun bear.",
      "Each species is a masterpiece of adaptation to its specific environment.",
    ],
    title: "Section 2",
  ),
  SectionModel(
    icon: Icons.ads_click_rounded,
    color: Colors.indigo,
    scrollKey: GlobalKey(),
    subTitle: [
      "The biology of a bear is a testament to evolutionary refinement.",
      "Their sense of smell is legendary, estimated to be seven times greater than a bloodhound's.",
      "Their powerful bodies are built for both explosive power and incredible dexterity.",
    ],
    title: "Section 3",
  ),
  SectionModel(
    icon: Icons.ac_unit,
    color: Colors.purple,
    scrollKey: GlobalKey(),
    subTitle: [
      "One of the most fascinating aspects of bear behavior is hibernation.",
      "This is not simply a long sleep; it is a profound physiological state.",
      "For months, a bear survives entirely on its fat reserves, a metabolic marvel.",
    ],
    title: "Section 4",
  ),
  SectionModel(
    icon: Icons.agriculture_sharp,
    color: Colors.green,
    scrollKey: GlobalKey(),
    subTitle: [
      "The relationship between humans and bears is ancient and complex.",
      "In many indigenous cultures, the bear is a sacred figure, a teacher, or an ancestor.",
      "Conservation is now the paramount challenge for many bear species worldwide.",
    ],
    title: "Section 5",
  ),
];

class ScrollToSection extends ConsumerStatefulWidget {
  const ScrollToSection({super.key});

  @override
  ConsumerState<ScrollToSection> createState() => _ScrollToSectionState();
}

class _ScrollToSectionState extends ConsumerState<ScrollToSection> {
  /* Future<void> _scrollToTarget(int index) async {
    try {
      final BuildContext? scrollContext =
          sections[index].scrollKey.currentContext;

      if (scrollContext == null) {
        log("Context of scroll is NULL ...");
        return;
      }

      WidgetsBinding.instance.addPostFrameCallback(
          (_) async => await Scrollable.ensureVisible(scrollContext));
    } catch (error) {
      log("Error while Scroll => $error");
    }
  } */

  late final ItemScrollController _controller;

  @override
  void initState() {
    _controller = ItemScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 10,
          left: 0.0,
          right: 0.0,
          child: SizedBox(
            width: context.screenWidth * .6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(
                sections.length,
                (index) {
                  final SectionModel section = sections[index];
                  return SectionTabItem(
                    onClick: () async {
                      ref
                          .read(scrollableSectionProvider.notifier)
                          .navigateTo(index);

                      // await _scrollToTarget(currentSection);
                      _controller.scrollTo(
                        index: index,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                    section: section,
                  );
                },
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: context.screenHeight * .1,
          child: ScrollablePositionedList.builder(
            itemCount: sections.length,
            itemScrollController: _controller,
            itemBuilder: (context, index) {
              return Container(
                padding: padding(50.0, from: From.horizontal),
                height: context.screenHeight,
                width: context.screenWidth,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(sections[index].title, style: Styles.titleStyle()),
                    Icon(
                      sections[index].icon,
                      size: 200,
                      color: sections[index].color.withOpacity(0.5),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0;
                            i < sections[index].subTitle.length;
                            i++) ...{
                          ShadowText(
                            shadowColor: sections[index].color,
                            textAlign: TextAlign.start,
                            label: sections[index].subTitle[i],
                          ),
                          const Gap(height: 30.0),
                        }
                      ],
                    ),
                  ],
                ),
              );
            },
          ) /* SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (int w = 0; w < sections.length; w++) ...{
                  SizedBox(
                    key: sections[w].scrollKey,
                    height: context.screenHeight,
                    width: context.screenWidth,
                    child: Column(
                      children: <Widget>[
                        Text(sections[w].title, style: Styles.titleStyle()),
                        for (int i = 0;
                            i < sections[w].subTitle.length;
                            i++) ...{
                          ShadowText(
                            shadowColor: sections[w].color,
                            label: sections[w].subTitle[i],
                          ),
                          const Gap(height: 30.0),
                        }
                      ],
                    ),
                  )
                },
                const Gap(hRatio: 0.1),
              ],
            ),
          ) */
          ,
        ),
      ],
    );
  }
}

class SectionTabItem extends StatefulWidget {
  const SectionTabItem({
    super.key,
    required this.onClick,
    required this.section,
  });

  final SectionModel section;
  final void Function() onClick;

  @override
  State<SectionTabItem> createState() => _SectionTabItemState();
}

class _SectionTabItemState extends State<SectionTabItem> {
  bool _active = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _active = true),
      onExit: (_) => setState(() => _active = false),
      child: Transform.scale(
        scale: _active ? 1.15 : 1.0,
        child: ClipRRect(
          borderRadius: borderRadius(10.0),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius(10.0),
                  border: Border.all(
                    color: _active ? AppColors.accent : AppColors.borderColor,
                  ),
                  color: Colors.black38,
                ),
                child: Clicker(
                  onClick: widget.onClick,
                  innerPadding: 10.0,
                  child: Text(
                    widget.section.title,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
