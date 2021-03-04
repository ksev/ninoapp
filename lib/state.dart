import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chunked_stream/chunked_stream.dart';
import 'package:flutter/material.dart';
import 'package:nino/proto/net.pb.dart';
import 'package:sqflite/sqflite.dart';

class NinoServers extends ChangeNotifier {
  final List<NinoServer> _servers = [];

  UnmodifiableListView<NinoServer> get servers {
    if (_database == null) {
      _database = openDatabase(
        'nino.db',
        version: 1,
        onCreate: createDatabase,
        onOpen: onOpenDatabase,
      );
    }

    return UnmodifiableListView(_servers);
  }

  NinoServer? _selected;
  NinoServer? get current => _selected;

  Future<Database>? _database;
  Future<Database> get database {
    if (_database == null) {
      _database = openDatabase(
        'nino.db',
        version: 1,
        onCreate: createDatabase,
        onOpen: onOpenDatabase,
      );
    }

    return _database!;
  }

  void addServer(String uri, {bool select = true}) {
    final server = NinoServer(uri);

    _servers.add(server);

    if (select) {
      _selected = server;
      server.connect(onSuccess: () => saveServer(server));
    }

    notifyListeners();
  }

  void select(int index) {
    final server = _servers[index];

    if (server.state != ServerState.connected &&
        server.state != ServerState.connecting) {
      server.connect(onSuccess: () => saveServer(server));
    }

    _selected = server;
    notifyListeners();
  }

  Future<void> createDatabase(Database db, int version) async {
    debugPrint('createDatabase');
    await db.execute(
      '''
      CREATE TABLE "servers" (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        version TEXT NOT NULL
      )
    ''',
    );
  }

  Future<void> onOpenDatabase(Database db) async {
    final list = await db.rawQuery('SELECT id, name, version FROM "servers"');

    list.forEach((element) {
      _servers.add(NinoServer.fromParts(
        uri: element['id'] as String,
        name: element['name'] as String,
        version: element['version'] as String,
      ));
    });

    notifyListeners();
  }

  Future<void> saveServer(NinoServer server) async {
    final db = await database;

    await db.rawInsert(
      'INSERT OR REPLACE INTO "servers" (id, name, version) VALUES (?,?,?)',
      [server.uri, server.name, server.version],
    );
  }
}

class Package {
  Package(this.id, this.data);

  final MessageId id;
  final List<int> data;
}

class MessageId {
  const MessageId(this.number);

  final int number;

  static const hello = MessageId(0);
  static const ready = MessageId(1);
  static const value = MessageId(2);
  static const sensors = MessageId(3);
  static const sensorConfig = MessageId(4);
  static const addSensor = MessageId(5);
  static const setPwm = MessageId(6);

  factory MessageId.fromU16(int value) {
    switch (value) {
      case 0:
        return MessageId.hello;
      case 1:
        return MessageId.ready;

      case 2:
        return MessageId.value;

      case 3:
        return MessageId.sensors;

      case 4:
        return MessageId.sensorConfig;

      case 5:
        return MessageId.addSensor;

      case 6:
        return MessageId.setPwm;

      default:
        throw Exception('$value is not a MessageId');
    }
  }
}

enum ServerState {
  connecting,
  connected,
  disconnected,
  error,
}

class Connection {
  Connection(this.uri);

  final String uri;

  Socket? _socket;
  ChunkedStreamIterator<int>? _stream;

  void close() {
    _socket?.destroy();
  }

  Future<void> connect() async {
    _socket = await Socket.connect(
      uri,
      7583,
      timeout: Duration(seconds: 15),
    );

    final buf = bufferChunkedStream(_socket!);
    _stream = ChunkedStreamIterator(buf);
  }

  Future<void> sendPackage(MessageId id, Uint8List data) async {
    final preamble = ByteData(10);
    preamble.setUint16(0, id.number, Endian.little);
    preamble.setUint64(2, data.lengthInBytes, Endian.little);

    _socket?.add(preamble.buffer.asUint8List());
    _socket?.add(data);

    await _socket?.flush();
  }

  Future<Package> readPackage() async {
    final id = MessageId.fromU16(await this.readUint16());

    final dataLen = await this.readUint64();
    final data = await _stream!.read(dataLen);

    return Package(id, data);
  }

  Future<int> readUint32() async {
    return Uint8List.fromList(await _stream!.read(4))
        .buffer
        .asByteData()
        .getUint32(0, Endian.little);
  }

  Future<int> readUint16() async {
    return Uint8List.fromList(await _stream!.read(2))
        .buffer
        .asByteData()
        .getUint16(0, Endian.little);
  }

  Future<int> readUint64() async {
    return Uint8List.fromList(await _stream!.read(8))
        .buffer
        .asByteData()
        .getUint64(0, Endian.little);
  }

  Future<String> readPrefixString() async {
    final strLen = Uint8List.fromList(await _stream!.read(4))
        .buffer
        .asByteData()
        .getUint32(0, Endian.little);

    return utf8.decode(await _stream!.read(strLen));
  }
}

class Sensor extends ChangeNotifier {
  Sensor(this.id, String alias, String unit, int rate, String? error,
      String source, List<double> values)
      : _alias = alias,
        _unit = unit,
        _rate = rate,
        _error = error,
        _source = source,
        _values = values;

