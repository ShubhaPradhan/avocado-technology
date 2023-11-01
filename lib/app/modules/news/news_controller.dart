import 'dart:developer';

import 'package:get/get.dart';
import 'package:news_portal/app/data/news_response.dart';
import 'package:news_portal/app/services/api_client.dart';
import 'package:news_portal/repository/news_repo.dart';

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
    log("getNews");
    isNewsLoading.value = true;
    newsApiResponse.value = ApiResponse.loading();
    final response = await newsRepo.getNews();
    if (response.status == ApiStatus.SUCCESS) {
      isNewsLoading.value = false;
      newsApiResponse.value = response;
      log("Response: ${response.response!.news![0].title}");
    } else {
      isNewsLoading.value = false;
      Get.snackbar(
        "Error",
        response.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
