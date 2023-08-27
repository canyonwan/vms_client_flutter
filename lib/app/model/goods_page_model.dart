import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class GoodsPageRootModel {
  GoodsPageRootModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GoodsPageRootModel.fromJson(Map<String, dynamic> json) =>
      GoodsPageRootModel(
        code: asT<int>(json['code'])!,
        message: asT<String>(json['message'])!,
        data: GoodsPageDataModel.fromJson(
            asT<Map<String, dynamic>>(json['data'])!),
      );

  int code;
  String message;
  GoodsPageDataModel data;

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

class GoodsPageDataModel {
  GoodsPageDataModel({
    this.content,
    required this.page,
    required this.size,
    required this.total,
  });

  factory GoodsPageDataModel.fromJson(Map<String, dynamic> json) {
    final List<GoodsItemModel>? content =
        json['content'] is List ? <GoodsItemModel>[] : null;
    if (content != null) {
      for (final dynamic item in json['content']!) {
        if (item != null) {
          content
              .add(GoodsItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return GoodsPageDataModel(
      content: content,
      page: asT<int>(json['page'])!,
      size: asT<int>(json['size'])!,
      total: asT<int>(json['total'])!,
    );
  }

  List<GoodsItemModel>? content;
  int page;
  int size;
  int total;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': content,
        'page': page,
        'size': size,
        'total': total,
      };
}

class GoodsItemModel {
  GoodsItemModel({
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
    this.fileIdList,
    this.files,
  });

  factory GoodsItemModel.fromJson(Map<String, dynamic> json) {
    final List<int>? fileIdList = json['fileIdList'] is List ? <int>[] : null;
    if (fileIdList != null) {
      for (final dynamic item in json['fileIdList']!) {
        if (item != null) {
          fileIdList.add(asT<int>(item)!);
        }
      }
    }

    final List<FileItemModel>? files =
        json['files'] is List ? <FileItemModel>[] : null;
    if (files != null) {
      for (final dynamic item in json['files']!) {
        if (item != null) {
          files.add(FileItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return GoodsItemModel(
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
      fileIdList: fileIdList,
      files: files,
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
  List<int>? fileIdList;
  List<FileItemModel>? files;

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
        'fileIdList': fileIdList,
        'files': files,
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
