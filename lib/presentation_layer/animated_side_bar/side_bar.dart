import 'package:basic_web_animation/commons/commons.dart';
import 'package:basic_web_animation/commons/gaps.dart';
import 'package:basic_web_animation/commons/screen_dimensions.dart';
import 'package:basic_web_animation/constants/colors.dart';
import 'package:basic_web_animation/constants/enums.dart';
import 'package:basic_web_animation/constants/paths.dart';
import 'package:basic_web_animation/constants/texts.dart';
import 'package:basic_web_animation/presentation_layer/animated_side_bar/side_bar_manager.dart';
import 'package:basic_web_animation/presentation_layer/animated_side_bar/side_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedSideBar extends ConsumerWidget {
  const AnimatedSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentNav = ref.watch(sideBarNavProvider);

    final bool isOpened = ref.watch(sideBarStateProvider) && context.isOpen;
    return Container(
      width: isOpened ? 230 : 90,
      padding: padding(15.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius(20.0, side: RadiusSide.right),
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isOpened
              ? Row(
                  children: <Widget>[
                    SizedBox.square(
                      dimension: 40.0,
                      child: SvgPicture.asset(Assets.logo),
                    ),
                    const Gap(width: 10.0),
                    Text(
                      appTitle,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.titleStyle(),
                    ),
                  ],
                )
              : SizedBox.square(
                  dimension: 40.0,
                  child: SvgPicture.asset(Assets.logo),
                ),
          const Gap(hRatio: 0.02),
          isOpened
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menue,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    //Expanded(child: SizedBox()),
                    ControllerButton(),
                  ],
                )
              : const ControllerButton(),
          const Gap(hRatio: 0.025),
          const Divider(thickness: 1.5),
          ...List<Widget>.generate(
            sideItems.length,
            (index) {
              final SideBarModel nav = sideItems[index];
              return SideBarItem(
                isSelected: currentNav == index,
                nav: nav,
                onClick: () {
                  ref.read(sideBarNavProvider.notifier).navigateTo(index);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ControllerButton extends ConsumerWidget {
  const ControllerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isOpened = ref.watch(sideBarStateProvider) && context.isOpen;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Clicker(
        onClick: () {
          ref.read(sideBarStateProvider.notifier).changeState();
        },
        isCirclar: true,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: isOpened
              ? const Icon(
                  Icons.close,
                  key: ValueKey("OPEND"),
                )
              : const Icon(
                  Icons.arrow_forward_ios_rounded,
                  key: ValueKey("Cloed"),
                ),
        ),
      ),
    );
  }
}

class SideBarItem extends ConsumerStatefulWidget {
  const SideBarItem({
    super.key,
    required this.isSelected,
    required this.nav,
    required this.onClick,
  });

  final SideBarModel nav;
  final bool isSelected;
  final void Function() onClick;

  @override
  ConsumerState<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends ConsumerState<SideBarItem> {
  bool hasFocus = false;
  BoxDecoration get _itemDecoration => BoxDecoration(
        borderRadius: borderRadius(10.0),
        color: widget.isSelected ? AppColors.primary : null,
        border: hasFocus ? Border.all(color: AppColors.primary) : Border.all(),
      );
  @override
  Widget build(BuildContext context) {
    final bool isOpened = ref.watch(sideBarStateProvider) && context.isOpen;
    return MouseRegion(
      onEnter: (_) => setState(() => hasFocus = true),
      onExit: (_) => setState(() => hasFocus = false),
      child: Transform.scale(
        scale: hasFocus ? 1.1 : 1.0,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: isOpened
              ? AnimatedContainer(
                  //width: context.screenWidth * .12,
                  margin: padding(7.0),
                  duration: const Duration(milliseconds: 300),
                  decoration: _itemDecoration,
                  child: Clicker(
                    innerPadding: 10.0,
                    onClick: widget.onClick,
                    child: Row(
                      children: <Widget>[
                        widget.nav.icon,
                        const Gap(width: 10.0),
                        FittedBox(
                          child: Text(
                            widget.nav.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: padding(7.0),
                  decoration: _itemDecoration,
                  child: Tooltip(
                    message: widget.nav.title,
                    verticalOffset: 30,
                    preferBelow: true,
                    child: Clicker(
                      innerPadding: 10,
                      onClick: widget.onClick,
                      child: widget.nav.icon,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
