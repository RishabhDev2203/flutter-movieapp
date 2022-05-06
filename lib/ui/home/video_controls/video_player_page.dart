import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:video_player/video_player.dart';

import 'full_screen_player_page.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  late Future<void> initalizeVideoPlayerFuture;
  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];
  
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network("https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4");
    _controller.addListener(() {
      setState(() {});
    });
    initalizeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {
    }));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBg,
      body:  FutureBuilder(
        future: initalizeVideoPlayerFuture,
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              children: [
                SizedBox(
                  child: VideoPlayer(_controller),
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30,right: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton<double>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (speed) {
                        _controller.setPlaybackSpeed(speed);
                      },
                      itemBuilder: (context) {
                        return [
                          for (final speed in _examplePlaybackRates)
                            PopupMenuItem(
                              value: speed,
                              child: Text(
                                '${speed}x',
                              ),
                            )
                        ];
                      },
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
            _controlsOverlay(_controller),
            VideoProgressIndicator(_controller, allowScrubbing: true),
          ],
        ),
      );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
        }),
    );
  }

  _controlsOverlay(VideoPlayerController controller){
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.black26,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 50),
                  reverseDuration: const Duration(milliseconds: 200),
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          var position = await controller.position;

                          controller.seekTo(Duration(seconds: position!.inSeconds - 5));
                        },
                        child: const Icon(
                          Icons.replay_5,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      controller.value.isPlaying
                          ? MaterialButton(
                        child: const Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () {
                          controller.value.isPlaying
                              ? controller.pause()
                              : controller.play();
                        },
                      )
                          : MaterialButton(
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () {
                          controller.value.isPlaying
                              ? controller.pause()
                              : controller.play();
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          var position = await controller.position;

                          controller.seekTo(Duration(seconds: position!.inSeconds + 5));
                        },
                        child: const Icon(
                          Icons.forward_5,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                         var sec = await timer();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreenPlayerPage(duration: sec))).then((value) => {
                          _controller.initialize().then((_) => setState(() {
                            _controller.seekTo(Duration(seconds: value ?? 0));
                            _controller.play();
                          })),
                          SystemChrome.setPreferredOrientations(
                          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]),
                          });
                        },
                        child: const Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  timer() async {
    Duration? duration = await _controller.position;
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    int twoDigitMinutes = int.parse(twoDigits(duration!.inMinutes.remainder(60)));
    int twoDigitSeconds = int.parse(twoDigits(duration.inSeconds.remainder(60)));
    var min = (twoDigitMinutes)*60;
    var sec = twoDigitSeconds + min;
    return sec;
  }
}

