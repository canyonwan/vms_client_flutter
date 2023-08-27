import 'package:bruno/bruno.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/app/widgets/index.dart';
import 'package:vms_client_flutter/const/colors.dart';
import 'package:vms_client_flutter/const/common.dart';
import 'package:vms_client_flutter/theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0, title: const Text('HomeView'), centerTitle: true),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (c) {
            return EasyRefresh.builder(
                onRefresh: controller.onRefresh,
                controller: controller.refreshController,
                childBuilder: (context, physic) {
                  return CustomScrollView(
                    physics: physic,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.all(AppTheme.kPagePadding),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.kBorderRadius),
                              color: Colors.white,
                            ),
                            height: 180.h,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return c.bannerList.isNotEmpty
                                    ? CustomImage(
                                        url:
                                            '$kImgUrl${c.bannerList[index].url}',
                                        type: CustomImageType.network,
                                      )
                                    : Image.network(
                                        'https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new1.png',
                                        fit: BoxFit.fill,
                                      );
                              },
                              itemCount: c.bannerList.isNotEmpty
                                  ? c.bannerList.length
                                  : 1,
                              autoplay: true,
                              pagination: SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                  color: AppTheme.kAppSubGrey99Color,
                                  activeColor: AppTheme.primary,
                                  size: 6.w,
                                  activeSize: 6.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: BrnNoticeBar(
                          content: '这是跑马灯的通知内容跑马灯的通知内容跑马灯的通知内容跑马灯的通知内容',
                          marquee: true,
                          noticeStyle: NoticeStyles.normalNoticeWithArrow,
                          onNoticeTap: () {
                            BrnToast.show('点击通知', context);
                          },
                          onRightIconTap: () {
                            BrnToast.show('点击右侧图标', context);
                          },
                        ),
                      ),
                      _buildNewGoods(c),
                      _buildRecommended(c)
                    ],
                  );
                });
          }),
    );
  }

  // 新品推荐
  SliverPadding _buildNewGoods(HomeController c) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      sliver: SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.w),
          height: GetPlatform.isIOS ? 150.h : 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: c.newGoodsList.length,
            padding: EdgeInsets.only(right: 12.w),
            itemBuilder: (context, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImage(
                    height: 120.w,
                    width: 120.w,
                    url: '$kImgUrl${c.newGoodsList[i].files![0].fileUrl!}',
                    type: CustomImageType.network,
                  ),
                  SizedBox(
                    width: 130.w,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.w),
                      child: Text(
                        c.newGoodsList[i].name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                  Text(
                    '￥${c.newGoodsList[i].price ?? '暂无报价'}',
                    style: TextStyle(fontSize: 14.sp, color: Colors.redAccent),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // 热门推荐
  SliverPadding _buildRecommended(HomeController c) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '热门推荐',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '更多',
                      style:
                          TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.sp,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.w),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: c.hotGoodsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.w,
              ),
              itemBuilder: (context, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImage(
                      url: '$kImgUrl${c.hotGoodsList[i].files![0].fileUrl!}',
                      type: CustomImageType.network,
                    ),
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Text(
                          '${c.hotGoodsList[i].name}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.h,
                            horizontal: 2.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            color: AppTheme.kPriceColor.withOpacity(.2),
                          ),
                          child: Text(
                            '包邮',
                            style:
                                TextStyle(fontSize: 8.sp, color: kPriceColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.w),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '￥',
                            style: TextStyle(
                                fontSize: 10.sp, color: Colors.redAccent),
                            children: [
                              TextSpan(
                                text: '${c.hotGoodsList[i].price}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: kPriceColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            '已售出${c.hotGoodsList[i].sales}${c.hotGoodsList[i].unitsName}',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: kAppSubGrey99Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
