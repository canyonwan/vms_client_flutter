import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class HomeBannersRootModel {
  HomeBannersRootModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory HomeBannersRootModel.fromJson(Map<String, dynamic> json) =>
      HomeBannersRootModel(
        code: asT<int>(json['code'])!,
        message: asT<String>(json['message'])!,
        data: HomeBannersDataModel.fromJson(
            asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String message;
  HomeBannersDataModel data;

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

class HomeBannersDataModel {
  HomeBannersDataModel({
    this.list,
  });

  factory HomeBannersDataModel.fromJson(Map<String, dynamic> json) {
    final List<HomeBanneItemModel>? list =
        json['list'] is List ? <HomeBanneItemModel>[] : null;
    if (list != null) {
      for (final dynamic item in json['list']!) {
        if (item != null) {
          list.add(
              HomeBanneItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return HomeBannersDataModel(
      list: list,
    );
  }

  List<HomeBanneItemModel>? list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'list': list,
      };
}

class HomeBanneItemModel {
  HomeBanneItemModel({
    required this.id,
    required this.url,
    required this.jumpLink,
    required this.sort,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory HomeBanneItemModel.fromJson(Map<String, dynamic> json) =>
      HomeBanneItemModel(
        id: asT<int>(json['id'])!,
        url: asT<String>(json['url'])!,
        jumpLink: asT<String>(json['jumpLink'])!,
        sort: asT<int>(json['sort'])!,
        createdAt: asT<String>(json['createdAt'])!,
        updatedAt: asT<String>(json['updatedAt'])!,
        deletedAt: asT<String>(json['deletedAt'])!,
      );

  int id;
  String url;
  String jumpLink;
  int sort;
  String createdAt;
  String updatedAt;
  String deletedAt;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'url': url,
        'jumpLink': jumpLink,
        'sort': sort,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
      };
}
