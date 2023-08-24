import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/const/resource.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  const RootView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(builder: (c) {
      return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: c.pageController,
          onPageChanged: (index) => c.setCurrentIndex(index),
          children: c.pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: c.currentIndex,
          onTap: (index) {
            c.jumpPage(index);
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: const Color.fromRGBO(123, 123, 123, 1),
          items: [
            BottomNavigationBarItem(
              label: 'home'.tr,
              icon: Image.asset(
                R.ASSETS_TABBAR_HOME_PNG,
                width: 25.w,
                height: 25.0.w,
              ),
              activeIcon: Image.asset(
                R.ASSETS_TABBAR_HOME_ED_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
            ),
            BottomNavigationBarItem(
              label: 'category'.tr,
              icon: Image.asset(
                R.ASSETS_TABBAR_CATEGORY_PNG,
                width: 25.w,
                height: 25.0.w,
              ),
              activeIcon: Image.asset(
                R.ASSETS_TABBAR_CATEGORY_ED_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
            ),
            BottomNavigationBarItem(
              label: 'circle'.tr,
              icon: Image.asset(
                R.ASSETS_TABBAR_CIRCLE_PNG,
                width: 25.w,
                height: 25.0.w,
              ),
              activeIcon: Image.asset(
                R.ASSETS_TABBAR_CIRCLE_ED_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
            ),
            BottomNavigationBarItem(
              label: 'cart'.tr,
              icon: Image.asset(
                R.ASSETS_TABBAR_CART_PNG,
                width: 25.w,
                height: 25.0.w,
              ),
              activeIcon: Image.asset(
                R.ASSETS_TABBAR_CART_ED_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
            ),
            BottomNavigationBarItem(
              label: 'mine'.tr,
              icon: Image.asset(
                R.ASSETS_TABBAR_MINE_PNG,
                width: 25.w,
                height: 25.0.w,
              ),
              activeIcon: Image.asset(
                R.ASSETS_TABBAR_MINE_ED_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
            ),
          ],
        ),
      );
    });
  }
}
