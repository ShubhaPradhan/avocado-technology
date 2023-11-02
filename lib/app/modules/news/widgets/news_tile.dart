import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_portal/app/modules/news/news_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'news_details.dart';

class NewsTile extends StatelessWidget {
  final newsController = Get.put(NewsController());
  NewsTile({
    super.key,
    required this.title,
    required this.description,
  });

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomInt = random.nextInt(5);
    final randomVideoType = newsController.randomizeVideoSource(
      randomInt,
    );
    return GestureDetector(
      onTap: () {
        Get.to(() => NewsDetails(
              title: title,
              description: description,
              videoType: randomVideoType,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFE5E5E5),
          ),
        ),
        padding: EdgeInsets.all(
          1.3.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                await launchUrl(
                  Uri.parse(
                      "https://www.youtube.com/watch?v=Pmg2PtMwhgs&ab_channel=NTVPLUS"),
                  mode: LaunchMode.externalApplication,
                );
              },
              child: SizedBox(
                height: 8.h,
                child: Text(
                  title ?? '',
                  style: TextStyle(
                    fontSize: 13.6.sp,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                randomVideoType,
                const Spacer(),
                Text(
                  '1 hour ago',
                  style: TextStyle(
                    color: const Color(0xFF9B9B9B),
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Stack(
                children: [
                  // image with play button
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/demo-thumbnail.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // play button
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/play-btn.png',
                        height: 12.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
