import 'package:bruno/bruno.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/app/model/goods_detail_model.dart';
import 'package:vms_client_flutter/app/widgets/index.dart';
import 'package:vms_client_flutter/const/common.dart';
import 'package:vms_client_flutter/theme.dart';

import '../controllers/goods_detail_controller.dart';

class GoodsDetailView extends GetView<GoodsDetailController> {
  const GoodsDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      bottomNavigationBar: _bottomBox(colorScheme),
      body: controller.obx(
        onLoading: Center(child: BrnPageLoading()),
        onError: (error) => Center(
            child: BrnAbnormalStateWidget(
          isCenterVertical: true,
          title: '获取数据失败，请重试',
          operateTexts: const <String>['请点击页面重试'],
          operateAreaType: OperateAreaType.textButton,
          action: (index) {
            BrnToast.show('获取数据失败，请重试', context);
          },
        )),
        (m) => CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('商品详情'),
              centerTitle: true,
              pinned: true,
              expandedHeight: 360.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return m?.files != null
                        ? CustomImage(
                            url: '$kImgUrl${m!.files![index].fileUrl!}',
                            type: CustomImageType.network,
                          )
                        : Image.network(
                            'https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new1.png',
                            fit: BoxFit.fill,
                          );
                  },
                  itemCount: m?.files != null ? m!.files!.length : 1,
                  pagination: SwiperPagination(
                    alignment: Alignment.bottomRight,
                    builder: FractionPaginationBuilder(
                      color: AppTheme.kAppSubGrey99Color,
                      activeColor: AppTheme.primary,
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
            _goodsInfo(colorScheme, m!),
            _skuInfo(colorScheme, m),
            _goodsEvaluation(colorScheme, m),
            _goodsDetail(m),
          ],
        ),
      ),
    );
  }

  SafeArea _bottomBox(ColorScheme colorScheme) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(AppTheme.kPagePadding),
        width: Get.width,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  controller.contactService('18532672238');
                },
                icon: Icon(Icons.call_outlined)),
            IconButton(
              onPressed: () {},
              icon: Badge(
                label: Text('10'),
                child: Icon(Icons.shopping_cart),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: BrnBigGhostButton(
                      title: '加入购物车',
                      onTap: () {
                        Get.bottomSheet(
                          isScrollControlled: true,
                          _addToCartBox(colorScheme),
                        );
                      },
                    ),
                  ),
                  Flexible(
                    child: BrnBigMainButton(
                      title: '立即购买',
                      onTap: () {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _addToCartBox(ColorScheme colorScheme) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
      ),
      height: Get.height * 0.8,
      child: SafeArea(
        child: GetBuilder(builder: (GoodsDetailController c) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.kPagePadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomImage(
                            width: 60.w,
                            height: 60.w,
                            url:
                                'https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new1.png',
                            type: CustomImageType.network,
                          ),
                          SizedBox(width: AppTheme.kPageMargin),
                          Text.rich(
                            TextSpan(
                              text: '￥',
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.redAccent),
                              children: [
                                TextSpan(
                                  text: '100',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppTheme.kPriceColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(Icons.close)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppTheme.kPagePadding),
                  children: [
                    SizedBox(height: AppTheme.kPagePadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('规格(20)',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: c.changeLayout,
                          icon: Icon(
                            c.isListLayout
                                ? Icons.view_list_rounded
                                : Icons.grid_view_rounded,
                            color: AppTheme.kAppSubGrey99Color,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // itemCount: _colors.length,
                      itemCount: 7,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: .7,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius:
                                BorderRadius.circular(AppTheme.kBorderRadius),
                          ),
                          child: Column(
                            children: [
                              CustomImage(
                                width: Get.width,
                                height: 100.w,
                                url:
                                    'https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new1.png',
                                type: CustomImageType.network,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(AppTheme.kPagePadding),
                                child: Text(
                                  '这是一个药药药药这是一个药药药药',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: AppTheme.kPagePadding * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('数量(有货)',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: c.changeLayout,
                          icon: Icon(
                            c.isListLayout
                                ? Icons.view_list_rounded
                                : Icons.grid_view_rounded,
                            color: AppTheme.kAppSubGrey99Color,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppTheme.kPagePadding * 6),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.kPagePadding * 2,
                      vertical: AppTheme.kPagePadding),
                  child: BrnBigMainButton(
                    bgColor: colorScheme.secondary,
                    title: '加入购物车',
                    onTap: () {},
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  SliverPadding _goodsDetail(GoodsDetailDataModel m) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: AppTheme.kPagePadding * 2),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BrnDashedLine(
                  axis: Axis.horizontal,
                  color: AppTheme.kAppGrey66Color,
                  contentWidget: SizedBox(width: 100),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppTheme.kPagePadding),
                  child: Text(
                    '商品详情',
                    style: TextStyle(
                        fontSize: 12.sp, color: AppTheme.kAppSubGrey99Color),
                  ),
                ),
                BrnDashedLine(
                  axis: Axis.horizontal,
                  color: AppTheme.kAppGrey66Color,
                  contentWidget: SizedBox(width: 100),
                ),
              ],
            ),
            Container(
              width: Get.width / 1.5,
              margin: EdgeInsets.symmetric(vertical: AppTheme.kPageMargin * 2),
              child: HtmlWidget(
                '${m.detail}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _goodsInfo(
      ColorScheme colorScheme, GoodsDetailDataModel m) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(AppTheme.kPagePadding),
        padding: EdgeInsets.all(AppTheme.kPagePadding),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.kBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: '￥',
                    style: TextStyle(fontSize: 10.sp, color: Colors.redAccent),
                    children: [
                      TextSpan(
                        text: '${m.price}',
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
                Text(
                  '已售出：${m.sales}${m.unitsName}',
                  style: TextStyle(
                      color: AppTheme.kAppSubGrey99Color, fontSize: 10.sp),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: AppTheme.kPagePadding),
              child: Text('${m.name} ${m.desc}'),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _skuInfo(ColorScheme colorScheme, GoodsDetailDataModel m) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(AppTheme.kPagePadding),
        padding: EdgeInsets.only(left: AppTheme.kPagePadding),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.kBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  //左侧信息
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: AppTheme.kPagePadding),
                        child: Text(
                          '保障',
                          style: TextStyle(
                            color: AppTheme.kAppSubGrey99Color,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 84),
                          child: Text(
                            '7天无理由退货•运费险•坏损包退',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      color: AppTheme.kAppSubGrey99Color,
                      size: 16.sp,
                    )),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  //左侧信息
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: AppTheme.kPagePadding),
                        child: Text(
                          '规格',
                          style: TextStyle(
                            color: AppTheme.kAppSubGrey99Color,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 84),
                          child: Text(
                            '请选择规格',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: AppTheme.kAppSubGrey99Color,
                    size: 16.sp,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  //左侧信息
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: AppTheme.kPagePadding),
                        child: Text(
                          '物流',
                          style: TextStyle(
                            color: AppTheme.kAppSubGrey99Color,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 84),
                          child: Text(
                            '预计2021年12月31日前发货',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: AppTheme.kAppSubGrey99Color,
                    size: 16.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 商品评价
  SliverToBoxAdapter _goodsEvaluation(
      ColorScheme colorScheme, GoodsDetailDataModel m) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(AppTheme.kPagePadding),
        padding: EdgeInsets.all(AppTheme.kPagePadding),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.kBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: '评价',
                    style: TextStyle(fontSize: 14.sp),
                    children: [
                      TextSpan(
                        text: '（200）',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppTheme.kAppSubGrey99Color,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      '更多',
                      style: TextStyle(
                          color: AppTheme.kAppSubGrey99Color, fontSize: 12.sp),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: AppTheme.kAppSubGrey99Color,
                      size: 16.sp,
                    )
                  ],
                ),
              ],
            ),
            // 循环10次
            for (var i = 0; i < 3; i++) _evaluationItem(),
          ],
        ),
      ),
    );
  }

  // 商品评价item
  Container _evaluationItem() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppTheme.kPagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new1.png'),
                radius: 16.r,
              ),
              SizedBox(width: AppTheme.kPagePadding),
              Text(
                '小明',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppTheme.kPagePadding),
            child: Text(
              '这个商品真的很棒！我非常喜欢它的设计和质量。它的外观非常漂亮，而且做工精细，手感也很好。我购买的这个商品是在打折期间购买的，价格非常实惠。我非常满意这次购物的体验，而且我会推荐这个商品给我的朋友们。',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          Text(
            '规格：1盒装',
            style: TextStyle(fontSize: 12.sp, color: AppTheme.kAppGrey66Color),
          ),
        ],
      ),
    );
  }
}
