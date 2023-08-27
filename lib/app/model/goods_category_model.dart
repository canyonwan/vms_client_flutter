import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class GoodsCateListRootModel {
  GoodsCateListRootModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GoodsCateListRootModel.fromJson(Map<String, dynamic> json) =>
      GoodsCateListRootModel(
        code: asT<int>(json['code'])!,
        message: asT<String>(json['message'])!,
        data: GoodsCateListDataModel.fromJson(
            asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String message;
  GoodsCateListDataModel data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'message': message,
        'data': data,
      };
}

class GoodsCateListDataModel {
  GoodsCateListDataModel({
    required this.list,
  });

  factory GoodsCateListDataModel.fromJson(Map<String, dynamic> json) {
    final List<GoodsCategoryItemModel>? list =
        json['list'] is List ? <GoodsCategoryItemModel>[] : null;
    if (list != null) {
      for (final dynamic item in json['list']!) {
        if (item != null) {
          list.add(GoodsCategoryItemModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return GoodsCateListDataModel(
      list: list!,
    );
  }

  List<GoodsCategoryItemModel> list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'list': list,
      };
}

class GoodsCategoryItemModel {
  GoodsCategoryItemModel({
    required this.id,
    required this.parentId,
    required this.picUrl,
    required this.categoryName,
    required this.sort,
    this.children,
  });

  factory GoodsCategoryItemModel.fromJson(Map<String, dynamic> json) {
    final List<GoodsCategoryItemModel>? children =
        json['children'] is List ? <GoodsCategoryItemModel>[] : null;
    if (children != null) {
      for (final dynamic item in json['children']!) {
        if (item != null) {
          children.add(GoodsCategoryItemModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return GoodsCategoryItemModel(
      id: asT<int>(json['id'])!,
      parentId: asT<int>(json['parentId'])!,
      picUrl: asT<String>(json['picUrl'])!,
      categoryName: asT<String>(json['categoryName'])!,
      sort: asT<String>(json['sort'])!,
      children: children,
    );
  }

  int id;
  int parentId;
  String picUrl;
  String categoryName;
  String sort;
  List<GoodsCategoryItemModel>? children;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'parentId': parentId,
        'picUrl': picUrl,
        'categoryName': categoryName,
        'sort': sort,
        'children': children,
      };
}
