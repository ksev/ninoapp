///
//  Generated code. Do not modify.
//  source: net.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SetPwm_Channel extends $pb.ProtobufEnum {
  static const SetPwm_Channel Pwm0 = SetPwm_Channel._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Pwm0');
  static const SetPwm_Channel Pwm1 = SetPwm_Channel._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Pwm1');

  static const $core.List<SetPwm_Channel> values = <SetPwm_Channel> [
    Pwm0,
    Pwm1,
  ];

  static final $core.Map<$core.int, SetPwm_Channel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SetPwm_Channel valueOf($core.int value) => _byValue[value];

  const SetPwm_Channel._($core.int v, $core.String n) : super(v, n);
}

