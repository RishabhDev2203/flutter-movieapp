import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';
import '../app_colors.dart';

class VideoPlayer extends StatefulWidget {
  String? url;
   VideoPlayer({Key? key,this.url}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body:  BetterPlayer.network(widget.url?.replaceAll("https", "http")??"",
        betterPlayerConfiguration: const BetterPlayerConfiguration(
          fit: BoxFit.contain,
          autoPlay: true,
          overlay: ButtonBack()
        ),
      ),
    );
  }
}
