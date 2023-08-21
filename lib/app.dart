import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/const/colors.dart';
import 'package:vms_client_flutter/lan/Message.dart';

import 'app/routes/app_pages.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          navigatorObservers: [FlutterSmartDialog.observer],
          debugShowCheckedModeBanner: false,
          title: '兽用杂货铺',
          locale: Get.deviceLocale,
          translations: Messages(),
          // supportedLocales: [Locale('en'), Locale('zh', 'CN')],
          // locale: const Locale("zh", "CN"),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          // builder: EasyLoading.init(),
          builder: (ctx, child) {
            FlutterSmartDialog.init();
            ScreenUtil.init(ctx);
            // return child!;
            return Theme(
              data: ThemeData(
                primarySwatch: Colors.green,
                primaryColor: kAppColor,
                textTheme: TextTheme(bodyText2: TextStyle(fontSize: 30.sp)),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
