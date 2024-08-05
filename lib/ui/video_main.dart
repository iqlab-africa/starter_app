import 'dart:async';

import 'package:badges/badges.dart' as bd;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:starter_app/models/StepRunArtifacts.dart';
import 'package:starter_app/services/http_service.dart';
import 'package:starter_app/ui/web_player.dart';
import 'package:starter_app/util/dialogs.dart';
import 'package:starter_app/util/navigation_util.dart';
import 'package:starter_app/util/styles.dart';
import 'package:starter_app/util/toasts.dart';

import '../models/Artifact.dart';
import '../models/Processes.dart';
import '../models/StepRuns.dart' as st;
import '../models/VideoBotResult.dart';
import '../models/process_run.dart';
import '../util/gaps.dart';
import '../util/prefs.dart';
import '../util/util.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  HttpService httpService = GetIt.instance<HttpService>();
  static const mm = '🌸 VideoList 🌸 ';
  static const processName = 'VideoSearchProcess';

  String? processId, processRunId;
  ProcessRun? processRun;
  bool busy = false;
  List<VideoBotResult> videoBotResults = [];
  int defaultLimit = 10;
  bool isBotRunning = false;
  int runCount = 0;

  @override
  void initState() {
    super.initState();
    _getVideoBotResults();
  }

  Future _getVideoBotResults() async {
    pp('\n$mm getVideoBotResults from web backend ( 🥦🥦 with Firestore) ...');
    setState(() {
      isBotRunning = true;
    });
    try {
      defaultLimit = prefs.getLimit();
      videoBotResults =
          await httpService.getVideoBotResult(limit: defaultLimit);
      for (var v in videoBotResults) {
        pp('$mm title: ${v.title}  💜💜💜link: ${v.link}');
      }
      pp('\n\n$mm ... video results found:  💜 ${videoBotResults.length} videos  💜\n');
      setState(() {
        isBotRunning = false;
      });
      if (runCount == 0) {
        runCount++;
        _getProcesses();
        return;
      }
    } catch (e, s) {
      pp('$mm ERROR 👿 $e 👿\n 👿$s 👿');
      if (mounted) {
        showErrorDialog(context, '$e');
      }
    }
  }

  Processes? processes;

  Future _getProcesses() async {
    pp('$mm ... getting processes ...');
    processes = await httpService.listProcesses();
    for (var p in processes!.data!) {
      pp('$mm _getProcesses: process: ${p.toJson()}');
      if (p.name == processName) {
        processId = p.id;
        await _startBot();
      }
    }
  }

  Future<void> _startBot() async {
    pp('\n\n$mm _startBot: process:  🍎$processId)}');
    if (isBotRunning) {
      pp('$mm Bot is already running');
      showToast(
          message: 'VideoBoi is still running the last search request',
          context: context);
      return;
    }
    setState(() {
      isBotRunning = true;
      showLimits = false;
    });
    if (processId != null) {
      processRunId = await httpService.startBot(processId!);
      pp('$mm videoBot started:  🍎$processRunId');
      _poll();
    }
  }

  Future stopBot() async {
    httpService.stopBot(processId!);
    setState(() {
      isBotRunning = false;
    });
    pp('$mm VideoBot stopped ...');
    showToast(message: 'VideoBot has been stopped', context: context);
  }

  late Timer timer;

  void _poll() async {
    timer = Timer.periodic(const Duration(seconds: 10), (ticker) async {
      pp('\n\n$mm ... timer ticked: 🍎 🍎 🍎 🍎 🍎 🍎 🍎 ${ticker.tick} 🍎 ');
      processRun = await httpService.getProcessRun(processRunId!);
      pp('$mm processRun: ${processRun?.toJson()}');
      if (processRun?.state! == 'completed') {
        pp('\n\n$mm VideoBot has completed processing ... 🔵 🔵 get fresh results from Firestore\n\n');
        _stopTimer();
        _listStepRuns();
        setState(() {
          isBotRunning = false;
        });
        _getVideoBotResults();
      } else {
        pp('\n\n$mm videoBot is still running ......  🔵 🔵 ${processRun?.state} 🔵 🔵 \n');
      }
    });
  }

  StepRunArtifacts? stepRunArtifacts;
  st.StepRuns? stepRuns;
  st.Step? step;
  String? stepRunId;

  Future _listStepRuns() async {
    pp('\n$mm _listStepRuns .. processRunId: 🈂️ $processRunId ');
    stepRuns = await httpService.listStepRuns(processRunId!);
    for (var sr in stepRuns!.data!) {
      if (sr.step!.name == 'SearchStep') {
        pp('$mm ... searchStep: ${sr.step!.toJson()}');
        step = sr.step;
        stepRunId = sr.id;
        pp('$mm stepRunId: $stepRunId');
        await _listStepRunArtifacts();
      }
    }
  }

  Future _listStepRunArtifacts() async {
    pp('\n$mm _listStepRunArtifacts .. stepRunId: 🈂️ $stepRunId ');
    stepRunArtifacts = await httpService.listStepRunArtifacts(stepRunId!);
    for (var sr in stepRunArtifacts!.data!) {
      pp('$mm ... stepRunArtifact: ${sr.toJson()}');
    }
    pp('$mm videoBot artifacts found: ${stepRunArtifacts!.data!.length}  things ... '
        '🔵 🔵 will get videos from backend! ');
    if (stepRunArtifacts!.data!.isNotEmpty) {
      _getVideoBotResults();
    }
  }

  Artifact? artifact;

  void _stopTimer() {
    timer.cancel();
  }

  int groupValue = 10;
  Prefs prefs = GetIt.instance<Prefs>();

  _save(int limit) {
    pp('$mm limit radio button selected: $limit');
    prefs.saveLimit(limit);
    defaultLimit = limit;
    groupValue = limit;
    setState(() {});
  }

  _showLimitDialog() {
    setState(() {
      showLimits = !showLimits;
    });
  }

  bool showLimits = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IQLab VideoBot',
          style: myTextStyleMediumBold(context),
        ),
        actions: [
          isBotRunning
              ? const Padding(
                  padding: EdgeInsets.only(right: 28.0),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      backgroundColor: Colors.red,
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () {
                    _showLimitDialog();
                  },
                  icon:
                      const Icon(Icons.accessibility_sharp, color: Colors.blue))
        ],
      ),
      body: SafeArea(
        child: ScreenTypeLayout.builder(
          mobile: (ctx) {
            return bd.Badge(
              badgeContent: Text('${videoBotResults.length}'),
              position: bd.BadgePosition.topEnd(top: 6, end: 10),
              badgeStyle: const bd.BadgeStyle(padding: EdgeInsets.all(4)),
              child: showLimits
                  ? Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          gapH16,
                          const Padding(
                            padding: EdgeInsets.only(left: 24.0, right: 24),
                            child: Text(
                                'Number of Search Responses that you want the VideoBot to return where possible '),
                          ),
                          gapH32,
                          RadioListTile(
                              value: 10,
                              title: Text('10',
                                  style: myTextStyleMediumBold(context)),
                              groupValue: groupValue,
                              onChanged: (m) {
                                if (m != null) {
                                  _save(m);
                                }
                              }),
                          RadioListTile(
                              value: 20,
                              title: Text('20',
                                  style: myTextStyleMediumBold(context)),
                              groupValue: groupValue,
                              onChanged: (m) {
                                if (m != null) {
                                  _save(m);
                                }
                              }),
                          RadioListTile(
                              value: 30,
                              title: Text('30',
                                  style: myTextStyleMediumBold(context)),
                              groupValue: groupValue,
                              onChanged: (m) {
                                if (m != null) {
                                  _save(m);
                                }
                              }),
                          RadioListTile(
                              value: 40,
                              title: Text('40',
                                  style: myTextStyleMediumBold(context)),
                              groupValue: groupValue,
                              onChanged: (m) {
                                if (m != null) {
                                  _save(m);
                                }
                              }),
                          RadioListTile(
                              value: 50,
                              title: Text('50',
                                  style: myTextStyleMediumBold(context)),
                              groupValue: groupValue,
                              onChanged: (m) {
                                if (m != null) {
                                  _save(m);
                                }
                              }),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  showLimits = false;
                                });
                              },
                              child: const Text('Cancel')),
                          gapH32,
                          SizedBox(
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      elevation: WidgetStatePropertyAll(8.0)),
                                  onPressed: () {
                                    setState(() {
                                      showLimits = false;
                                    });
                                    _startBot();
                                  },
                                  child: const Text('Start VideoBot')),
                            ),
                          ),
                        ],
                      ),
                    )
                  : VideoBotList(
                      videoBotResults: videoBotResults,
                      isGrid: true,
                      onSelected: (v) {
                        pp('$mm video selected: 💛 💚 💙 ${v.toJson()}');
                        NavigationUtils.navigateToPage(
                            context: context,
                            widget: WebPlayer(videoUrl: v.link!));
                      }),
            );
          },
          tablet: (ctx) {
            return Row(
              children: [
                SizedBox(
                    width: (width / 2) - 24,
                    child: Container(color: Colors.blue)),
                SizedBox(
                  width: (width / 2) - 24,
                  child: VideoBotList(
                      videoBotResults: videoBotResults,
                      isGrid: true,
                      onSelected: (v) {
                        pp('$mm video selected: 💛 💚 💙 ${v.toJson()}');
                      }),
                ),
              ],
            );
          },
          desktop: (ctx) {
            return Row(
              children: [
                SizedBox(
                  width: (width / 2) - 24,
                  child: VideoBotList(
                      videoBotResults: videoBotResults,
                      isGrid: true,
                      onSelected: (v) {
                        pp('$mm video selected: 💛 💚 💙 ${v.toJson()}');
                      }),
                ),
                SizedBox(
                    width: (width / 2) - 24,
                    child: Container(color: Colors.green)),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.close, color: Colors.red), label: 'Stop Bot'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.orange),
              label: 'Start Bot'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              stopBot();
              break;
            case 1:
              _startBot();
              break;
          }
        },
      ),
    );
  }
}

