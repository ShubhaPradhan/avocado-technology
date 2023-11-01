import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'news_details.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.title,
    required this.description,
  });

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewsDetails(
              title: title,
              description: description,
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.5.w,
                    vertical: 0.6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCD201F),
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/youtube.png',
                        color: Colors.white,
                        height: 1.3.h,
                      ),
                      SizedBox(
                        width: 1.8.w,
                      ),
                      Text(
                        'Youtube',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
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
            Stack(
              children: [
                // image with play button
                Container(
                  height: 20.h,
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
          ],
        ),
      ),
    );
  }
}
