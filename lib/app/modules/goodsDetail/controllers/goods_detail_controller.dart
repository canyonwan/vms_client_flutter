import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vms_client_flutter/app/api/index.dart';
import 'package:vms_client_flutter/app/model/goods_detail_model.dart';

class GoodsDetailController extends GetxController
    with StateMixin<GoodsDetailDataModel> {
  int goodsId = 0;
  bool isListLayout = true;

  GoodsDetailDataModel goodsDetail = GoodsDetailDataModel();

  @override
  void onInit() {
    goodsId = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getGoodsDetail();
  }

  Future<void> getGoodsDetail() async {
    change(null, status: RxStatus.loading());
    final res = await queryGoodsDetail(goodsId);
    goodsDetail = res;
    if (res.id != null) {
      change(res, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error('加载失败'));
    }
  }

  Future<void> contactService(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

// 切换layout
  void changeLayout() {
    isListLayout = !isListLayout;
    update();
  }
}
