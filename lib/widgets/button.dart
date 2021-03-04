import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  ActionButton(
      {required this.text,
      this.onTap,
      this.padding = const EdgeInsets.all(15.0),
      this.textStyle,
      this.color = Colors.black});

  final String text;
  final void Function()? onTap;
  final EdgeInsets padding;
  final Color color;
  final TextStyle? textStyle;

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() {
        _isDown = true;
      }),
      onTapUp: (_) => setState(() {
        _isDown = false;
      }),
      onTapCancel: () => setState(() {
        _isDown = false;
      }),
      child: Container(
        decoration: BoxDecoration(
          color: _isDown ? Colors.black54 : widget.color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ).merge(widget.textStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
