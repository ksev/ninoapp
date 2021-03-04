import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nino/state.dart';
import 'package:nino/tabbar.dart';
import 'package:nino/widgets/button.dart';
import 'package:nino/widgets/input.dart';
import 'package:nino/widgets/logo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NinoServers(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final current = context.select<NinoServers, NinoServer?>((s) => s.current);

    return MaterialApp(
      title: 'Nino',
      theme: ThemeData(
        sliderTheme: SliderThemeData(
          inactiveTrackColor: Colors.grey[400],
          activeTrackColor: Colors.black,
          thumbColor: Colors.black,
          overlayColor: Colors.black.withOpacity(0.1),
        ),

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
        textTheme: GoogleFonts.abelTextTheme(),
        accentColor: Colors.grey[400],
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider.value(
        value: current,
        child: Start(),
      ),
    );
  }
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final server = context.watch<NinoServer?>();

    if (server != null && server.state == ServerState.connected) {
      return Tabbar();
    }

    return Connections();
  }
}

class Connections extends StatelessWidget {
  final _controller = TextEditingController();

  void _addServer(BuildContext context, String uri) {
    FocusScope.of(context).unfocus();

    context.read<NinoServers>().addServer(uri);
  }

  @override
  Widget build(BuildContext context) {
    final len = context.select<NinoServers, int>((s) => s.servers.length);

    return Scaffold(
      backgroundColor: Color(0xFAFAFAFF),
      extendBodyBehindAppBar: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        'Nino',
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 65,
                      height: 65,
                      child: SpinningLogo(
                        seconds: 15,
                      ),
                    ),
                  ],
                ),
              ),
              if (len > 0)
                ServerList()
              else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome to the Nino app.\n\nConnect to a Nino by inputing the domain or ip-address into the box below. It should connect quickly.',
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Input('Address', controller: _controller),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ActionButton(
                            text: 'Add',
                            onTap: () {
                              _addServer(context, _controller.text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServerList extends StatelessWidget {
  void _selectServer(BuildContext context, int index) {
    final server = context.read<NinoServers>();

    server.select(index);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NinoServers>();

    var i = 0;

    final old = state.servers.map((e) {
      final idx = i;

      i++;

      return ChangeNotifierProvider.value(
        value: e,
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: GestureDetector(
            onTap: () => _selectServer(context, idx),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.05),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Consumer<NinoServer>(builder: (context, server, widget) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              server.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('${server.version} - ${server.uri}'),
                            if (server.state == ServerState.error)
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  server.error.toString(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.red[300],
                                  ),
                                ),
                              )
                            else
                              SizedBox.shrink()
                          ],
                        ),
                      ),
                      ConnectionIndicator(server.state),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      );
    });

    return Column(
      children: [...old],
    );
  }
}

class ConnectionIndicator extends StatelessWidget {
  ConnectionIndicator(this.state);

  final ServerState state;

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (state) {
      case ServerState.connected:
        color = Colors.green.withOpacity(0.5);
        break;

      case ServerState.error:
        color = Colors.red.withOpacity(0.5);
        break;

      case ServerState.connecting:
        color = Colors.blue.withOpacity(0.5);
        break;

      default:
        color = Colors.grey.withOpacity(0.5);
        break;
    }

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [BoxShadow(color: color, blurRadius: 5, spreadRadius: 1)],
      ),
    );
  }
}
