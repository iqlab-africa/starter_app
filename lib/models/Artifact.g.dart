// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Artifact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artifact _$ArtifactFromJson(Map<String, dynamic> json) => Artifact(
      json['id'] as String?,
      json['name'] as String?,
      json['url'] as String?,
      (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ArtifactToJson(Artifact instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'size': instance.size,
    };
