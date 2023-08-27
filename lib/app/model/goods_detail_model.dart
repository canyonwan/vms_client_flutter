import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class GoodsDetailRootModel {
  GoodsDetailRootModel({
    required this.code,
    required this.message,
    this.data,
  });

  factory GoodsDetailRootModel.fromJson(Map<String, dynamic> json) =>
      GoodsDetailRootModel(
        code: asT<int>(json['code'])!,
        message: asT<String>(json['message'])!,
        data: json['data'] == null
            ? null
            : GoodsDetailDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String message;
  GoodsDetailDataModel? data;

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

class GoodsDetailDataModel {
  GoodsDetailDataModel({
    this.id,
    this.categoryIds,
    this.name,
    this.desc,
    this.detail,
    this.unitsName,
    this.units,
    this.price,
    this.fileIds,
    this.status,
    this.sort,
    this.couponId,
    this.stock,
    this.sales,
    this.tags,
    this.type,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.files,
    this.skuList,
  });

  factory GoodsDetailDataModel.fromJson(Map<String, dynamic> json) {
    final List<FileItemModel>? files =
        json['files'] is List ? <FileItemModel>[] : null;
    if (files != null) {
      for (final dynamic item in json['files']!) {
        if (item != null) {
          files.add(FileItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<GoodsSkuItemModel>? skuList =
        json['skuList'] is List ? <GoodsSkuItemModel>[] : null;
    if (skuList != null) {
      for (final dynamic item in json['skuList']!) {
        if (item != null) {
          skuList.add(
              GoodsSkuItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return GoodsDetailDataModel(
      id: asT<int?>(json['id']),
      categoryIds: asT<String?>(json['categoryIds']),
      name: asT<String?>(json['name']),
      desc: asT<String?>(json['desc']),
      detail: asT<String?>(json['detail']),
      unitsName: asT<String?>(json['unitsName']),
      units: asT<int?>(json['units']),
      price: asT<int?>(json['price']),
      fileIds: asT<String?>(json['fileIds']),
      status: asT<int?>(json['status']),
      sort: asT<int?>(json['sort']),
      couponId: asT<int?>(json['couponId']),
      stock: asT<int?>(json['stock']),
      sales: asT<int?>(json['sales']),
      tags: asT<String?>(json['tags']),
      type: asT<int?>(json['type']),
      userId: asT<int?>(json['userId']),
      createdAt: asT<String?>(json['createdAt']),
      updatedAt: asT<String?>(json['updatedAt']),
      files: files,
      skuList: skuList,
    );
  }

  int? id;
  String? categoryIds;
  String? name;
  String? desc;
  String? detail;
  String? unitsName;
  int? units;
  int? price;
  String? fileIds;
  int? status;
  int? sort;
  int? couponId;
  int? stock;
  int? sales;
  String? tags;
  int? type;
  int? userId;
  String? createdAt;
  String? updatedAt;
  List<FileItemModel>? files;
  List<GoodsSkuItemModel>? skuList;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'categoryIds': categoryIds,
        'name': name,
        'desc': desc,
        'detail': detail,
        'unitsName': unitsName,
        'units': units,
        'price': price,
        'fileIds': fileIds,
        'status': status,
        'sort': sort,
        'couponId': couponId,
        'stock': stock,
        'sales': sales,
        'tags': tags,
        'type': type,
        'userId': userId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'files': files,
        'skuList': skuList,
      };
}

class FileItemModel {
  FileItemModel({
    this.id,
    this.fileUrl,
    this.fileName,
    this.fileType,
    this.fileTypeName,
    this.fileSize,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory FileItemModel.fromJson(Map<String, dynamic> json) => FileItemModel(
        id: asT<int?>(json['id']),
        fileUrl: asT<String?>(json['fileUrl']),
        fileName: asT<String?>(json['fileName']),
        fileType: asT<int?>(json['fileType']),
        fileTypeName: asT<String?>(json['fileTypeName']),
        fileSize: asT<int?>(json['fileSize']),
        userId: asT<int?>(json['userId']),
        createdAt: asT<String?>(json['createdAt']),
        updatedAt: asT<String?>(json['updatedAt']),
      );

  int? id;
  String? fileUrl;
  String? fileName;
  int? fileType;
  String? fileTypeName;
  int? fileSize;
  int? userId;
  String? createdAt;
  String? updatedAt;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'fileUrl': fileUrl,
        'fileName': fileName,
        'fileType': fileType,
        'fileTypeName': fileTypeName,
        'fileSize': fileSize,
        'userId': userId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class GoodsSkuItemModel {
  GoodsSkuItemModel({
    this.id,
    this.goodsId,
    this.skuName,
    this.price,
    this.stock,
    this.createdAt,
    this.updatedAt,
  });

  factory GoodsSkuItemModel.fromJson(Map<String, dynamic> json) =>
      GoodsSkuItemModel(
        id: asT<int?>(json['id']),
        goodsId: asT<int?>(json['goodsId']),
        skuName: asT<String?>(json['skuName']),
        price: asT<int?>(json['price']),
        stock: asT<int?>(json['stock']),
        createdAt: asT<String?>(json['createdAt']),
        updatedAt: asT<String?>(json['updatedAt']),
      );

  int? id;
  int? goodsId;
  String? skuName;
  int? price;
  int? stock;
  String? createdAt;
  String? updatedAt;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'goodsId': goodsId,
        'skuName': skuName,
        'price': price,
        'stock': stock,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
