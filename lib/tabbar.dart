import 'package:nino/screens/control.dart';
import 'package:nino/screens/sensors.dart';
import 'package:flutter/material.dart';

class BottomBarPainter extends CustomPainter {
  BottomBarPainter(this.midPoint, this.notchHeight, this.notchShown);

  final double notchHeight;
  final double notchShown;
  final double midPoint;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final notchwidth = 30.0;
    final fallwidth = 10.0;

    final shown = 10 - notchHeight * notchShown;

    final path = Path();

    path.moveTo(0, notchHeight);
    path.lineTo(midPoint - notchwidth - fallwidth, notchHeight);
    path.lineTo(midPoint - notchwidth, shown);
    path.lineTo(midPoint + notchwidth, shown);
    path.lineTo(midPoint + notchwidth + fallwidth, notchHeight);

    path.lineTo(size.width, notchHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black54, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Tabbar extends StatefulWidget {
  final sensorsKey = GlobalKey();
  final controlKey = GlobalKey();

  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with SingleTickerProviderStateMixin {
  Animation<double> tabAnimation;
  Animation<double> iconAnimation;
  Animation<double> fontAnimation;
  Animation<Color> colorAnimation;
  Animation<double> padAnimation;
  AnimationController controller;

  double midPoint;
  String currentTab;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 50),
      vsync: this,
    );

    controller.addListener(() {
      setState(() {});
    });

    final iconBase = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    iconAnimation = Tween<double>(begin: 40.0, end: 24.0).animate(iconBase);

    fontAnimation = Tween<double>(begin: 14, end: 12).animate(controller);
    padAnimation = Tween<double>(begin: 0, end: 10).animate(controller);
    colorAnimation = ColorTween(begin: Colors.black, end: Colors.black54)
        .animate(controller);

    final c1 = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInCubic,
      reverseCurve: Curves.easeOutQuad,
    );

    tabAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(c1);

    midPoint = 0.0;
    currentTab = "sensors";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final rb =
          widget.sensorsKey.currentContext.findRenderObject() as RenderBox;

      final size = rb.size;
      final box = rb.localToGlobal(Offset.zero);
      setState(() {
        midPoint = box.dx + size.width / 2.0;
      });
    });
  }

  _changeTab(String name) {
    if (name == currentTab) {
      return;
    }

    switch (name) {
      case "sensors":
        _moveTabToKey(widget.sensorsKey, name);
        break;

      case "control":
        _moveTabToKey(widget.controlKey, name);
        break;
    }
  }

  _moveTabToKey(GlobalKey key, String tabName) {
    final rb = key.currentContext.findRenderObject() as RenderBox;

    final size = rb.size;
    final box = rb.localToGlobal(Offset.zero);
    //midPoint = box.dx + size.width / 2.0;

    controller.forward().then((value) {
      setState(() {
        currentTab = tabName;
        midPoint = box.dx + size.width / 2.0;
      });
      controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size;
    final offset = midPoint == 0.0 ? size.width / 2.0 : midPoint;

    Widget page;
    switch (currentTab) {
      case "sensors":
        page = Sensors(key: ValueKey("sensors"));
        break;
      case "control":
        page = Control(key: ValueKey("control"));
        break;
    }

    return Scaffold(
      backgroundColor: Color(0xFAFAFAFF),
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              width: size.width,
              height: size.height -
                  media.padding.top -
                  media.viewInsets.bottom -
                  80 +
                  10,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 150),
                child: page,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: BottomBarPainter(offset, 10, tabAnimation.value),
                    child: Container(width: size.width, height: 80),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => _changeTab("sensors"),
                          child: SizedBox(
                            key: widget.sensorsKey,
                            width: 60,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: currentTab == "sensors"
                                      ? padAnimation.value
                                      : 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.settings_input_svideo_outlined,
                                      size: currentTab == "sensors"
                                          ? iconAnimation.value
                                          : 24,
                                      color: currentTab == "sensors"
                                          ? colorAnimation.value
                                          : Colors.black45,
                                    ),
                                    Text(
                                      'Sensors',
                                      style: TextStyle(
                                        fontSize: currentTab == "sensors"
                                            ? fontAnimation.value
                                            : 12,
                                        color: currentTab == "sensors"
                                            ? colorAnimation.value
                                            : Colors.black45,
                                        fontWeight: currentTab == "sensors"
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*
                        GestureDetector(
                          onTap: () => _changeTab("dashboard"),
                          child: SizedBox(
                            key: widget.dashboardKey,
                            width: 60,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: currentTab == "dashboard"
                                      ? padAnimation.value
                                      : 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.speed_outlined,
                                      size: currentTab == "dashboard"
                                          ? iconAnimation.value
                                          : 24,
                                      color: currentTab == "dashboard"
                                          ? colorAnimation.value
                                          : Colors.black45,
                                    ),
                                    Text(
                                      'Dashboard',
                                      style: TextStyle(
                                        fontSize: currentTab == "dashboard"
                                            ? fontAnimation.value
                                            : 12,
                                        color: currentTab == "dashboard"
                                            ? colorAnimation.value
                                            : Colors.black45,
                                        fontWeight: currentTab == "dashboard"
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        */
                        GestureDetector(
                          onTap: () => _changeTab("control"),
                          child: SizedBox(
                            key: widget.controlKey,
                            width: 60,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: currentTab == "control"
                                      ? padAnimation.value
                                      : 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.toys_outlined,
                                      size: currentTab == "control"
                                          ? iconAnimation.value
                                          : 24,
                                      color: currentTab == "control"
                                          ? colorAnimation.value
                                          : Colors.black45,
                                    ),
                                    Text(
                                      'Control',
                                      style: TextStyle(
                                        fontSize: currentTab == "control"
                                            ? fontAnimation.value
                                            : 12,
                                        color: currentTab == "control"
                                            ? colorAnimation.value
                                            : Colors.black45,
                                        fontWeight: currentTab == "control"
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
