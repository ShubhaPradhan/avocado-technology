import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_portal/app/config/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../widgets/top_bar.dart';
import 'custom_video_player.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({
    super.key,
    required this.title,
    required this.description,
  });

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(
              title: 'Post',
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/favourite.png',
                    height: 3.h,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/share.png',
                    height: 3.h,
                  ),
                ),
              ],
            ),
            const CustomVideoPlayer(),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              'assets/images/chevron-left.png',
                              color: Colors.white,
                              height: 1.5.h,
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
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    title ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    description ?? '',
                    style: TextStyle(
                      fontSize: 15.sp,
                      height: 1.7,
                      fontWeight: FontWeight.w400,
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
