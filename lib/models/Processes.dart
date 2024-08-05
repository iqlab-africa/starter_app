import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'Processes.g.dart';
@JsonSerializable()
class Processes {
  @JsonKey(name: 'has_more')
  bool? hasMore;
  dynamic next;
  List<Data>? data;

  Processes(this.hasMore, this.next, this.data);

  factory Processes.fromJson(Map<String, dynamic> json) =>
      _$ProcessesFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessesToJson(this);
}

/// id : "27e881fa-6982-4029-bf42-926f7589be57"
/// name : "VideoSearch"
/// created_at : "2024-08-03T18:34:21.322Z"


@JsonSerializable()
class Data {
  String? id;
  String? name;
  @JsonKey(name: 'created_at')
  String? createdAt;

  Data(this.id, this.name, this.createdAt);

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}