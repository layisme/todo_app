// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkErrorModel _$NetworkErrorModelFromJson(Map<String, dynamic> json) =>
    NetworkErrorModel(
      statusMessage: json['message'] as String?,
    );

Map<String, dynamic> _$NetworkErrorModelToJson(NetworkErrorModel instance) =>
    <String, dynamic>{
      'message': instance.statusMessage,
    };
