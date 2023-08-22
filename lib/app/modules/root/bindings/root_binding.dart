import 'package:get/get.dart';
import 'package:vms_client_flutter/app/modules/home/controllers/home_controller.dart';

import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
