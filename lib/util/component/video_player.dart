// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_ott/util/component/back_button.dart';
// import 'package:video_viewer/video_viewer.dart';
// import '../app_colors.dart';
//
// class MoviePlayer extends StatefulWidget {
//   String url;
//    MoviePlayer({Key? key,required this.url}) : super(key: key);
//
//   @override
//   State<MoviePlayer> createState() => _MoviePlayerState();
// }
//
//
// class _MoviePlayerState extends State<MoviePlayer> {
//   //final VideoViewerController controller = VideoViewerController();
//   final controller = VideoViewerController();
//   @override
//   void initState(){
//     super.initState();
//     controller.video?.initialize().then((value) =>{
//     controller.video?.seekTo(Duration(seconds: 20)),
//       controller.video?.play(),
//     } );
//
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     print(">>>>>Min ${controller.position}");
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bg,
//       body:   Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           VideoViewer(
//             controller: controller,
//             autoPlay: true,
//             source: {
//               "video": VideoSource(
//                 video: VideoPlayerController.network(widget.url),
//                /* ads: [
//                   VideoViewerAd(
//                     fractionToStart: 0,
//                     child: Container(
//                       color: Colors.black,
//                       child: Center(
//                           child: Text(
//                         "AD ZERO",
//                         style: TextStyle(fontSize: 16, color: AppColors.white),
//                       )),
//                     ),
//                     durationToSkip: Duration.zero,
//                   ),
//                   VideoViewerAd(
//                     fractionToStart: 0.5,
//                     child: Container(
//                       color: Colors.black,
//                       child: Center(
//                           child: Text("AD HALF",
//                               style: TextStyle(
//                                   fontSize: 16, color: AppColors.white))),
//                     ),
//                     durationToSkip: Duration(seconds: 4),
//                   ),
//                 ],*/
//               )
//             },
//           ),
//         ],
//       ),
//
//     );
//   }
// }
//
