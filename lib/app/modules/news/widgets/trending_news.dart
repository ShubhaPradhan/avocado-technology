import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_portal/app/config/colors.dart';
import 'package:news_portal/app/config/constants.dart';
import 'package:news_portal/app/modules/news/news_controller.dart';

import 'news_tile.dart';

class TrendingNews extends StatelessWidget {
  final newsController = Get.put(NewsController());
  TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          newsController.getNews();
        },
        color: primaryColor,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount:
              // newsController.newsApiResponse.value.response!.news!.length,
              8,
          itemBuilder: (context, index) => const NewsTile(
            // title: newsController
            // .newsApiResponse.value.response!.news![index].title,
            title: 'fdsfd',
          ),
        ),
      ),
    );
  }
}
