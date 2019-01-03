// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthorResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorResultModel _$AuthorResultModelFromJson(Map<String, dynamic> json) {
  return AuthorResultModel(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : AuthorModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$AuthorResultModelToJson(AuthorResultModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
