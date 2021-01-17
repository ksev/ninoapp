import 'package:Nino/screens/connection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/control.dart';
import 'screens/dashboard.dart';
import 'screens/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nino',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        textTheme: GoogleFonts.abelTextTheme(),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConnectionChooser(),
    );
  }
}

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

class Home extends StatefulWidget {
  final sensorsKey = GlobalKey();
  final dashboardKey = GlobalKey();
  final controlKey = GlobalKey();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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
      duration: Duration(milliseconds: 75),
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
    currentTab = "dashboard";
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

      case "dashboard":
        _moveTabToKey(widget.dashboardKey, name);
        break;
    }
  }

  _moveTabToKey(GlobalKey key, String tabName) {
    final rb = key.currentContext.findRenderObject() as RenderBox;

    final size = rb.size;
    final box = rb.localToGlobal(Offset.zero);

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
    final size = MediaQuery.of(context).size;
    final offset = midPoint == 0.0 ? size.width / 2.0 : midPoint;

    Widget page;
    switch (currentTab) {
      case "sensors":
        page = Sensors(key: ValueKey("sensors"));
        break;
      case "control":
        page = Control(key: ValueKey("control"));
        break;
      case "dashboard":
        page = Dashboard(key: ValueKey("dashboard"));
        break;
    }

    return Scaffold(
      backgroundColor: Color(0xFAFAFAFF),
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Stack(
          children: [
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

            /** Actuall app after this */

            Positioned(
              top: 0,
              width: size.width,
              height: size.height - 70,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 150),
                child: page,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
