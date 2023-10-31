import 'package:flutter/material.dart';
import 'package:news_portal/app/config/colors.dart';
import 'package:pod_player/pod_player.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        'https://www.youtube.com/watch?v=Pmg2PtMwhgs&ab_channel=NTVPLUS',
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(
      controller: controller,
      alwaysShowProgressBar: false,
      onLoading: (
        context,
      ) {
        return const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        );
      },
      // overlayBuilder: ,
      podProgressBarConfig: PodProgressBarConfig(
        backgroundColor: progressBarColor,
        height: 0.6.h,
        padding: EdgeInsets.only(
          left: 3.w,
          right: 3.w,
          top: 0,
          bottom: 2.h,
        ),
        curveRadius: 50,
        playingBarColor: primaryColor,
        alwaysVisibleCircleHandler: true,
        circleHandlerColor: primaryColor,
        circleHandlerRadius: 1.1.h,
        bufferedBarColor: progressBarColor,
      ),
    );
  }
}
