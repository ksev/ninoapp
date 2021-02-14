import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:nino/state.dart';
import 'package:nino/widgets/button.dart';
import 'package:nino/widgets/input.dart';
import 'package:provider/provider.dart';

class Sensors extends StatelessWidget {
  Sensors({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sens = context.select<NinoServer, UnmodifiableMapView<int, Sensor>>(
        (server) => server.sensors);

    final builtInValues = sens.values.where((s) => !s.isVirtual).toList();
    builtInValues.sort((o, t) => o.id.compareTo(t.id));

    final builtIn = builtInValues.map(
      (s) => ChangeNotifierProvider.value(
        value: s,
        child: SensorItem(),
      ),
    );

    final virtualValues = sens.values.where((s) => s.isVirtual).toList();
    virtualValues.sort((o, t) => o.id.compareTo(t.id));

    final virtual = virtualValues.map(
      (s) => ChangeNotifierProvider.value(
        value: s,
        child: SensorItem(),
      ),
    );

    return Center(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: Text('Builtin', style: TextStyle(fontSize: 35.0)),
          ),
          ...builtIn,
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 30, right: 30, bottom: 5),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Virtual', style: TextStyle(fontSize: 35.0)),
                  SizedBox(
                    height: 30,
                    child: ActionButton(
                      text: '+',
                      onTap: () {
                        final server = context.read<NinoServer>();

                        server.addSensor();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...virtual,
        ],
      ),
    );
  }
}

class InactiveSensorItem extends StatelessWidget {
  InactiveSensorItem();

  @override
  Widget build(BuildContext context) {
    final sensor = context.watch<Sensor>();

    return Opacity(
      opacity: 0.7,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${sensor.alias}', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 60,
                height: 80,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'N/A',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SensorItem extends StatefulWidget {
  SensorItem();

  @override
  _SensorItemState createState() => _SensorItemState();
}

class _SensorItemState extends State<SensorItem> {
  var _open = CrossFadeState.showSecond;

  void closeTab() {
    setState(() {
      _open = CrossFadeState.showSecond;
    });
  }

  void openTab() {
    setState(() {
      _open = CrossFadeState.showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAlive = context.select<Sensor, bool>((s) => s.values.isNotEmpty);

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      crossFadeState: _open,
      firstChild: SensorEditor(onDone: closeTab),
      secondChild: GestureDetector(
        onTap: openTab,
        child: isAlive ? SensorItemCollapsed() : InactiveSensorItem(),
      ),
    );
  }
}

class SensorEditor extends StatefulWidget {
  SensorEditor({Key key, this.onDone}) : super(key: key);

  final void Function() onDone;

  @override
  _SensorEditorState createState() => _SensorEditorState();
}

class _SensorEditorState extends State<SensorEditor> {
  TextEditingController _aliasEditingController;
  TextEditingController _unitEditingController;
  TextEditingController _rateEditingControler;
  TextEditingController _sourceEditingController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final sens = context.read<Sensor>();

    _aliasEditingController = TextEditingController(text: sens.alias);
    _unitEditingController = TextEditingController(text: sens.unit);
    _rateEditingControler = TextEditingController(text: sens.rate.toString());

    debugPrint(sens.source);

    _sourceEditingController = TextEditingController(text: sens.source);
  }

  @override
  void dispose() {
    super.dispose();

    _aliasEditingController.dispose();
    _unitEditingController.dispose();
    _rateEditingControler.dispose();
    _sourceEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVirtual = context.select<Sensor, bool>((s) => s.isVirtual);

    final inputStyle = TextStyle(fontSize: 14);

    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black.withOpacity(0.05),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              /*
              Container(
                width: double.infinity,
                height: 100,
                color: const Color(0xFFEBEBEB),
              ),
              */
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0, right: 5.0),
                      child: InputInverse(
                        'Alias',
                        textStyle: inputStyle,
                        controller: _aliasEditingController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0, left: 5.0),
                      child: InputInverse(
                        'Unit',
                        textStyle: inputStyle,
                        controller: _unitEditingController,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: InputInverse(
                        'Poll rate',
                        textStyle: inputStyle.copyWith(
                          color: isVirtual ? Colors.black : Colors.grey,
                        ),
                        controller: _rateEditingControler,
                        readonly: !isVirtual,
                      ),
                    ),
                  ),
                ],
              ),
              if (isVirtual)
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputAreaInverse(
                    'Script',
                    textStyle: inputStyle,
                    controller: _sourceEditingController,
                  ),
                )
              else
                SizedBox.shrink(),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60,
                      child: ActionButton(
                          text: 'Save',
                          onTap: () {
                            final sensor = context.read<Sensor>();
                            final server = context.read<NinoServer>();

                            server.configureSensor(
                              sensor.id,
                              alias: _aliasEditingController.text,
                              unit: _unitEditingController.text,
                              rate: _rateEditingControler.text,
                              source: isVirtual
                                  ? _sourceEditingController.text
                                  : null,
                            );

                            widget.onDone();
                          }),
                    ),
                    ActionButton(
                      text: 'Cancel',
                      onTap: widget.onDone,
                      color: const Color(0xFFEBEBEB),
                      textStyle: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SensorItemCollapsed extends StatelessWidget {
  SensorItemCollapsed();

  @override
  Widget build(BuildContext context) {
    final sensor = context.watch<Sensor>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 30, right: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black.withOpacity(0.05),
            )
          ],
        ),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${sensor.alias}', style: TextStyle(fontSize: 15)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: sensor.hasError
                              ? Text(sensor.error)
                              : Sparkline(
                                  lineWidth: 1.5,
                                  lineColor: Colors.black26,
                                  fillMode: FillMode.below,
                                  fillGradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color(0xFFEBEBEB),
                                      const Color(0xFFFFFFFF),
                                    ],
                                  ),
                                  data: sensor.values.reversed.toList(),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 60,
              height: 80,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sensor.values.first.round().toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    sensor.unit,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
