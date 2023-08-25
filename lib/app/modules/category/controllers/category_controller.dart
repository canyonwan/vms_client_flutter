import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/app/api/index.dart';
import 'package:vms_client_flutter/app/model/goods_category_model.dart';
import 'package:vms_client_flutter/app/model/goods_page_model.dart';

class CategoryController extends GetxController {
  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );
  List<GoodsCategoryItemModel> list = [];
  List<GoodsCategoryItemModel> subCateList = [];
  int currentCateId = 0;
  int currentSubCateId = 0;

  int page = 1;
  int pageSize = 10;
  int total = 0;
  List<GoodsItemModel> goodsList = [];

  bool loadingData = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getGoodsCategoryTree();
  }

  // 获取商品分类树
  Future<void> getGoodsCategoryTree() async {
    var r = await queryGoodsCategoryTree();
    if (r.list.isNotEmpty) {
      currentCateId = r.list.first.id;
      getGoodsPage();
      if (r.list.first.children != null && r.list.first.children!.isNotEmpty) {
        currentSubCateId = r.list.first.children!.first.id;
        subCateList = r.list.first.children!;
      }
      list = r.list;
    }
    update();
  }

  // 获取商品分页
  Future<void> getGoodsPage() async {
    var res = await queryGoodsPage(
        page: page,
        size: pageSize,
        categoryIds: '$currentCateId,$currentSubCateId');
    total = res.total;
    if (res.content != null && res.content!.isNotEmpty) {
      goodsList.addAll(res.content!);
    }
    loadingData = false;
    update();
  }

  Future<void> onLoadMore() async {
    if (goodsList.length == total) {
      refreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    page++;
    await getGoodsPage();
    refreshController.finishLoad(IndicatorResult.success);
  }

  void onChangeCate(GoodsCategoryItemModel item) {
    goodsList.clear();
    currentCateId = item.id;
    currentSubCateId = 0;
    subCateList = item.children ?? [];
    page = 1;
    loadingData = true;
    getGoodsPage();
    update();
  }
}
