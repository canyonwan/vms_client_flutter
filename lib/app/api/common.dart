part of api;

// 获取首页banner列表
Future<HomeBannersDataModel> queryHomeBanners() async {
  final res = await HttpService.to.get('banner/list');
  return HomeBannersDataModel.fromJson(res.data);
}
