import 'package:bruno/bruno.dart';
import 'package:vms_client_flutter/theme.dart';

class BrnThemeConfig {
  static BrnAllThemeConfig defaultAllConfig = BrnAllThemeConfig(
      commonConfig: defaultCommonConfig,
      // 这里添加dialog配置
      dialogConfig: defaultDialogConfig);

  static BrnCommonConfig defaultCommonConfig = BrnCommonConfig(
    brandPrimary: AppTheme.primary,
  );

  /// Dialog配置
  static BrnDialogConfig defaultDialogConfig = BrnDialogConfig(
    radius: 12.0,
  );
}
