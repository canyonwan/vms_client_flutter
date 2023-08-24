import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:vms_client_flutter/i18n/index.dart';
import 'package:vms_client_flutter/store/index.dart';
import 'package:vms_client_flutter/theme.dart';

import 'app/routes/app_pages.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          navigatorObservers: [FlutterSmartDialog.observer],
          debugShowCheckedModeBanner: false,
          title: '兽用杂货铺',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Translation.supported,
          fallbackLocale: Translation.fallback,
          locale: ConfigStore.to.locale,
          translations: Translation(),
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: AppTheme.mode,
          popGesture: true,
          transitionDuration: const Duration(milliseconds: 450),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: (ctx, child) {
            FlutterSmartDialog.init();
            ScreenUtil.init(ctx);
            return ScrollConfiguration(
              behavior: NoShadowScrollBehavior(),
              child: child ?? const Material(),
            );
          },
        );
      },
    );
  }
}

class NoShadowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return child;
      case TargetPlatform.android:
        return GlowingOverscrollIndicator(
          showLeading: false,
          showTrailing: false,
          axisDirection: details.direction,
          color: Theme.of(context).colorScheme.primary,
          child: child,
        );
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return GlowingOverscrollIndicator(
          showLeading: false,
          showTrailing: false,
          axisDirection: details.direction,
          color: Theme.of(context).colorScheme.primary,
          child: child,
        );
    }
  }
}
