import 'package:flutter/material.dart';
import 'package:nino/state.dart';
import 'package:provider/provider.dart';

class Control extends StatelessWidget {
  Control({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pwm0 = context.select<NinoServer, double>((s) => s.pwm0);
    final pwm1 = context.select<NinoServer, double>((s) => s.pwm1);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Channel(
              pwm0,
              label: 'Channel 0',
              onChange: (v) {
                final server = context.read<NinoServer>();
                server.setPwm(0, v);
              },
            ),
            Container(
              height: 1,
              color: Colors.grey[400],
            ),
            Channel(
              pwm1,
              label: 'Channel 1',
              onChange: (v) {
                final server = context.read<NinoServer>();
                server.setPwm(1, v);
              },
            )
          ],
        ),
      ),
    );
  }
}

class Channel extends StatelessWidget {
  Channel(this.value, {this.onChange, this.label});

  final double value;
  final void Function(double) onChange;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: Text(label, style: TextStyle(fontSize: 25)),
                  ),
                ),
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (value * 100).toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '%',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Slider(value: value, onChanged: onChange),
        ),
      ],
    );
  }
}
