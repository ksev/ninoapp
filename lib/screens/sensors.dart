import 'package:flutter/material.dart';

class Sensors extends StatelessWidget {
  Sensors({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sensors', style: TextStyle(fontSize: 40.0)),
        ],
      ),
    );
  }
}
