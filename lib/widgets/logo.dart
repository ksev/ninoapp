import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class SpinningLogo extends StatefulWidget {
  SpinningLogo({Key key, this.seconds = 3}) : super(key: key);

  final int seconds;

  @override
  _SpinningLogoState createState() => _SpinningLogoState();
}

class _SpinningLogoState extends State<SpinningLogo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.seconds));
    _controller.repeat();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: math.pi * 2 * _controller.value,
          child: SvgPicture.asset("assets/logo-noeye.svg"),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.2531645569620253,
              heightFactor: 0.2531645569620253,
              child: SvgPicture.asset(
                "assets/eye.svg",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
