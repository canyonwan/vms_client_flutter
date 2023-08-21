import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/app/modules/cart/views/cart_view.dart';
import 'package:vms_client_flutter/app/modules/category/views/category_view.dart';
import 'package:vms_client_flutter/app/modules/circle/views/circle_view.dart';
import 'package:vms_client_flutter/app/modules/home/views/home_view.dart';
import 'package:vms_client_flutter/app/modules/mine/views/mine_view.dart';

class RootController extends GetxController {
  PageController pageController = PageController();

  List<Widget> pages = <Widget>[
    const HomeView(),
    const CategoryView(),
    const CircleView(),
    const CartView(),
    const MineView(),
  ];

  int currentIndex = 0;

  void setCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  void jumpPage(int index) {
    currentIndex = index;
    pageController.jumpToPage(currentIndex);
    update();
  }
}
