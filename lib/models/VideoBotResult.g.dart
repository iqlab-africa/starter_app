// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoBotResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoBotResult _$VideoBotResultFromJson(Map<String, dynamic> json) =>
    VideoBotResult(
      json['snippet'] as String?,
      json['id'] as String?,
      json['title'] as String?,
      json['link'] as String?,
      json['imageUrl'] as String?,
      (json['position'] as num?)?.toInt(),
      json['date'] as String?,
      (json['searched'] as num?)?.toDouble(),
      json['attributes'] == null
          ? null
          : Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoBotResultToJson(VideoBotResult instance) =>
    <String, dynamic>{
      'snippet': instance.snippet,
      'id': instance.id,
      'title': instance.title,
      'link': instance.link,
      'imageUrl': instance.imageUrl,
      'position': instance.position,
      'date': instance.date,
      'searched': instance.searched,
      'attributes': instance.attributes,
    };

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      json['Duration'] as String?,
      json['Posted'] as String?,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'Duration': instance.duration,
      'Posted': instance.posted,
    };
