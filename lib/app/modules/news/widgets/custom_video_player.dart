import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_portal/app/config/colors.dart';
import 'package:news_portal/app/config/constants.dart';
import 'package:news_portal/app/modules/news/news_controller.dart';
import 'package:pod_player/pod_player.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  final newsController = Get.put(NewsController());
  late final PodPlayerController controller;

  Timer? _debounce;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        'https://www.youtube.com/watch?v=Pmg2PtMwhgs&ab_channel=NTVPLUS',
      ),
      podPlayerConfig: const PodPlayerConfig(
        isLooping: true,
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(
      videoAspectRatio: 16 / 9,
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
      overlayBuilder: (options) {
        return GestureDetector(
          onTap: () {
            newsController.isVideoPressed.value =
                !newsController.isVideoPressed.value;

            if (newsController.isVideoPressed.value) {
              if (_debounce?.isActive ?? false) {
                _debounce!.cancel();
              }
              _debounce = Timer(const Duration(milliseconds: 3000), () {
                newsController.isVideoPressed.value = false;
              });
            }
          },
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
            child: Obx(
              () => newsController.isVideoPressed.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.videoSeekTo(
                                      controller.currentVideoPosition -
                                          const Duration(seconds: 10),
                                    );
                                  },
                                  child: Container(
                                    height:
                                        controller.isFullScreen ? 10.h : 4.h,
                                    width: controller.isFullScreen ? 10.h : 4.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        controller.videoSeekTo(
                                          controller.currentVideoPosition -
                                              const Duration(seconds: 10),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.fast_rewind,
                                        color: Colors.white,
                                        size:
                                            controller.isFullScreen ? 5.h : 2.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              controller.isVideoBuffering
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Transform.scale(
                                        scale: controller.isFullScreen ? 2 : 1,
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                          color: Colors.grey,
                                          strokeWidth:
                                              controller.isFullScreen ? 2 : 3,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.togglePlayPause();
                                      },
                                      child: Container(
                                        height: controller.isFullScreen
                                            ? 16.h
                                            : 6.h,
                                        width: controller.isFullScreen
                                            ? 16.h
                                            : 6.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        child: Icon(
                                          controller.isVideoPlaying
                                              ? Icons.pause_outlined
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                          size: controller.isFullScreen
                                              ? 4.w
                                              : 4.h,
                                        ),
                                      ),
                                    ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.videoSeekTo(
                                      controller.currentVideoPosition +
                                          const Duration(seconds: 10),
                                    );
                                  },
                                  child: Container(
                                    height:
                                        controller.isFullScreen ? 10.h : 4.h,
                                    width: controller.isFullScreen ? 10.h : 4.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        controller.videoSeekTo(
                                          controller.currentVideoPosition +
                                              const Duration(seconds: 10),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.fast_forward,
                                        color: Colors.white,
                                        size:
                                            controller.isFullScreen ? 5.h : 2.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: horizontalPadding,
                            right: horizontalPadding,
                            top: 1.5.h,
                          ),
                          color: Colors.black.withOpacity(0.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${controller.currentVideoPosition.toString().split('.')[0]} / ${controller.totalVideoLength.toString().split('.')[0]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.isFullScreen) {
                                        controller.disableFullScreen(context);
                                        SystemChrome.setPreferredOrientations([
                                          DeviceOrientation.portraitUp,
                                        ]);
                                      } else {
                                        controller.enableFullScreen();
                                        SystemChrome.setPreferredOrientations([
                                          DeviceOrientation.landscapeLeft,
                                          DeviceOrientation.landscapeRight,
                                        ]);
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/images/full-screen.png',
                                      height:
                                          controller.isFullScreen ? 4.h : 2.h,
                                    ),
                                  )
                                ],
                              ),
                              SliderTheme(
                                data: SliderThemeData(
                                  trackShape: CustomTrackShape(),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.w, vertical: 0.h),
                                  child: Slider(
                                      activeColor: primaryColor,
                                      allowedInteraction:
                                          SliderInteraction.tapAndSlide,
                                      min: 0,
                                      max: controller.totalVideoLength.inSeconds
                                          .toDouble(),
                                      value: controller
                                          .currentVideoPosition.inSeconds
                                          .toDouble(),
                                      onChanged: (value) async {
                                        await controller.videoSeekTo(
                                          Duration(
                                            seconds: value.toInt(),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.transparent,
                    ),
            ),
          ),
        );
      },
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
