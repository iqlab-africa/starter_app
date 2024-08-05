
import 'package:json_annotation/json_annotation.dart';
part 'process_run.g.dart';
@JsonSerializable()

class ProcessRun {
  String? id, state;
  Process? process;
  int? duration;
  @JsonKey(name: 'started_at')
  String? startedAt;
  @JsonKey(name: 'ended_at')
  String? endedAt;
  @JsonKey(name: 'created_at')
  String? createdAt;
  StartedBy? startedBy;

  ProcessRun(this.id, this.state, this.process, this.duration, this.startedAt,
      this.endedAt, this.createdAt, this.startedBy);

  factory ProcessRun.fromJson(Map<String, dynamic> json) =>
      _$ProcessRunFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessRunToJson(this);
}

@JsonSerializable()
class Process {
  String? id, name;

  Process(this.id, this.name);
  factory Process.fromJson(Map<String, dynamic> json) =>
      _$ProcessFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessToJson(this);
}

@JsonSerializable()
class StartedBy {
  String? type;
  dynamic details;

  StartedBy(this.type, this.details);
  factory StartedBy.fromJson(Map<String, dynamic> json) =>
      _$StartedByFromJson(json);

  Map<String, dynamic> toJson() => _$StartedByToJson(this);
}
