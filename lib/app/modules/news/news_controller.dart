import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_portal/app/data/news_response.dart';
import 'package:news_portal/app/services/api_client.dart';
import 'package:news_portal/repository/news_repo.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewsController extends GetxController {
  final newsApiResponse = ApiResponse<NewsResponse>.initial().obs;
  final newsRepo = NewsRepository();

  final isNewsLoading = false.obs;

  final isVideoPressed = false.obs;

  @override
  void onInit() async {
    super.onInit();
    getNews();
  }

  void getNews() async {
    isNewsLoading.value = true;
    newsApiResponse.value = ApiResponse.loading();
    final response = await newsRepo.getNews();
    if (response.status == ApiStatus.SUCCESS) {
      isNewsLoading.value = false;
      newsApiResponse.value = response;
    } else {
      isNewsLoading.value = false;
      Get.snackbar(
        "Error",
        response.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String formatTime(int duration) {
    // convert duration int to Duration object
    final durations = Duration(seconds: duration);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(durations.inHours);
    final minutes = twoDigits(durations.inMinutes.remainder(60));
    final seconds = twoDigits(durations.inSeconds.remainder(60));

    return [
      if (durations.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  Widget randomizeVideoSource(int randNo) {
    // randomly return either YouTube, Facebook, ABC News, TOP News or Youtube type 2

    switch (randNo) {
      case 0:
        return const VideoSourceType(
          color: Color(0xFFCD201F),
          image: 'assets/images/youtube.png',
          text: 'Youtube',
        );
      case 1:
        return const VideoSourceType(
          color: Color(0xFF0F5EA2),
          image: 'assets/images/facebook.png',
          text: 'Facebook',
        );
      case 2:
        return const VideoSourceType(
          color: Color(0xFF17AF4E),
          image: 'assets/images/abc_news.png',
          text: 'ABC news',
        );

      case 3:
        return const VideoSourceType(
          color: Color(0xFF812082),
          image: 'assets/images/top_news.png',
          text: 'TOP NEWS',
        );

      case 4:
        return const VideoSourceType(
          color: Color(0xFFCD201F),
          image: 'assets/images/chevron-left.png',
          text: 'Youtube',
        );

      default:
        return const VideoSourceType(
          color: Color(0xFFCD201F),
          image: 'assets/images/chevron-left.png',
          text: 'Youtube',
        );
    }
  }
}

class VideoSourceType extends StatelessWidget {
  const VideoSourceType({
    super.key,
    required this.color,
    required this.image,
    required this.text,
  });

  final Color color;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.5.w,
        vertical: 0.6.h,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            color: Colors.white,
            height: 1.3.h,
            width: 1.3.h,
          ),
          SizedBox(
            width: 1.8.w,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
