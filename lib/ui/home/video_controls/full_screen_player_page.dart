import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayerPage extends StatefulWidget {
  int? duration;
  FullScreenPlayerPage({Key? key,this.duration}) : super(key: key);

  @override
  State<FullScreenPlayerPage> createState() => _FullScreenPlayerPageState();
}

class _FullScreenPlayerPageState extends State<FullScreenPlayerPage> {
  late VideoPlayerController _controller;
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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    _controller = VideoPlayerController.network("https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4");
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {
      _controller.seekTo(Duration(seconds: widget.duration ?? 0));
      _controller.play();
    }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            children: [
              VideoPlayer(_controller),
              Padding(
                padding: const EdgeInsets.only(top: 40,right: 60),
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
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customControls(_controller),
              VideoProgressIndicator(_controller, allowScrubbing: true),
            ],
          ),
        ],
      ),
    );
  }

  customControls(VideoPlayerController controller){
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
                          Navigator.pop(context,sec);
                        },
                        child: const Icon(
                          // ? Icons.fullscreen_exit
                          //     :
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
