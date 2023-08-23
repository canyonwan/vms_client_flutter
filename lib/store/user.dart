part of store;

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  ProfileModel _info = ProfileModel();
  bool _isLogin = false;
  String _account = '';
  String _token = '';

  String get account => _account;
  String get token => _token;
  ProfileModel get info => _info;
  bool get isLogin => _isLogin;

  @override
  void onInit() {
    super.onInit();
    _account = StorageService.to.getString(C.localAccount);
  }

  Future<void> setAccount(String? value) async {
    _account = value?.toString() ?? '';
    await StorageService.to.setString(C.localAccount, _account);
  }

  Future<void> setToken(String? value) async {
    _token = value?.toString() ?? '';
    await StorageService.to.setString(C.localToken, _token);
  }

  void setProfile(ProfileModel data) {
    _info = data;
    _isLogin = true;
    update();
  }

  bool get hasToken {
    return _token.isNotEmpty;
  }

  Future<void> logout() async {
    try {
      await Future.wait([
        Future.delayed(const Duration(seconds: 1)),
        StorageService.to.remove(C.localRole),
      ]);
    } finally {
      ConfigStore.to.setRole('');
      _account = '';
      _info = ProfileModel();
      _isLogin = false;
    }
  }
}
