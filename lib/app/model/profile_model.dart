import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ProfileModel {
  ProfileModel({
    this.id,
    this.phone,
    this.password,
    this.realName,
    this.avatar,
    this.gender,
    this.status,
    this.platform,
    this.isSuperAdmin,
    this.roleIds,
    this.permissions,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final List<ProfilePermissionsModel>? permissions =
        json['permissions'] is List ? <ProfilePermissionsModel>[] : null;
    if (permissions != null) {
      for (final dynamic item in json['permissions']!) {
        if (item != null) {
          permissions.add(ProfilePermissionsModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ProfileModel(
      id: asT<int?>(json['id']),
      phone: asT<String?>(json['phone']),
      password: asT<String?>(json['password']),
      realName: asT<String?>(json['realName']),
      avatar: asT<String?>(json['avatar']),
      gender: asT<int?>(json['gender']),
      status: asT<int?>(json['status']),
      platform: asT<int?>(json['platform']),
      isSuperAdmin: asT<int?>(json['isSuperAdmin']),
      roleIds: asT<String?>(json['roleIds']),
      permissions: permissions,
    );
  }

  int? id;
  String? phone;
  String? password;
  String? realName;
  String? avatar;
  int? gender;
  int? status;
  int? platform;
  int? isSuperAdmin;
  String? roleIds;
  List<ProfilePermissionsModel>? permissions;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'phone': phone,
        'password': password,
        'realName': realName,
        'avatar': avatar,
        'gender': gender,
        'status': status,
        'platform': platform,
        'isSuperAdmin': isSuperAdmin,
        'roleIds': roleIds,
        'permissions': permissions,
      };
}

class ProfilePermissionsModel {
  ProfilePermissionsModel({
    this.id,
    this.parentId,
    this.name,
    this.path,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfilePermissionsModel.fromJson(Map<String, dynamic> json) =>
      ProfilePermissionsModel(
        id: asT<int?>(json['id']),
        parentId: asT<int?>(json['parentId']),
        name: asT<String?>(json['name']),
        path: asT<String?>(json['path']),
        code: asT<String?>(json['code']),
        createdAt: asT<String?>(json['createdAt']),
        updatedAt: asT<String?>(json['updatedAt']),
      );

  int? id;
  int? parentId;
  String? name;
  String? path;
  String? code;
  String? createdAt;
  String? updatedAt;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'parentId': parentId,
        'name': name,
        'path': path,
        'code': code,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
