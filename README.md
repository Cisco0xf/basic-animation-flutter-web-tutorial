# Live demo => https://cisco0xf.github.io/basic-animation-flutter-web/

# Flutter Web Animations

A showcase of basics of Flutter web animations demonstrating various animation techniques and interactions.

## Project Structure
```text
lib/
├── commons/              # Shared utilities and extensions
├── constants/            # Colors, paths, texts, and enums
└── presentation_layer/
    ├── animated_side_bar/    # Sidebar components
    └── animations/           # Animation examples
        ├── bouncing.dart
        ├── card_transition.dart
        ├── combine_animation.dart
        ├── text_shadow.dart
        ├── shadow_tracking.dart
        ├── mous_tracking.dart
        ├── scroll_to_section.dart
        └── end.dart
```
## Features
- **Bouncing Animation** *- Scale and transform animations with repeated motion*
- **Card Transitions** *- Interactive hover effects with scale and shadow animations*
- **Combine Animation** *- Multiple synchronized animations using TweenAnimationBuilder*
- **Text Shadow** *- Dynamic text effects with mouse interaction*
- **Shadow Tracking** *- Container shadow that follows mouse position*
- **Mouse Tracking** *- Light effect that tracks cursor movement*
- **Scroll to Section** *- Smooth scrolling navigation with backdrop blur effects*

## Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  google_fonts: ^6.3.0
  flutter_svg: ^2.1.0
  flutter_riverpod: ^2.6.1
  font_awesome_flutter: ^10.9.0
  url_launcher: ^6.3.1
  scrollable_positioned_list: ^0.3.8
```

## Animation Examples

### 1- Bouncing Animation

- This animation has two main bouncing mechanism:

  1- `ScaleTransition`:

```dart

class Bouncing extends StatefulWidget {
  const Bouncing({super.key});

  @override
  State<Bouncing> createState() => _BouncingState();
}

class _BouncingState extends State<Bouncing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _animation = Tween<double>(begin: 0.9, end: 1.0).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(knooz, style: Styles.titleStyle()),
        const Gap(height: 20),
        ScaleTransition(
          scale: _animation,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: context.screenHeight * .6,
                width: context.screenWidth * .23,
                child: Image.network(Assets.darkHome),
              ),
              SizedBox(
                height: context.screenHeight * .6,
                width: context.screenWidth * .23,
                child: Image.network(Assets.darkQuran),
              ),
            ],
          ),
        )
      ],
    );
  }
}
```
  2- `Transform.translate`:

```dart

class Bouncing2 extends StatefulWidget {
  const Bouncing2({super.key});

  @override
  State<Bouncing2> createState() => _Bouncing2State();
}

class _Bouncing2State extends State<Bouncing2>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _animation = Tween<double>(begin: 0.0, end: 50).animate(_controller);

    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(knooz, style: Styles.titleStyle()),
        const Gap(height: 100),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -_animation.value),
              child: const FlutterLogo(size: 300.0),
            );
          },
        ),
        Container(
          width: 100 * (_animation.value / 50),
          height: 10,
          decoration: BoxDecoration(
            borderRadius: borderRadius(10),
            color: AppColors.accent,
          ),
        )
      ],
    );
  }
}
```
![Eample1_GIF](https://github.com/Cisco0xf/basic-animation-flutter-web-tutorial/blob/main/GIFs/Bouncing_GIF.gif)


### 2- Mouse Tracking

- You can replace the Dot with any `Widget` you want
```dart

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

```
![GIF Example](https://github.com/Cisco0xf/basic-animation-flutter-web-tutorial/blob/main/GIFs/Mous_reach_GIF.gif)

### 3- Card Transitions

- You can controle everything with the `_active` property and `_controller`

```dart

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
    super.initState();
  }

  bool _active = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _active = true),
      onExit: (_) => setState(() => _active = false),
      child: ScaleTransition(
        scale: _animation,
        child: SizedBox.square(
          dimension: context.screenHeight * .18,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: borderRadius(_active ? 25.0 : 15.0),
              border: Border.all(
                color: _active ? widget.devItem.color : AppColors.borderColor,
              ),
              color: AppColors.bgColor,
              boxShadow: _active
                  ? [
                      const BoxShadow(
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(4, 4),
                        color: Colors.transparent,
                      ),
                      BoxShadow(
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: const Offset(4, 4),
                        color: widget.devItem.color.withOpacity(0.4),
                      ),
                    ]
                  : null,
            ),
            child: Clicker(
              onClick: () async {
                await _controller.forward();
                await _controller.reverse();

                widget.onClick.call();
              },
              radius: 25.0,
              innerPadding: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(widget.devItem.icon),
                  const Gap(height: 10.0),
                  Text(widget.devItem.label),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```

![GIF Example](https://github.com/Cisco0xf/basic-animation-flutter-web-tutorial/blob/main/GIFs/Scaling_GIF.gif)

### 4-Shadow Tracking

- You can increase the distance of the shadow by increasing the divided value over the offsets

```dart

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

```

![GIF Exapmle](https://github.com/Cisco0xf/basic-animation-flutter-web-tutorial/blob/main/GIFs/Shadow_GIF.gif)

### 5- Scroll Navigation

```dart

class ScrollToSection extends ConsumerStatefulWidget {
  const ScrollToSection({super.key});

  @override
  ConsumerState<ScrollToSection> createState() => _ScrollToSectionState();
}

class _ScrollToSectionState extends ConsumerState<ScrollToSection> {
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
        Positioned.fill(
          child: ScrollablePositionedList.builder(
            itemCount: sections.length,
            itemScrollController: _controller,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                    right: 50.0, left: 50.0, top: context.screenHeight * .1),
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
          ),
        ),
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
      ],
    );
  }
}

```

![GIF Exapmle](https://github.com/Cisco0xf/basic-animation-flutter-web-tutorial/blob/main/GIFs/Scrolling_GIF.gif)

### 6- Animated Text Shadow

```dart

class ShadowText extends StatefulWidget {
  const ShadowText({
    super.key,
    required this.shadowColor,
    required this.label,
    this.fontSize = 21,
    this.textAlign,
  });

  final Color shadowColor;
  final String label;
  final double fontSize;
  final TextAlign? textAlign;

  @override
  State<ShadowText> createState() => _ShadowTextState();
}

class _ShadowTextState extends State<ShadowText> {
  bool _active = false;

  List<Shadow> get _shadows => [
        for (int i = 0; i < 4; i++) ...{
          Shadow(
            blurRadius: i * 3,
            color: widget.shadowColor.withOpacity(0.8),
          ),
        }
      ];
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _active = true),
      onExit: (_) => setState(() => _active = false),
      child: Text(
        "${widget.label}\n",
        textAlign: widget.textAlign,
        style: TextStyle(
          fontSize: widget.fontSize,
          shadows: _active ? _shadows : null,
          fontWeight: _active ? FontWeight.bold : null,
        ),
      ),
    );
  }
}

```

![GIF Exapmle](https://github.com/Cisco0xf/basic-animation-flutter-web-tutorial/blob/main/GIFs/Text_Shadow_GIF.gif)


### Built with Flutter 
*Feel free to use this project as a reference for your Flutter web animations!*

## LICENSE

**MIT © Mahmoud Nagy**