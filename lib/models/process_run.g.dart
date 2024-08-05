// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessRun _$ProcessRunFromJson(Map<String, dynamic> json) => ProcessRun(
      json['id'] as String?,
      json['state'] as String?,
      json['process'] == null
          ? null
          : Process.fromJson(json['process'] as Map<String, dynamic>),
      (json['duration'] as num?)?.toInt(),
      json['started_at'] as String?,
      json['ended_at'] as String?,
      json['created_at'] as String?,
      json['startedBy'] == null
          ? null
          : StartedBy.fromJson(json['startedBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProcessRunToJson(ProcessRun instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'process': instance.process,
      'duration': instance.duration,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'created_at': instance.createdAt,
      'startedBy': instance.startedBy,
    };

Process _$ProcessFromJson(Map<String, dynamic> json) => Process(
      json['id'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$ProcessToJson(Process instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

StartedBy _$StartedByFromJson(Map<String, dynamic> json) => StartedBy(
      json['type'] as String?,
      json['details'],
    );

Map<String, dynamic> _$StartedByToJson(StartedBy instance) => <String, dynamic>{
      'type': instance.type,
      'details': instance.details,
    };
