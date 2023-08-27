part of api;

// 获取商品分类树
Future<GoodsCateListDataModel> queryGoodsCategoryTree() async {
  final res = await HttpService.to.get('goods/category/tree');
  return GoodsCateListDataModel.fromJson(res.data);
}

// 获取商品详情
Future<GoodsDetailDataModel> queryGoodsDetail(int id) async {
  final res = await HttpService.to.get('goods/detail/$id');
  return GoodsDetailDataModel.fromJson(res.data);
}

// 获取商品分页
Future<GoodsPageDataModel> queryGoodsPage({
  int page = 1,
  int size = 10,
  String? name,
  String? price,
  String? sort,
  String? status,
  String? categoryIds,
}) async {
  final res = await HttpService.to.get('goods/page', params: {
    'page': page,
    'size': size,
    'name': name,
    'price': price,
    'sort': sort,
    'status': status,
    'categoryIds': categoryIds,
  });
  return GoodsPageDataModel.fromJson(res.data);
}