class VideoBotList extends StatelessWidget {
  const VideoBotList(
      {super.key,
      required this.videoBotResults,
      required this.onSelected,
      required this.isGrid});

  final List<VideoBotResult> videoBotResults;
  final Function(VideoBotResult) onSelected;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: videoBotResults.length,
          itemBuilder: (_, index) {
            var vid = videoBotResults[index];
            return GestureDetector(
              onTap: () {
                onSelected(vid);
              },
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      vid.imageUrl == null
                          ? Image.asset('assets/img7.png',
                              height: 160, width: 160)
                          : CachedNetworkImage(
                              imageUrl: vid.imageUrl!,
                              fit: BoxFit.cover,
                              height: 160,
                              width: 160,
                              fadeInCurve: Curves.bounceIn,
                              fadeOutCurve: Curves.bounceOut,
                              errorListener: (err) {
                                pp('👿 ... image error: $err 👿');
                              },
                            ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: videoBotResults.length,
          itemBuilder: (_, index) {
            var vid = videoBotResults[index];
            return GestureDetector(
              onTap: () {
                onSelected(vid);
              },
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      vid.imageUrl == null
                          ? Image.asset('assets/img7.png',
                              height: 120, width: 120)
                          : CachedNetworkImage(
                              imageUrl: vid.imageUrl!,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                              fadeInCurve: Curves.bounceIn,
                              fadeOutCurve: Curves.bounceOut,
                              errorListener: (err) {
                                pp('👿 ... image error: $err 👿');
                              },
                            ),
                      gapW32,
                      Flexible(child: Text('${vid.title}'))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
