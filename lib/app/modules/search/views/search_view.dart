import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/theme.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchViewController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(fontSize: 12.sp),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.w,
                            horizontal: 10.w,
                          ),
                          hintText: 'searchKeywords'.tr,
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: AppTheme.kAppSubGrey99Color,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppTheme.kBorderRadiusRound),
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.w),
                            borderSide: BorderSide.none,
                          ),
                          suffix: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.clear,
                              size: 14.sp,
                              color: AppTheme.kAppSubGrey99Color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: Get.back,
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppTheme.kBorderRadiusRound),
                  color: AppTheme.primary,
                ),
                child: Text('search'.tr,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: AppTheme.kWhiteColor)),
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'SearchView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
