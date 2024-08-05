import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:starter_app/models/VideoBotResult.dart';

import '../models/Artifact.dart';
import '../models/ProcessRuns.dart';
import '../models/Processes.dart';
import '../models/StepRunArtifacts.dart';
import '../models/StepRuns.dart';
import '../models/process_run.dart';
import '../models/step_run.dart';
import '../util/util.dart';

class HttpService {
  final http.Client client;

  static const mm = '☘️☘️☘️HttpService ☘️ ';

  HttpService(
      {required this.robocorpApiKey,
      required this.keyPrefix,
      required this.robocorpUrl,
      required this.webBackendUrl,
      required this.client, required this.headers});

  final Map<String, String> headers;

  final String robocorpApiKey, keyPrefix, robocorpUrl, webBackendUrl;

/*
https://cloud.robocorp.com/api/v1/workspaces/
b9e7c782-dccb-47a0-bbf7-f69bb1cbf084/processes/process-runs

curl --request GET "https://cloud.robocorp.com/api/v1/workspaces/fbec8d03-198f-40fc-ab86-b416cdf9cc1d/processes" --header "Authorization: RC-WSKEY aR3OtnoigC9h0sv5XVkqXbqf9rz9zZCZXGV2YWueSb7ciwqMwIguWmVLjmcA0VYPXwG10U8QinF7dtIcB2rZz4Pa42CbAhrIFEW8HcPsw1luz5jbupaWb0axhSfxU"
 */
  Future<String?> startBot(String processId) async {
    pp('$mm startBot ... processId: $processId');
    String? resultId;
    var mUrl = '${robocorpUrl}processes/$processId/process-runs';
    pp('$mm calling $mUrl ...');
    var resp = await client.post(Uri.parse(mUrl), headers: headers);
    pp('$mm startBot, statusCode: ${resp.statusCode} \n ${resp.body}');
    if (resp.statusCode == 200) {
      var m = jsonDecode(resp.body);
      pp('$mm resultId: ${m['id']}');
      var started = m['started'] as bool;
      if (started) {
        resultId = m['id'];
        pp('$mm  videoBot has started, processId: $resultId');
      } else {
        throw Exception('Bot failed to start');
      }
    }
    return resultId;
  }
  Future<String?> stopBot(String processId) async {
    pp('$mm stopBot ... processId: $processId');
    // String? resultId;
    // var mUrl = '${robocorpUrl}processes/$processId/process-runs';
    // pp('$mm calling $mUrl ...');
    // var resp = await client.post(Uri.parse(mUrl), headers: headers);
    // pp('$mm startBot, statusCode: ${resp.statusCode} \n ${resp.body}');
    // if (resp.statusCode == 200) {
    //   var m = jsonDecode(resp.body);
    //   pp('$mm resultId: ${m['id']}');
    //   var started = m['started'] as bool;
    //   if (started) {
    //     resultId = m['id'];
    //     pp('$mm  videoBot has started, processId: $resultId');
    //   } else {
    //     throw Exception('Bot failed to start');
    //   }
    // }
    return null;
  }

  Future<ProcessRun?> getProcessRun(String processRunId) async {
    pp('$mm getProcessRun ... processRunId: $processRunId');

    ProcessRun? processRun;
    var mUrl = '${robocorpUrl}process-runs/$processRunId';
    pp('$mm calling $mUrl ...');
    var resp = await client.get(Uri.parse(mUrl), headers: headers);
    pp('$mm getProcessRun, statusCode: ${resp.statusCode} \n ${resp.body}');
    if (resp.statusCode == 200) {
      var m = jsonDecode(resp.body);
      processRun = ProcessRun.fromJson(m);
    }
    return processRun;
  }

  Future<StepRuns?> listStepRuns(String processRunId) async {
    pp('$mm listStepRuns ...');

    StepRuns? stepRuns;
    var mUrl = '${robocorpUrl}step-runs?process_run_id=$processRunId';
    pp('$mm calling $mUrl ...');
    var resp = await client.get(Uri.parse(mUrl), headers: headers);
    pp('$mm listStepRuns, statusCode: ${resp.statusCode} \n ${resp.body}');
    if (resp.statusCode == 200) {
      stepRuns = StepRuns.fromJson(jsonDecode(resp.body));
      pp('$mm stepRuns: ${stepRuns.data!.length}');
      for (var p in stepRuns.data!) {
        pp('$mm listStepRuns: stepRun: ${p.toJson()}');
      }
    }
    return stepRuns;
  }

