import 'dart:io';

import 'package:Nino/widgets.dart/logo.dart';
import 'package:flutter/material.dart';
import 'package:multicast_dns/multicast_dns.dart';

class ConnectionChooser extends StatefulWidget {
  @override
  _ConnectionChooserState createState() => _ConnectionChooserState();
}

class _Connection {
  _Connection(this.name, this.sensors, this.target, this.port);

  final String name;
  final int sensors;
  final String target;
  final int port;
}

class _ConnectionChooserState extends State<ConnectionChooser> {
  MDnsClient _mdns;
  Map<String, _Connection> _connections;

  @override
  void initState() {
    _connections = new Map();

    _mdns = MDnsClient(rawDatagramSocketFactory: (dynamic host, int port,
        {bool reuseAddress, bool reusePort, int ttl}) {
      return RawDatagramSocket.bind(host, port,
          reuseAddress: true, reusePort: false, ttl: ttl);
    });

    super.initState();
    _search();
  }

  void _search() async {
    await _mdns.start();

    final addr = ResourceRecordQuery.serverPointer("_nino._tcp.local");

    while (true) {
      // Get the PTR record for the service.
      await for (final ptr in _mdns.lookup<PtrResourceRecord>(addr)) {
        // Use the domainName from the PTR record to get the SRV record,
        // which will have the port and local hostname.
        // Note that duplicate messages may come through, especially if any
        // other mDNS queries are running elsewhere on the machine.
        final serverQuery = ResourceRecordQuery.service(ptr.domainName);
        final txtQuery = ResourceRecordQuery.text(ptr.domainName);

        if (!_connections.containsKey(ptr.domainName)) {
          final response = await Future.wait([
            _mdns.lookup<SrvResourceRecord>(serverQuery).first,
            _mdns.lookup<TxtResourceRecord>(txtQuery).first,
          ]);

          final server = response[0] as SrvResourceRecord;
          final txt = response[1] as TxtResourceRecord;

          if (!_connections.containsKey(ptr.domainName)) {
            final split = txt.text.split("|");

            final name = split[0];
            final sensors = int.tryParse(split[1]) ?? 0;

            setState(() {
              _connections[ptr.domainName] =
                  _Connection(name, sensors, server.target, server.port);
            });
          }
        }
      }

      await Future.delayed(Duration(seconds: 2));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mdns.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFAFAFAFF),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('assets/pattern.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0.0, 1.0),
                colors: [
                  const Color(0xFFFFFFFF),
                  const Color(0x00FFFFFF),
                ], // red to yellow
              ),
            ),
          ),
          Container(
            child: SafeArea(
              child: AnimatedCrossFade(
                firstChild: _ConnectionList(_connections),
                secondChild: _Searching(),
                crossFadeState: _connections.isNotEmpty
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 250),
                layoutBuilder:
                    (topChild, topChildKey, bottomChild, bottomChildKey) {
                  return Stack(
                    children: <Widget>[
                      Positioned(
                        key: bottomChildKey,
                        left: 0.0,
                        top: 0.0,
                        right: 0.0,
                        bottom: 0.0,
                        child: bottomChild,
                      ),
                      Positioned(
                        key: topChildKey,
                        child: topChild,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectionList extends StatelessWidget {
  _ConnectionList(this._connections);

  final Map<String, _Connection> _connections;

  @override
  Widget build(BuildContext context) {
    final children = _connections.keys.map((key) {
      final value = _connections[key];

      return GestureDetector(
        onTap: () {
          debugPrint('Connect to ${value.target}:${value.port}');
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('${value.target}:${value.port}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                ],
              ),
              Text('${value.sensors}', style: TextStyle(fontSize: 40))
            ],
          ),
        ),
      );
    });

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nino on WiFi", style: TextStyle(fontSize: 30.0)),
            Container(
              height: 25,
            ),
            ...children.toList()
          ],
        ),
      ),
    );
  }
}

class _Searching extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: SpinningLogo(
              minutes: 4,
            ),
          ),
          Container(
            height: 25,
          ),
          Text("Searching for Nino", style: TextStyle(fontSize: 25.0)),
        ],
      ),
    );
  }
}
