import 'package:get/get.dart';

import '../controllers/circle_controller.dart';

class CircleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CircleController>(
      () => CircleController(),
    );
  }
}
