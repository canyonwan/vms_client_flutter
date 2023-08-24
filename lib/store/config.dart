part of store;

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  ui.Locale locale = ui.window.locale;
  List<ui.Locale> languages = [
    const ui.Locale('en', 'US'),
    const ui.Locale('zh', 'CN'),
  ];
  // List<CategoryModel> categories = [];
  List<String> countries = [];

  String _roleType = C.roleGeek;

  String get roleType => _roleType;

  bool get isBossMode => _roleType == C.roleBoss;

  @override
  void onInit() {
    super.onInit();
    _initLanguage();
    _initThemeMode();
    _initCountries();
    // _initCategories();
  }

  void _initLanguage() {
    final result = StorageService.to.getString(C.localLanguage);
    if (result.isEmpty) return;
    locale = languages.firstWhere(
      (element) => element.languageCode == result,
      orElse: () => ui.window.locale,
    );
  }

  void _initCountries() {
    countries = [
      'Algeria',
      'American Samoa',
      'Andorra',
      'Bahamas',
      'Bahrain',
      'Bangladesh',
      'Cambodia',
      'Cameroon',
      'Canada',
    ];
  }

  void _initThemeMode() {
    final theme = StorageService.to.getString(C.localThemeMode);
    switch (theme) {
      case C.themeLight:
        AppTheme.mode = ThemeMode.light;
        break;
      case C.themeDark:
        AppTheme.mode = ThemeMode.dark;
        break;
      default:
        AppTheme.mode = ThemeMode.system;
        break;
    }
    AppTheme.setSystemStyle();
  }

  void setRole(String value) => _roleType = value;

  void setLanguage(Locale value) {
    locale = value;
    Get.updateLocale(value);
    StorageService.to.setString(C.localLanguage, value.languageCode);
  }
}
