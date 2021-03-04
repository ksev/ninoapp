///
//  Generated code. Do not modify.
//  source: net.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'net.pbenum.dart';

export 'net.pbenum.dart';

class Hello extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Hello', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'nino.net'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'version')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'retention', $pb.PbFieldType.OF3)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pwm0', $pb.PbFieldType.OF)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pwm1', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  Hello._() : super();
  factory Hello({
    $core.String? version,
    $core.String? name,
    $core.int? retention,
    $core.double? pwm0,
    $core.double? pwm1,
  }) {
    final _result = create();
    if (version != null) {
      _result.version = version;
    }
    if (name != null) {
      _result.name = name;
    }
    if (retention != null) {
      _result.retention = retention;
    }
    if (pwm0 != null) {
      _result.pwm0 = pwm0;
    }
    if (pwm1 != null) {
      _result.pwm1 = pwm1;
    }
    return _result;
  }
  factory Hello.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Hello.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Hello clone() => Hello()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Hello copyWith(void Function(Hello) updates) => super.copyWith((message) => updates(message as Hello)) as Hello; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Hello create() => Hello._();
  Hello createEmptyInstance() => create();
  static $pb.PbList<Hello> createRepeated() => $pb.PbList<Hello>();
  @$core.pragma('dart2js:noInline')
  static Hello getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Hello>(create);
  static Hello? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get retention => $_getIZ(2);
  @$pb.TagNumber(3)
  set retention($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRetention() => $_has(2);
  @$pb.TagNumber(3)
  void clearRetention() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get pwm0 => $_getN(3);
  @$pb.TagNumber(4)
  set pwm0($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPwm0() => $_has(3);
  @$pb.TagNumber(4)
  void clearPwm0() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get pwm1 => $_getN(4);
  @$pb.TagNumber(5)
  set pwm1($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPwm1() => $_has(4);
  @$pb.TagNumber(5)
  void clearPwm1() => clearField(5);
}

enum Sensors_Sensor_OptionalSource {
  source, 
  notSet
}

enum Sensors_Sensor_OptionalError {
  error, 
  notSet
}

class Sensors_Sensor extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Sensors_Sensor_OptionalSource> _Sensors_Sensor_OptionalSourceByTag = {
    8 : Sensors_Sensor_OptionalSource.source,
    0 : Sensors_Sensor_OptionalSource.notSet
  };
  static const $core.Map<$core.int, Sensors_Sensor_OptionalError> _Sensors_Sensor_OptionalErrorByTag = {
    9 : Sensors_Sensor_OptionalError.error,
    0 : Sensors_Sensor_OptionalError.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Sensors.Sensor', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'nino.net'), createEmptyInstance: create)
    ..oo(0, [8])
    ..oo(1, [9])
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OF3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alias')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unit')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rate', $pb.PbFieldType.OF3)
    ..p<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'values', $pb.PbFieldType.PD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error')
    ..hasRequiredFields = false
  ;

  Sensors_Sensor._() : super();
  factory Sensors_Sensor({
    $core.int? id,
    $core.String? alias,
    $core.String? unit,
    $core.int? rate,
    $core.Iterable<$core.double>? values,
    $core.String? source,
    $core.String? error,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (alias != null) {
      _result.alias = alias;
    }
    if (unit != null) {
      _result.unit = unit;
    }
    if (rate != null) {
      _result.rate = rate;
    }
    if (values != null) {
      _result.values.addAll(values);
    }
    if (source != null) {
      _result.source = source;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory Sensors_Sensor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Sensors_Sensor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Sensors_Sensor clone() => Sensors_Sensor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Sensors_Sensor copyWith(void Function(Sensors_Sensor) updates) => super.copyWith((message) => updates(message as Sensors_Sensor)) as Sensors_Sensor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Sensors_Sensor create() => Sensors_Sensor._();
  Sensors_Sensor createEmptyInstance() => create();
  static $pb.PbList<Sensors_Sensor> createRepeated() => $pb.PbList<Sensors_Sensor>();
  @$core.pragma('dart2js:noInline')
  static Sensors_Sensor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Sensors_Sensor>(create);
  static Sensors_Sensor? _defaultInstance;

  Sensors_Sensor_OptionalSource whichOptionalSource() => _Sensors_Sensor_OptionalSourceByTag[$_whichOneof(0)]!;
  void clearOptionalSource() => clearField($_whichOneof(0));

  Sensors_Sensor_OptionalError whichOptionalError() => _Sensors_Sensor_OptionalErrorByTag[$_whichOneof(1)]!;
  void clearOptionalError() => clearField($_whichOneof(1));

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get alias => $_getSZ(1);
  @$pb.TagNumber(2)
  set alias($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAlias() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlias() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get unit => $_getSZ(2);
  @$pb.TagNumber(3)
  set unit($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnit() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnit() => clearField(3);

  @$pb.TagNumber(6)
  $core.int get rate => $_getIZ(3);
  @$pb.TagNumber(6)
  set rate($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(6)
  $core.bool hasRate() => $_has(3);
  @$pb.TagNumber(6)
  void clearRate() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.double> get values => $_getList(4);

  @$pb.TagNumber(8)
  $core.String get source => $_getSZ(5);
  @$pb.TagNumber(8)
  set source($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(8)
  $core.bool hasSource() => $_has(5);
  @$pb.TagNumber(8)
  void clearSource() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get error => $_getSZ(6);
  @$pb.TagNumber(9)
  set error($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(9)
  $core.bool hasError() => $_has(6);
  @$pb.TagNumber(9)
  void clearError() => clearField(9);
}

class Sensors extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Sensors', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'nino.net'), createEmptyInstance: create)
    ..pc<Sensors_Sensor>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sensors', $pb.PbFieldType.PM, subBuilder: Sensors_Sensor.create)
    ..hasRequiredFields = false
  ;

  Sensors._() : super();
  factory Sensors({
    $core.Iterable<Sensors_Sensor>? sensors,
  }) {
    final _result = create();
    if (sensors != null) {
      _result.sensors.addAll(sensors);
    }
    return _result;
  }
  factory Sensors.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Sensors.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Sensors clone() => Sensors()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Sensors copyWith(void Function(Sensors) updates) => super.copyWith((message) => updates(message as Sensors)) as Sensors; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Sensors create() => Sensors._();
  Sensors createEmptyInstance() => create();
  static $pb.PbList<Sensors> createRepeated() => $pb.PbList<Sensors>();
  @$core.pragma('dart2js:noInline')
  static Sensors getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Sensors>(create);
  static Sensors? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Sensors_Sensor> get sensors => $_getList(0);
}

enum SensorConfig_OptionalRate {
  rate, 
  notSet
}

enum SensorConfig_OptionalSource {
  source, 
  notSet
}

class SensorConfig extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SensorConfig_OptionalRate> _SensorConfig_OptionalRateByTag = {
    6 : SensorConfig_OptionalRate.rate,
    0 : SensorConfig_OptionalRate.notSet
  };
  static const $core.Map<$core.int, SensorConfig_OptionalSource> _SensorConfig_OptionalSourceByTag = {
    7 : SensorConfig_OptionalSource.source,
    0 : SensorConfig_OptionalSource.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SensorConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'nino.net'), createEmptyInstance: create)
    ..oo(0, [6])
    ..oo(1, [7])
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OF3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alias')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unit')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rate', $pb.PbFieldType.OF3)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..hasRequiredFields = false
  ;

  SensorConfig._() : super();
  factory SensorConfig({
    $core.int? id,
    $core.String? alias,
    $core.String? unit,
    $core.int? rate,
    $core.String? source,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (alias != null) {
      _result.alias = alias;
    }
    if (unit != null) {
      _result.unit = unit;
    }
    if (rate != null) {
      _result.rate = rate;
    }
    if (source != null) {
      _result.source = source;
    }
    return _result;
  }
  factory SensorConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorConfig clone() => SensorConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorConfig copyWith(void Function(SensorConfig) updates) => super.copyWith((message) => updates(message as SensorConfig)) as SensorConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SensorConfig create() => SensorConfig._();
  SensorConfig createEmptyInstance() => create();
  static $pb.PbList<SensorConfig> createRepeated() => $pb.PbList<SensorConfig>();
  @$core.pragma('dart2js:noInline')
  static SensorConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorConfig>(create);
  static SensorConfig? _defaultInstance;

  SensorConfig_OptionalRate whichOptionalRate() => _SensorConfig_OptionalRateByTag[$_whichOneof(0)]!;
  void clearOptionalRate() => clearField($_whichOneof(0));

  SensorConfig_OptionalSource whichOptionalSource() => _SensorConfig_OptionalSourceByTag[$_whichOneof(1)]!;
  void clearOptionalSource() => clearField($_whichOneof(1));

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get alias => $_getSZ(1);
  @$pb.TagNumber(2)
  set alias($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAlias() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlias() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get unit => $_getSZ(2);
  @$pb.TagNumber(3)
  set unit($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnit() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnit() => clearField(3);

  @$pb.TagNumber(6)
  $core.int get rate => $_getIZ(3);
  @$pb.TagNumber(6)
  set rate($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(6)
  $core.bool hasRate() => $_has(3);
  @$pb.TagNumber(6)
  void clearRate() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get source => $_getSZ(4);
  @$pb.TagNumber(7)
  set source($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(7)
  $core.bool hasSource() => $_has(4);
  @$pb.TagNumber(7)
  void clearSource() => clearField(7);
}

class Value extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Value', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'nino.net'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OF3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Value._() : super();
  factory Value({
    $core.int? id,
    $core.double? value,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory Value.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Value.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Value clone() => Value()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Value copyWith(void Function(Value) updates) => super.copyWith((message) => updates(message as Value)) as Value; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Value create() => Value._();
  Value createEmptyInstance() => create();
  static $pb.PbList<Value> createRepeated() => $pb.PbList<Value>();
  @$core.pragma('dart2js:noInline')
  static Value getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Value>(create);
  static Value? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class SetPwm extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetPwm', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'nino.net'), createEmptyInstance: create)
    ..e<SetPwm_Channel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OE, defaultOrMaker: SetPwm_Channel.Pwm0, valueOf: SetPwm_Channel.valueOf, enumValues: SetPwm_Channel.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  SetPwm._() : super();
  factory SetPwm({
    SetPwm_Channel? channel,
    $core.double? value,
  }) {
    final _result = create();
    if (channel != null) {
      _result.channel = channel;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory SetPwm.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPwm.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPwm clone() => SetPwm()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPwm copyWith(void Function(SetPwm) updates) => super.copyWith((message) => updates(message as SetPwm)) as SetPwm; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetPwm create() => SetPwm._();
  SetPwm createEmptyInstance() => create();
  static $pb.PbList<SetPwm> createRepeated() => $pb.PbList<SetPwm>();
  @$core.pragma('dart2js:noInline')
  static SetPwm getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetPwm>(create);
  static SetPwm? _defaultInstance;

  @$pb.TagNumber(1)
  SetPwm_Channel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(SetPwm_Channel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

