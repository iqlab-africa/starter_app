// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StepRunArtifacts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepRunArtifacts _$StepRunArtifactsFromJson(Map<String, dynamic> json) =>
    StepRunArtifacts(
      json['has_more'] as bool?,
      json['next'],
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StepRunArtifactsToJson(StepRunArtifacts instance) =>
    <String, dynamic>{
      'has_more': instance.hasMore,
      'next': instance.next,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'] as String?,
      json['name'] as String?,
      (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
    };
