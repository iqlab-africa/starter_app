import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'StepRuns.g.dart';

@JsonSerializable()
class StepRuns {

  @JsonKey(name: 'has_more')
  bool? hasMore;
  String? next;
  List<Data>? data;

  StepRuns(this.hasMore, this.next, this.data);

  factory StepRuns.fromJson(Map<String, dynamic> json) =>
      _$StepRunsFromJson(json);

  Map<String, dynamic> toJson() => _$StepRunsToJson(this);
}
@JsonSerializable()
class Data {
  String? id;
  @JsonKey(name: 'started_at')
  String? startedAt;
  @JsonKey(name: 'ended_at')
  String? endedAt;
  String? state;
  @JsonKey(name: 'state_updated_at')
  String? stateUpdatedAt;
  dynamic error;
  Step? step;
  int? duration;

  Data(this.id, this.startedAt, this.endedAt, this.state, this.stateUpdatedAt,
      this.error, this.step, this.duration);

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Step {
  String? id;
  String? name;

  Step(this.id, this.name);

  factory Step.fromJson(Map<String, dynamic> json) =>
      _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}