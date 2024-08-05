// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Processes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Processes _$ProcessesFromJson(Map<String, dynamic> json) => Processes(
      json['has_more'] as bool?,
      json['next'],
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProcessesToJson(Processes instance) => <String, dynamic>{
      'has_more': instance.hasMore,
      'next': instance.next,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'] as String?,
      json['name'] as String?,
      json['created_at'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
    };
