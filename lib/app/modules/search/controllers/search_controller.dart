import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController {
  //TODO: Implement SearchController
  final textEditingController = TextEditingController();
  final focusNode = FocusNode();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