  Future<List<VideoBotResult>> getVideoBotResult({int? limit}) async {
    pp('$mm getVideoBotResult: getting videos from Firestore ...');
    limit ??= 48;

    List<VideoBotResult> list = [];
    pp('$mm ..... downloading videoBot results from firestore, 🥦 limit: $limit video docs ... 🥦 ');
    try {
      var mUrl = '${webBackendUrl}getBotVideos?limit=$limit&orderBy=searched';
      var resp = await client.get(Uri.parse(mUrl), headers: {});
      pp('$mm getVideoBotResult, statusCode: 🍎 ${resp.statusCode} 🍎 ');
      if (resp.statusCode == 200) {
        var decodedResponse = jsonDecode(resp.body);
        if (decodedResponse is List) {
          for (var json in decodedResponse) {
            var botResult = VideoBotResult.fromJson(json);
            list.add(botResult);
          }
        } else {
          pp('$mm ERROR: Response is not a list');
          throw Exception('Response is not a list');
        }
        pp('\n\n$mm botResult: 🔴${list.length} 🔴 videos found. ');
      }
    } catch (e, s) {
      pp('$mm ERROR: $e \n$s');
      throw Exception('Results failed');
    }
    return list;
  }

  Future<StepRun?> getStepRun(String stepRunId) async {
    pp('$mm getStepRun ...');

    StepRun? stepRun;
    var mUrl = '${robocorpUrl}step-runs/$stepRunId';
    pp('$mm calling $mUrl ...');
    var resp = await client.get(Uri.parse(mUrl), headers: headers);
    pp('$mm getStepRun, statusCode: ${resp.statusCode} \n ${resp.body}');
    if (resp.statusCode == 200) {
      stepRun = StepRun.fromJson(jsonDecode(resp.body));
      pp('$mm getStepRun: stepRun: ${stepRun.toJson()}');
    }
    return stepRun;
  }

  Future<Artifact?> getStepRunArtifact(
      String stepRunId, String artifactId) async {
    pp('$mm getStepRunArtifact ... stepRunId: $stepRunId  artifactId: $artifactId');

    Artifact? artifact;
    var mUrl = '${robocorpUrl}step-runs/$stepRunId/artifacts/$artifactId';
    pp('$mm calling $mUrl ...');
    var resp = await client.get(Uri.parse(mUrl), headers: headers);
    pp('$mm getStepRunArtifact, statusCode: ${resp.statusCode} \n ${resp.body}');
    if (resp.statusCode == 200) {
      artifact = Artifact.fromJson(jsonDecode(resp.body));
      pp('$mm artifact: ${artifact.toJson()}');
    }
    return artifact;
  }

  Future<StepRunArtifacts?> listStepRunArtifacts(String stepRunId) async {
    pp('$mm ... listStepRunArtifacts ... stepRunId: $stepRunId');

    StepRunArtifacts? stepRuns;
    var mUrl = '${robocorpUrl}step-runs/$stepRunId/artifacts';
    pp('$mm calling $mUrl ...');
    var resp = await client.get(Uri.parse(mUrl), headers: headers);
    pp('$mm listStepRunArtifacts,  🥦 statusCode: ${resp.statusCode}  🥦\n ${resp.body}');
    if (resp.statusCode == 200) {
      stepRuns = StepRunArtifacts.fromJson(jsonDecode(resp.body));
      pp('$mm listStepRunArtifacts:  found: ${stepRuns.data?.length}');
      for (var p in stepRuns.data!) {
        pp('$mm artifact: ${p.toJson()}');
      }
    }
    return stepRuns;
  }

  Future<ProcessRuns?> listProcessRuns() async {
    pp('$mm listProcessRuns ...');

    ProcessRuns? processRuns;
    var mUrl = '${robocorpUrl}process-runs/';
    pp('$mm calling $mUrl ...');
    var resp = await client.get(Uri.parse(mUrl), headers: headers);
    pp('$mm listProcessRuns, statusCode: ${resp.statusCode} \n ${resp.body}');
    if (resp.statusCode == 200) {
      processRuns = ProcessRuns.fromJson(jsonDecode(resp.body));
      pp('$mm processRuns: ${processRuns.data?.length}');
      for (var p in processRuns.data!) {
        pp('$mm processRun: ${p.toJson()}');
      }
    }
    return processRuns;
  }

  Future<Processes?> listProcesses() async {
    pp('$mm listProcesses ...');

    Processes? processes;
    var mUrl = '${robocorpUrl}processes/';
    pp('$mm calling $mUrl ...');
    var resp = await client.get(Uri.parse(mUrl), headers: headers);
    pp('$mm processes, statusCode: ${resp.statusCode} \n ${resp.body}');
    if (resp.statusCode == 200) {
      processes = Processes.fromJson(jsonDecode(resp.body));
      pp('$mm processes: ${processes.data?.length}');
      for (var p in processes.data!) {
        pp('$mm process: ${p.toJson()}');
      }
    }
    return processes;
  }
}
