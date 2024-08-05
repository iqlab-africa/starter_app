import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'Artifact.g.dart';

@JsonSerializable()
class Artifact {

  String? id, name, url;
  int? size;


  Artifact(this.id, this.name, this.url, this.size);

  factory Artifact.fromJson(Map<String, dynamic> json) =>
      _$ArtifactFromJson(json);

  Map<String, dynamic> toJson() => _$ArtifactToJson(this);
}
