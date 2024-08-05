// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StepRuns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepRuns _$StepRunsFromJson(Map<String, dynamic> json) => StepRuns(
      json['has_more'] as bool?,
      json['next'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StepRunsToJson(StepRuns instance) => <String, dynamic>{
      'has_more': instance.hasMore,
      'next': instance.next,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'] as String?,
      json['started_at'] as String?,
      json['ended_at'] as String?,
      json['state'] as String?,
      json['state_updated_at'] as String?,
      json['error'],
      json['step'] == null
          ? null
          : Step.fromJson(json['step'] as Map<String, dynamic>),
      (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'state': instance.state,
      'state_updated_at': instance.stateUpdatedAt,
      'error': instance.error,
      'step': instance.step,
      'duration': instance.duration,
    };

Step _$StepFromJson(Map<String, dynamic> json) => Step(
      json['id'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
