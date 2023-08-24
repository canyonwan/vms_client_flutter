import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    refreshController.finishRefresh();
    refreshController.resetFooter();
  }
}
