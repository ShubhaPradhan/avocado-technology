import 'dart:developer';

import 'package:news_portal/app/data/news_response.dart';
import 'package:news_portal/app/services/api_client.dart';

import '../app/config/api_end_point.dart';

class NewsRepository {
  Future<ApiResponse<NewsResponse>> getNews() async {
    log("IN NEWS REPO");
    final response = await ApiClient().getApi(
      ApiUrls.newsUrl,
      fromJson: (json) => NewsResponse.fromJson(json),
    );

    return response;
  }
}
