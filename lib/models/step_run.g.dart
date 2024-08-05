// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepRun _$StepRunFromJson(Map<String, dynamic> json) => StepRun(
      json['id'] as String?,
      json['state'] as String?,
      json['process'] == null
          ? null
          : Step.fromJson(json['process'] as Map<String, dynamic>),
      (json['duration'] as num?)?.toInt(),
      json['started_at'] as String?,
      json['ended_at'] as String?,
      json['step'] == null
          ? null
          : Step.fromJson(json['step'] as Map<String, dynamic>),
    )..stateUpdatedAt = json['state_updated_at'] as String?;

Map<String, dynamic> _$StepRunToJson(StepRun instance) => <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'process': instance.process,
      'duration': instance.duration,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'state_updated_at': instance.stateUpdatedAt,
      'step': instance.step,
    };