  final int id; // Will never change

  String _alias;
  String _unit;
  String? _error;
  String _source;
  int _rate;

  List<double> _values;

  String get source => _source;
  String? get error => _error;
  bool get hasError => _error?.isNotEmpty ?? true;
  bool get isVirtual => id > 6;
  String get alias => _alias;
  String get unit => _unit;
  int get rate => _rate;
  UnmodifiableListView<double> get values => UnmodifiableListView(_values);

  void update(double value, int max) {
    _values.insert(0, value);

    if (_values.length > max) {
      final overflow = _values.length - max;
      _values.removeRange(_values.length - overflow, _values.length);
    }

    notifyListeners();
  }
}

class NinoServer extends ChangeNotifier {
  NinoServer(this.uri);

  factory NinoServer.fromParts(
      {required String uri, required String name, required String version}) {
    final out = NinoServer(uri);

    out._name = name;
    out._version = version;

    return out;
  }

  final String uri;

  Map<int, Sensor> _sensors = Map();
  String _name = 'Unknown';
  String _version = '???';
  double _pwm0 = 0.0;
  double _pwm1 = 0.0;
  int _retention = 1;
  dynamic _error;
  Connection? _conn;
  ServerState _state = ServerState.disconnected;

  dynamic get error => _error;
  ServerState get state => _state;
  String get name => _name;
  String get version => _version;
  double get pwm0 => _pwm0;
  double get pwm1 => _pwm1;
  UnmodifiableMapView<int, Sensor> get sensors => UnmodifiableMapView(_sensors);

  void connect({void Function()? onSuccess}) async {
    try {
      _state = ServerState.connecting;

      notifyListeners();

      _conn = Connection(uri);
      await _conn!.connect();

      final pkg = await _conn!.readPackage();

      if (pkg.id != MessageId.hello) {
        throw Exception("Server did not initialize with Hello");
      }

      final hello = Hello.fromBuffer(pkg.data);

      _name = hello.name;
      _version = hello.version;
      _retention = hello.retention;
      _pwm0 = hello.pwm0;
      _pwm1 = hello.pwm1;

      await _conn!.sendPackage(MessageId.ready, Uint8List(0));

      _state = ServerState.connected;

      if (onSuccess != null) {
        onSuccess();
      }
      debugPrint("Connected");

      listen();
    } catch (e) {
      debugPrint('Error here $e');
      _error = e;
      _state = ServerState.error;
    }

    notifyListeners();
  }

  Future<void> setPwm(int channel, double value) async {
    assert(value >= 0.0 && value <= 1.0);

    try {
      if (channel == 0) {
        _pwm0 = value;
      } else {
        _pwm1 = value;
      }

      notifyListeners();

      await _conn!.sendPackage(
        MessageId.setPwm,
        SetPwm(
          channel: SetPwm_Channel.valueOf(channel),
          value: value,
        ).writeToBuffer(),
      );
    } catch (e) {
      _conn!.close();

      _state = ServerState.error;
      _error = e;
      _conn = null;
      notifyListeners();

      debugPrint('Send error: $e');
      return;
    }
  }

  Future<void> configureSensor(
    int id, {
    required String alias,
    required String unit,
    required String rate,
    required String? source,
  }) async {
    try {
      await _conn!.sendPackage(
        MessageId.sensorConfig,
        SensorConfig(
          id: id,
          alias: alias,
          unit: unit,
          rate: int.parse(rate),
          source: source,
        ).writeToBuffer(),
      );
    } catch (e) {
      _conn!.close();

      _state = ServerState.error;
      _error = e;
      _conn = null;
      notifyListeners();

      debugPrint('Send error: $e');
      return;
    }
  }

  Future<void> addSensor() async {
    try {
      await _conn!.sendPackage(MessageId.addSensor, Uint8List(0));
    } catch (e) {
      _conn!.close();

      _state = ServerState.error;
      _error = e;
      _conn = null;
      notifyListeners();

      debugPrint('Send error: $e');
      return;
    }
  }

  void listen() async {
    try {
      while (true) {
        final pkg = await _conn!.readPackage();

        switch (pkg.id) {
          case MessageId.value:
            final upd = Value.fromBuffer(pkg.data);
            final old = _sensors[upd.id];

            if (old != null) {
              old.update(upd.value, _retention);
            }

            break;

          case MessageId.sensors:
            final sen = Sensors.fromBuffer(pkg.data);

            final map = Map<int, Sensor>();

            for (final s in sen.sensors) {
              map[s.id] = Sensor(
                s.id,
                s.alias,
                s.unit,
                s.rate,
                s.error,
                s.source,
                s.values,
              );
            }

            _sensors = map;

            notifyListeners();
            break;

          default:
            {
              debugPrint('Got unexpected package ${pkg.id}');
              _conn!.close();

              _state = ServerState.error;
              _error = Exception('Got unexpected package ${pkg.id}');
              _conn = null;

              notifyListeners();
              return;
            }
        }
      }
    } catch (e) {
      _conn!.close();

      _state = ServerState.error;
      _error = e;
      _conn = null;
      notifyListeners();

      debugPrint('Listen error: $e');
      return;
    }
  }
}
