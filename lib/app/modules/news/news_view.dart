import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_portal/app/config/colors.dart';
import 'package:news_portal/app/config/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/top_bar.dart';
import 'news_controller.dart';
import 'widgets/trending_news.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView>
    with SingleTickerProviderStateMixin {
  final newsController = Get.put(NewsController());
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              title: 'Video',
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/search.png',
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
            DefaultTabController(
              animationDuration: const Duration(milliseconds: 300),
              length: 4,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 2.h,
                  bottom: 2.h,
                  left: horizontalPadding,
                  right: horizontalPadding,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x00cccccc).withOpacity(1),
                        offset: const Offset(0, 3),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Theme(
                    data: theme.copyWith(
                      colorScheme: theme.colorScheme.copyWith(
                        surfaceVariant: Colors.transparent,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 1.h,
                      ),
                      labelColor: Colors.black,
                      dragStartBehavior: DragStartBehavior.start,
                      isScrollable: true,
                      indicator: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: tabActiveColor,
                            width: 0.4.h,
                          ),
                        ),
                      ),
                      splashFactory: NoSplash.splashFactory,
                      unselectedLabelColor: Colors.black,
                      physics: const BouncingScrollPhysics(),
                      tabs: const [
                        Tab(
                          text: "Trending",
                          key: Key("Trending"),
                        ),
                        Tab(
                          text: "Trending",
                          key: Key("Trending"),
                        ),
                        Tab(
                          text: "Trending Feature",
                          key: Key("Trending Feature"),
                        ),
                        Tab(
                          text: "Trending",
                          key: Key("Trending"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => newsController.isNewsLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : TabBarView(
                        controller: _tabController,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          TrendingNews(),
                          TrendingNews(),
                          TrendingNews(),
                          TrendingNews(),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
