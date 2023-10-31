import 'package:get/get.dart';

import 'news_controller.dart';

class NewsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NewsController(),
    );
  }
}
