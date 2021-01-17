import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Dashboard', style: TextStyle(fontSize: 40.0)),
          Text('1200 RPM', style: TextStyle(fontSize: 40.0)),
          Text('31°C', style: TextStyle(fontSize: 40.0)),
        ],
      ),
    );
  }
}
