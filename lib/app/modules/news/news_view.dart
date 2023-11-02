import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:news_portal/app/config/colors.dart';
import 'package:news_portal/app/config/constants.dart';
import 'package:news_portal/app/widgets/no_internet_connection_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

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
              child: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  return connected ? child : const NoInternetConnectionWidget();
                },
                child: Obx(
                  () => newsController.isNewsLoading.value
                      ? const ShimmerNewsList()
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
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerNewsList extends StatelessWidget {
  const ShimmerNewsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: 10, // Number of grid items
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: newsTileBorderColor,
            ),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 2.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 2.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Container(
                      height: 3.h,
                      width: 10.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 2.h,
                      width: 5.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
