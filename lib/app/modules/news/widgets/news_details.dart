import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../widgets/top_bar.dart';
import 'custom_video_player.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
