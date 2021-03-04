import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input(
    this.label, {
    this.readonly = false,
    this.controller,
    this.textStyle = const TextStyle(fontSize: 20),
    this.contentPadding = const EdgeInsets.all(10),
    this.keyboardType,
  });

  final bool readonly;
  final String label;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final EdgeInsets contentPadding;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black,
              padding: contentPadding.copyWith(top: 0, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: contentPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: controller,
                  style: textStyle,
                  readOnly: readonly,
                  keyboardType: keyboardType,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: false,
                    isDense: true,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputInverse extends StatelessWidget {
  InputInverse(
    this.label, {
    this.readonly = false,
    this.controller,
    this.textStyle = const TextStyle(fontSize: 20),
    this.contentPadding = const EdgeInsets.all(10),
    this.keyboardType,
  });

  final bool readonly;
  final String label;
  final TextEditingController? controller;
  final TextStyle textStyle;
  final EdgeInsets contentPadding;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black,
              padding: contentPadding.copyWith(top: 0, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: contentPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: const Color(0xFFEBEBEB), //Color(0xFFEBEBEB),
                ),
                child: TextField(
                  controller: controller,
                  style: textStyle,
                  readOnly: readonly,
                  keyboardType: keyboardType,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: false,
                    isDense: true,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputAreaInverse extends StatelessWidget {
  InputAreaInverse(
    this.label, {
    this.readonly = false,
    this.controller,
    this.textStyle = const TextStyle(fontSize: 20),
    this.contentPadding = const EdgeInsets.all(10),
    this.keyboardType,
  });

  final bool readonly;
  final String label;
  final TextEditingController? controller;
  final TextStyle textStyle;
  final EdgeInsets contentPadding;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black,
              padding: contentPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: contentPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: const Color(0xFFEBEBEB), //Color(0xFFEBEBEB),
                ),
                child: TextField(
                  controller: controller,
                  style: textStyle,
                  readOnly: readonly,
                  maxLines: 5,
                  keyboardType: keyboardType,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: false,
                    isDense: true,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
