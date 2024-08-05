
import 'package:json_annotation/json_annotation.dart';

import 'StepRuns.dart';
part 'step_run.g.dart';
@JsonSerializable()

class StepRun {
  String? id, state;
  Step? process;
  int? duration;
  @JsonKey(name: 'started_at')
  String? startedAt;
  @JsonKey(name: 'ended_at')
  String? endedAt;

  @JsonKey(name: 'state_updated_at')
  String? stateUpdatedAt;
  Step? step;

  StepRun(this.id, this.state, this.process, this.duration, this.startedAt,
      this.endedAt, this.step);

  factory StepRun.fromJson(Map<String, dynamic> json) =>
      _$StepRunFromJson(json);

  Map<String, dynamic> toJson() => _$StepRunToJson(this);
}

// @JsonSerializable()
// class Step {
//   String? id, name;
//
//   Step(this.id, this.name);
//   factory Step.fromJson(Map<String, dynamic> json) =>
//       _$StepFromJson(json);
//
//   Map<String, dynamic> toJson() => _$StepToJson(this);
// }

