import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/app/api/index.dart';
import 'package:vms_client_flutter/app/model/goods_page_model.dart';
import 'package:vms_client_flutter/app/model/home_banner_model.dart';

class HomeController extends GetxController {
  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  // banner list
  List<HomeBanneItemModel> bannerList = [];

  // new goods list
  List<GoodsItemModel> newGoodsList = [];

  // hot goods list
  List<GoodsItemModel> hotGoodsList = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getHomeBanners();
    getNewGoodsList('20');
    getNewGoodsList('21');
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    refreshController.finishRefresh();
    refreshController.resetFooter();
  }

  Future<void> getHomeBanners() async {
    final r = await queryHomeBanners();
    if (r.list != null && r.list!.isNotEmpty) {
      bannerList = r.list!;
      update();
    }
  }

  // 新品上市
  Future<void> getNewGoodsList(categoryId) async {
    final r = await queryGoodsPage(page: 1, size: 5, categoryIds: categoryId);
    if (r.content != null && r.content!.isNotEmpty) {
      categoryId == '21'
          ? hotGoodsList = r.content!
          : newGoodsList = r.content!;
      update();
    }
  }
}
