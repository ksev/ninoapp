import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  Control({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Control', style: TextStyle(fontSize: 40.0)),
        ],
      ),
    );
  }
}
