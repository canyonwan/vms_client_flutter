import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/app/routes/app_pages.dart';
import 'package:vms_client_flutter/app/widgets/index.dart';
import 'package:vms_client_flutter/const/common.dart';
import 'package:vms_client_flutter/theme.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('商品分类'), centerTitle: true),
      body: GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (c) {
          return Row(
            children: [
              _buildLeftBox(c, colorScheme),
              Expanded(
                child: Container(
                  height: Get.height,
                  decoration: BoxDecoration(
                      // color: colorScheme.surface,
                      ),
                  child: Column(
                    children: [
                      if (c.subCateList.isNotEmpty)
                        _buildSubCateBox(colorScheme, c),
                      Expanded(
                        child: c.loadingData
                            ? BrnPageLoading()
                            : c.goodsList.isEmpty
                                ? CustomEmpty(title: Text('暂无相关商品'))
                                : _buildHasData(c, colorScheme),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  EasyRefresh _buildHasData(CategoryController c, ColorScheme colorScheme) {
    return EasyRefresh.builder(
      controller: c.refreshController,
      onLoad: c.onLoadMore,
      childBuilder: (context, physic) {
        return ListView(
          physics: physic,
          children: c.goodsList
              .map(
                (i) => Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppTheme.kBorderRadius),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppTheme.kBorderRadius),
                        child: Image.network(
                          kImgUrl + i.files![0].fileUrl!,
                          width: 90.w,
                          height: 90.w,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: SizedBox(
                          height: 90.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                i.name!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13.sp),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 4.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.w),
                                  color: AppTheme.kPriceColor.withOpacity(.2),
                                ),
                                child: Text(
                                  '主治：${i.desc}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: AppTheme.kPriceColor,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: '￥',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.redAccent),
                                      children: [
                                        TextSpan(
                                          text: '100.00',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: AppTheme.kPriceColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.toNamed(
                                        Routes.GOODS_DETAIL,
                                        arguments: i.id),
                                    child: Container(
                                      padding: EdgeInsets.all(4.w),
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary,
                                        borderRadius: BorderRadius.circular(
                                            AppTheme.kBorderRadius),
                                      ),
                                      child: Text(
                                        '查看详情',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Container _buildSubCateBox(ColorScheme colorScheme, CategoryController c) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: colorScheme.background,
      ),
      child: Row(
          children: c.subCateList
              .map((e) => CustomTag(
                    text: Text(e.categoryName),
                  ))
              .toList()),
    );
  }

  Container _buildLeftBox(CategoryController c, ColorScheme colorScheme) {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        // border: Border(
        //   right: BorderSide(
        //     color: colorScheme.onBackground.withOpacity(0.08),
        //     width: 1.w,
        //   ),
        // ),
        color: colorScheme.surface,
      ),
      width: 90.w,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => c.onChangeCate(c.list[index]),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: c.currentCateId != c.list[index].id
                    ? colorScheme.surface
                    : colorScheme.background,
              ),
              child: Text(
                c.list[index].categoryName,
                style: TextStyle(
                  color: c.currentCateId == c.list[index].id
                      ? AppTheme.primary
                      : AppTheme.kAppSubGrey99Color,
                  fontWeight: c.currentCateId == c.list[index].id
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        },
        itemCount: c.list.length,
      ),
    );
  }
}
