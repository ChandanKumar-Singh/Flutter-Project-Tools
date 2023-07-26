import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_const.dart';
import '../providers/setting_provider.dart';
import '../repo_injection.dart';
import '../utils/theme.dart';
import 'route_management/my_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: getNotifiers,
        child: Consumer<SettingProvider>(
          builder: (context, settingProvider, child) {
            return Builder(builder: (context) {
              return MaterialApp.router(
                routerDelegate: MyRouter.router.routerDelegate,
                routeInformationProvider:
                    MyRouter.router.routeInformationProvider,
                routeInformationParser: MyRouter.router.routeInformationParser,
                themeMode: Provider.of<SettingProvider>(context, listen: true)
                    .themeMode,
                theme: lightTheme,
                darkTheme: darkTheme,
                title: AppConst.appName,
                debugShowCheckedModeBanner: false,
                locale: settingProvider.currentLocale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            });
          },
        ),
      );
}
