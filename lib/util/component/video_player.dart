import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';
import 'package:video_viewer/video_viewer.dart';
import '../app_colors.dart';

class MoviePlayer extends StatefulWidget {
  String url;
   MoviePlayer({Key? key,required this.url}) : super(key: key);

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}


class _MoviePlayerState extends State<MoviePlayer> {
  final VideoViewerController controller = VideoViewerController();
  //var watchVideo="0:00:09.490000";
  @override
  void initState() {
    //controller.seekTo(Duration(seconds: 20));
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
    print(">>>>>Min ${controller.position}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body:   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VideoViewer(
            controller: controller,
            autoPlay: true,
            source: {
              "SubRip Text": VideoSource(
                video: VideoPlayerController.network(widget.url),
              )
            },
          ),
        ],
      ),

    );
  }
}
