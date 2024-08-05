import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../util/gaps.dart';

class Player extends StatefulWidget {
  const Player({super.key, required this.url});

  final String url;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    videoPlayerController.addListener((){
      if (videoPlayerController.value.isPlaying) {

      }
      if (videoPlayerController.value.isBuffering) {

      }
      if (videoPlayerController.value.isCompleted) {

      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController))
              : gapW32,
        ],
      ),
    );
  }
}
