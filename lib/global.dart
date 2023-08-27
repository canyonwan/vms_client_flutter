import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/services/index.dart';
import 'package:vms_client_flutter/store/index.dart';

import 'brnTheme.dart';

class Global {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    BrnInitializer.register(allThemeConfig: BrnThemeConfig.defaultAllConfig);
    await Future.wait([
      Get.putAsync<StorageService>(() => StorageService().init()),
    ]).whenComplete(() {
      Get.put<HttpService>(HttpService());
      Get.put<ConfigStore>(ConfigStore());
      Get.put<UserStore>(UserStore());
    });
  }
}
