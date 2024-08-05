import 'dart:convert';
/// next : null
/// has_more : false
/// data : [{"id":"796262b4-49c9-43f2-ba27-829fd49dd21e","state":"completed","process":{"id":"27e881fa-6982-4029-bf42-926f7589be57","name":"VideoSearch"},"duration":64,"started_at":"2024-08-03T20:40:08.605Z","started_by":{"type":"api","details":null},"created_at":"2024-08-03T20:40:08.458Z","ended_at":"2024-08-03T20:41:12.089Z"},{"id":"9145e127-af87-4896-9fc6-7f9fda7f9c8e","state":"completed","process":{"id":"27e881fa-6982-4029-bf42-926f7589be57","name":"VideoSearch"},"duration":64,"started_at":"2024-08-03T20:27:58.344Z","started_by":{"type":"api","details":null},"created_at":"2024-08-03T20:27:58.210Z","ended_at":"2024-08-03T20:29:01.454Z"},{"id":"152c1072-eddb-4ebd-b6e0-6535cf670f61","state":"completed","process":{"id":"27e881fa-6982-4029-bf42-926f7589be57","name":"VideoSearch"},"duration":60,"started_at":"2024-08-03T19:46:26.984Z","started_by":{"type":"api","details":null},"created_at":"2024-08-03T19:46:26.841Z","ended_at":"2024-08-03T19:47:26.077Z"},{"id":"78bb0176-9c7b-4c69-b9a8-d53c7805edda","state":"completed","process":{"id":"27e881fa-6982-4029-bf42-926f7589be57","name":"VideoSearch"},"duration":62,"started_at":"2024-08-03T19:39:27.836Z","started_by":{"type":"api","details":null},"created_at":"2024-08-03T19:39:27.688Z","ended_at":"2024-08-03T19:40:28.941Z"},{"id":"6a26c4b5-89fa-4ac4-bfa9-ba37c3eb8d98","state":"completed","process":{"id":"27e881fa-6982-4029-bf42-926f7589be57","name":"VideoSearch"},"duration":49,"started_at":"2024-08-03T18:49:08.979Z","started_by":{"type":"user","details":{"id":"process-api-start-default","first_name":"Aubrey","last_name":"Malabie"}},"created_at":"2024-08-03T18:49:08.848Z","ended_at":"2024-08-03T18:49:57.666Z"},{"id":"af9ae8e3-70a8-4e2c-a87e-bc428093322f","state":"completed","process":{"id":"27e881fa-6982-4029-bf42-926f7589be57","name":"VideoSearch"},"duration":692,"started_at":"2024-08-03T18:35:19.881Z","started_by":{"type":"user","details":{"id":"process-api-start-default","first_name":"Aubrey","last_name":"Malabie"}},"created_at":"2024-08-03T18:35:19.550Z","ended_at":"2024-08-03T18:46:51.269Z"}]

ProcessRuns processRunsFromJson(String str) => ProcessRuns.fromJson(json.decode(str));
String processRunsToJson(ProcessRuns data) => json.encode(data.toJson());
class ProcessRuns {
  ProcessRuns({
      dynamic next, 
      bool? hasMore, 
      List<Data>? data,}){
    _next = next;
    _hasMore = hasMore;
    _data = data;
}

  ProcessRuns.fromJson(dynamic json) {
    _next = json['next'];
    _hasMore = json['has_more'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  dynamic _next;
  bool? _hasMore;
  List<Data>? _data;
ProcessRuns copyWith({  dynamic next,
  bool? hasMore,
  List<Data>? data,
}) => ProcessRuns(  next: next ?? _next,
  hasMore: hasMore ?? _hasMore,
  data: data ?? _data,
);
  dynamic get next => _next;
  bool? get hasMore => _hasMore;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['next'] = _next;
    map['has_more'] = _hasMore;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "796262b4-49c9-43f2-ba27-829fd49dd21e"
/// state : "completed"
/// process : {"id":"27e881fa-6982-4029-bf42-926f7589be57","name":"VideoSearch"}
/// duration : 64
/// started_at : "2024-08-03T20:40:08.605Z"
/// started_by : {"type":"api","details":null}
/// created_at : "2024-08-03T20:40:08.458Z"
/// ended_at : "2024-08-03T20:41:12.089Z"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? state, 
      Process? process, 
      int? duration, 
      String? startedAt, 
      StartedBy? startedBy, 
      String? createdAt, 
      String? endedAt,}){
    _id = id;
    _state = state;
    _process = process;
    _duration = duration;
    _startedAt = startedAt;
    _startedBy = startedBy;
    _createdAt = createdAt;
    _endedAt = endedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _state = json['state'];
    _process = json['process'] != null ? Process.fromJson(json['process']) : null;
    _duration = json['duration'];
    _startedAt = json['started_at'];
    _startedBy = json['started_by'] != null ? StartedBy.fromJson(json['started_by']) : null;
    _createdAt = json['created_at'];
    _endedAt = json['ended_at'];
  }
  String? _id;
  String? _state;
  Process? _process;
  int? _duration;
  String? _startedAt;
  StartedBy? _startedBy;
  String? _createdAt;
  String? _endedAt;
Data copyWith({  String? id,
  String? state,
  Process? process,
  int? duration,
  String? startedAt,
  StartedBy? startedBy,
  String? createdAt,
  String? endedAt,
}) => Data(  id: id ?? _id,
  state: state ?? _state,
  process: process ?? _process,
  duration: duration ?? _duration,
  startedAt: startedAt ?? _startedAt,
  startedBy: startedBy ?? _startedBy,
  createdAt: createdAt ?? _createdAt,
  endedAt: endedAt ?? _endedAt,
);
  String? get id => _id;
  String? get state => _state;
  Process? get process => _process;
  int? get duration => _duration;
  String? get startedAt => _startedAt;
  StartedBy? get startedBy => _startedBy;
  String? get createdAt => _createdAt;
  String? get endedAt => _endedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['state'] = _state;
    if (_process != null) {
      map['process'] = _process?.toJson();
    }
    map['duration'] = _duration;
    map['started_at'] = _startedAt;
    if (_startedBy != null) {
      map['started_by'] = _startedBy?.toJson();
    }
    map['created_at'] = _createdAt;
    map['ended_at'] = _endedAt;
    return map;
  }

}

/// type : "api"
/// details : null

StartedBy startedByFromJson(String str) => StartedBy.fromJson(json.decode(str));
String startedByToJson(StartedBy data) => json.encode(data.toJson());
class StartedBy {
  StartedBy({
      String? type, 
      dynamic details,}){
    _type = type;
    _details = details;
}

  StartedBy.fromJson(dynamic json) {
    _type = json['type'];
    _details = json['details'];
  }
  String? _type;
  dynamic _details;
StartedBy copyWith({  String? type,
  dynamic details,
}) => StartedBy(  type: type ?? _type,
  details: details ?? _details,
);
  String? get type => _type;
  dynamic get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['details'] = _details;
    return map;
  }

}

/// id : "27e881fa-6982-4029-bf42-926f7589be57"
/// name : "VideoSearch"

Process processFromJson(String str) => Process.fromJson(json.decode(str));
String processToJson(Process data) => json.encode(data.toJson());
class Process {
  Process({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Process.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
Process copyWith({  String? id,
  String? name,
}) => Process(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}