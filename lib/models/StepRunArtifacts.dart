import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'StepRunArtifacts.g.dart';
@JsonSerializable()
class StepRunArtifacts {


  @JsonKey(name: 'has_more')
  bool? hasMore;
  dynamic next;
  List<Data>? data;

  StepRunArtifacts(this.hasMore, this.next, this.data);
  factory StepRunArtifacts.fromJson(Map<String, dynamic> json) =>
      _$StepRunArtifactsFromJson(json);

  Map<String, dynamic> toJson() => _$StepRunArtifactsToJson(this);
}

@JsonSerializable()
class Data {

  String? id;
  String? name;
  int? size;

  Data(this.id, this.name, this.size);

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}