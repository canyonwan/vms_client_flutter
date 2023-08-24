import 'package:bruno/bruno.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/const/colors.dart';
import 'package:vms_client_flutter/const/common.dart';

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
          builder: (context) {
            return EasyRefresh.builder(
                onRefresh: controller.onRefresh,
                controller: controller.refreshController,
                childBuilder: (context, physic) {
                  return CustomScrollView(
                    physics: physic,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.all(kPagePadding),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
                              color: Colors.white,
                            ),
                            height: 180.h,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return Image.network(
                                  'https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new1.png',
                                  fit: BoxFit.fill,
                                );
                              },
                              itemCount: 3,
                              autoplay: true,
                              pagination: SwiperPagination(),
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
                      _buildNewGoods(),
                      _buildRecommended()
                    ],
                  );
                });
          }),
    );
  }

  // 新品推荐
  SliverPadding _buildNewGoods() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      sliver: SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.w),
          height: GetPlatform.isIOS ? 150.h : 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            padding: EdgeInsets.only(right: 12.w),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.w),
                    child: Image.network(
                      'https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new1.png',
                      fit: BoxFit.fill,
                      height: 120.w,
                      width: 120.w,
                    ),
                  ),
                  SizedBox(
                    width: 130.w,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.w),
                      child: Text(
                        '阿维菌透皮素专治痘痘阿维菌透皮素专治痘痘3',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                  Text(
                    '￥100.00',
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
  SliverPadding _buildRecommended() {
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
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.w,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.w),
                      child: Image.network(
                        'https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new1.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Text(
                          '阿维菌透皮素专治痘痘阿维菌透皮素专治痘痘3',
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kPriceColor.withOpacity(.7),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(2.w),
                            color: Colors.white,
                          ),
                          child: Text(
                            '包邮',
                            style:
                                TextStyle(fontSize: 8.sp, color: kPriceColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '￥',
                            style: TextStyle(
                                fontSize: 10.sp, color: Colors.redAccent),
                            children: [
                              TextSpan(
                                text: '100.00',
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
                            '333+人已付款',
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
