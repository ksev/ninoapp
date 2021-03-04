///
//  Generated code. Do not modify.
//  source: net.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use helloDescriptor instead')
const Hello$json = const {
  '1': 'Hello',
  '2': const [
    const {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'retention', '3': 3, '4': 1, '5': 7, '10': 'retention'},
    const {'1': 'pwm0', '3': 4, '4': 1, '5': 2, '10': 'pwm0'},
    const {'1': 'pwm1', '3': 5, '4': 1, '5': 2, '10': 'pwm1'},
  ],
};

/// Descriptor for `Hello`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloDescriptor = $convert.base64Decode('CgVIZWxsbxIYCgd2ZXJzaW9uGAEgASgJUgd2ZXJzaW9uEhIKBG5hbWUYAiABKAlSBG5hbWUSHAoJcmV0ZW50aW9uGAMgASgHUglyZXRlbnRpb24SEgoEcHdtMBgEIAEoAlIEcHdtMBISCgRwd20xGAUgASgCUgRwd20x');
@$core.Deprecated('Use sensorsDescriptor instead')
const Sensors$json = const {
  '1': 'Sensors',
  '2': const [
    const {'1': 'sensors', '3': 1, '4': 3, '5': 11, '6': '.nino.net.Sensors.Sensor', '10': 'sensors'},
  ],
  '3': const [Sensors_Sensor$json],
};

@$core.Deprecated('Use sensorsDescriptor instead')
const Sensors_Sensor$json = const {
  '1': 'Sensor',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 7, '10': 'id'},
    const {'1': 'alias', '3': 2, '4': 1, '5': 9, '10': 'alias'},
    const {'1': 'unit', '3': 3, '4': 1, '5': 9, '10': 'unit'},
    const {'1': 'rate', '3': 6, '4': 1, '5': 7, '10': 'rate'},
    const {'1': 'values', '3': 7, '4': 3, '5': 1, '10': 'values'},
    const {'1': 'source', '3': 8, '4': 1, '5': 9, '9': 0, '10': 'source'},
    const {'1': 'error', '3': 9, '4': 1, '5': 9, '9': 1, '10': 'error'},
  ],
  '8': const [
    const {'1': 'optional_source'},
    const {'1': 'optional_error'},
  ],
};

/// Descriptor for `Sensors`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorsDescriptor = $convert.base64Decode('CgdTZW5zb3JzEjIKB3NlbnNvcnMYASADKAsyGC5uaW5vLm5ldC5TZW5zb3JzLlNlbnNvclIHc2Vuc29ycxrFAQoGU2Vuc29yEg4KAmlkGAEgASgHUgJpZBIUCgVhbGlhcxgCIAEoCVIFYWxpYXMSEgoEdW5pdBgDIAEoCVIEdW5pdBISCgRyYXRlGAYgASgHUgRyYXRlEhYKBnZhbHVlcxgHIAMoAVIGdmFsdWVzEhgKBnNvdXJjZRgIIAEoCUgAUgZzb3VyY2USFgoFZXJyb3IYCSABKAlIAVIFZXJyb3JCEQoPb3B0aW9uYWxfc291cmNlQhAKDm9wdGlvbmFsX2Vycm9y');
@$core.Deprecated('Use sensorConfigDescriptor instead')
const SensorConfig$json = const {
  '1': 'SensorConfig',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 7, '10': 'id'},
    const {'1': 'alias', '3': 2, '4': 1, '5': 9, '10': 'alias'},
    const {'1': 'unit', '3': 3, '4': 1, '5': 9, '10': 'unit'},
    const {'1': 'rate', '3': 6, '4': 1, '5': 7, '9': 0, '10': 'rate'},
    const {'1': 'source', '3': 7, '4': 1, '5': 9, '9': 1, '10': 'source'},
  ],
  '8': const [
    const {'1': 'optional_rate'},
    const {'1': 'optional_source'},
  ],
};

/// Descriptor for `SensorConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sensorConfigDescriptor = $convert.base64Decode('CgxTZW5zb3JDb25maWcSDgoCaWQYASABKAdSAmlkEhQKBWFsaWFzGAIgASgJUgVhbGlhcxISCgR1bml0GAMgASgJUgR1bml0EhQKBHJhdGUYBiABKAdIAFIEcmF0ZRIYCgZzb3VyY2UYByABKAlIAVIGc291cmNlQg8KDW9wdGlvbmFsX3JhdGVCEQoPb3B0aW9uYWxfc291cmNl');
@$core.Deprecated('Use valueDescriptor instead')
const Value$json = const {
  '1': 'Value',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 7, '10': 'id'},
    const {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `Value`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List valueDescriptor = $convert.base64Decode('CgVWYWx1ZRIOCgJpZBgBIAEoB1ICaWQSFAoFdmFsdWUYAiABKAFSBXZhbHVl');
@$core.Deprecated('Use setPwmDescriptor instead')
const SetPwm$json = const {
  '1': 'SetPwm',
  '2': const [
    const {'1': 'channel', '3': 1, '4': 1, '5': 14, '6': '.nino.net.SetPwm.Channel', '10': 'channel'},
    const {'1': 'value', '3': 2, '4': 1, '5': 2, '10': 'value'},
  ],
  '4': const [SetPwm_Channel$json],
};

@$core.Deprecated('Use setPwmDescriptor instead')
const SetPwm_Channel$json = const {
  '1': 'Channel',
  '2': const [
    const {'1': 'Pwm0', '2': 0},
    const {'1': 'Pwm1', '2': 1},
  ],
};

/// Descriptor for `SetPwm`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPwmDescriptor = $convert.base64Decode('CgZTZXRQd20SMgoHY2hhbm5lbBgBIAEoDjIYLm5pbm8ubmV0LlNldFB3bS5DaGFubmVsUgdjaGFubmVsEhQKBXZhbHVlGAIgASgCUgV2YWx1ZSIdCgdDaGFubmVsEggKBFB3bTAQABIICgRQd20xEAE=');
