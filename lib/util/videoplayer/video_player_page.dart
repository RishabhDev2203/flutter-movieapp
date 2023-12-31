import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_ott/bloc/cubit/home_cubit.dart';
import 'package:flutter_firebase_ott/util/videoplayer/full_screen_player_page.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import 'package:video_player/video_player.dart';
import '../app_colors.dart';
import '../constants.dart';

class VideoPlayerPage extends StatefulWidget {
  String url;
  bool? showAds;
  int? startedAt;
  String? id;

  VideoPlayerPage(
      {Key? key, required this.url, this.showAds, this.startedAt = 0, this.id})
      : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController? _controller;
  VideoPlayerController? _adsController;
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
  bool isSkipped = false;
  HomeCubit? addVideoCubit;
  HomeCubit? deleteVideoCubit;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int totalLength = 0;

  @override
  void initState() {
    super.initState();
    addVideoCubit = HomeCubit(HomeRepository());
    deleteVideoCubit = HomeCubit(HomeRepository());
    _adsController = VideoPlayerController.network(
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4");
    _adsController?.initialize().then((_) => setState(() {}));
    _adsController?.play();
    _controller = VideoPlayerController.network(widget.url);
    _controller?.initialize().then((_) => setState(() {
          String twoDigits(int n) => n.toString().padLeft(2, "0");
          int twoDigitMinutes = int.parse(
              twoDigits(_controller!.value.duration.inMinutes.remainder(60)));
          int twoDigitSeconds = int.parse(
              twoDigits(_controller!.value.duration.inSeconds.remainder(60)));
          var min = (twoDigitMinutes) * 60;
          totalLength = twoDigitSeconds + min;
          if (widget.startedAt != 0) {
            _controller?.seekTo(Duration(seconds: widget.startedAt ?? 0));
          }
          if (widget.showAds == false) {
            _controller?.play();
          }
        }));

    // Timer.periodic(const Duration(seconds: 5), (timer)async {
    //   Duration? duration = await _controller?.position;
    //   String twoDigits(int n) => n.toString().padLeft(2, "0");
    //   var sec = int.parse(twoDigits(duration?.inSeconds.remainder(60) ?? 0));
    //   if(sec > 10){
    //     isSkipped = false;
    //     _controller?.pause();
    //     _adsController = VideoPlayerController.network("https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4");
    //     _adsController?.initialize().then((_) => setState(() {
    //     }));
    //     _adsController?.play();
    //   }
    // });
  }

  @override
  Future<void> dispose() async {
    timer();
    _controller?.dispose();
    _adsController?.dispose();
    // addVideoCubit?.close();
    // deleteVideoCubit?.close();
    // addVideoCubit = null;
    // deleteVideoCubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            children: [
              SizedBox(
                child: VideoPlayer(isSkipped == false && widget.showAds == true
                    ? _adsController!
                    : _controller!),
                height: 300,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 6, right: 8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<double>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onSelected: (speed) {
                      _controller?.setPlaybackSpeed(speed);
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
          isSkipped == false && widget.showAds == true
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isSkipped = true;
                    });
                    _adsController?.dispose();
                    _controller?.play();
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.only(right: 10, bottom: 20),
                    child: const Text("Skip ads",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white)),
                  ),
                )
              : _controlsOverlay(_controller!),
          isSkipped == false && widget.showAds == true
              ? Container()
              : VideoProgressIndicator(_controller!, allowScrubbing: true),
        ],
      ),
    );
  }

  _controlsOverlay(VideoPlayerController controller) {
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
                          controller.seekTo(
                              Duration(seconds: position!.inSeconds - 5));
                          setState(() {});
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
                                setState(() {});
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
                                setState(() {});
                              },
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          var position = await controller.position;
                          controller.seekTo(
                              Duration(seconds: position!.inSeconds + 5));
                          setState(() {});
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
                                  builder: (context) => FullScreenPlayerPage(
                                        duration: sec,
                                        controller: _controller!,
                                      ))).then((value) => {
                                _controller = value,
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.portraitDown,
                                  DeviceOrientation.portraitUp
                                ]),
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
    Duration? duration = await _controller?.position;
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    int twoDigitMinutes =
        int.parse(twoDigits(duration!.inMinutes.remainder(60)));
    int twoDigitSeconds =
        int.parse(twoDigits(duration.inSeconds.remainder(60)));
    var min = (twoDigitMinutes) * 60;
    var sec = twoDigitSeconds + min;
    if (_controller?.value.position == _controller?.value.duration) {
      deleteVideoCubit?.deleteContinueWatching(
          widget.id, _auth.currentUser?.uid);
    } else {
      addVideoCubit?.addVideo(
          widget.id, sec, _auth.currentUser?.uid, totalLength);
    }
  }

  getRandomTimer() {
    int ads = 3;
    List<int> time = [];
    Random random = Random();
    for (int i = 0; i < ads; i++) {
      int randomNumber = random.nextInt(100);
      time.add(randomNumber);
    }
  }
}
