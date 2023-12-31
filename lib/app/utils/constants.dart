part of utils;

abstract class C {
  static const String localAccount = 'storage_account';
  static const String localToken = 'storage_token';
  static const String localRole = 'storage_role';
  static const String localThemeMode = 'storage_theme_mode';
  static const String localLanguage = 'storage_lang';

  /// 求职者
  static const String roleGeek = '0';

  /// 老板
  static const String roleBoss = '1';

  /// 自动主题
  static const String themeSystem = '0';

  /// 亮色主题
  static const String themeLight = '1';

  /// 暗色主题
  static const String themeDark = '2';
}
