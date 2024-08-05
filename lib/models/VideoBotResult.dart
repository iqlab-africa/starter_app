import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'VideoBotResult.g.dart';
@JsonSerializable()

class VideoBotResult {
  String? snippet, id;
  String? title;
  String? link, imageUrl;
  int? position;
  String? date;
  double? searched;
  Attributes? attributes;


  VideoBotResult(this.snippet, this.id, this.title, this.link, this.imageUrl,
      this.position, this.date, this.searched, this.attributes);

  factory VideoBotResult.fromJson(Map<String, dynamic> json) =>
      _$VideoBotResultFromJson(json);

  Map<String, dynamic> toJson() => _$VideoBotResultToJson(this);
}

@JsonSerializable()
class Attributes {
  @JsonKey(name: 'Duration')
  String? duration;
  @JsonKey(name: 'Posted')
  String? posted;

  Attributes(this.duration, this.posted);

  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}