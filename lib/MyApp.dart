
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_const.dart';
import '../providers/setting_provider.dart';
import '../repo_injection.dart';
import '../utils/theme.dart';
import 'route_management/my_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: getNotifiers,
    child: Builder(
        builder: (context) {
          return MaterialApp.router(
                    routerDelegate: MyRouter.router.routerDelegate,
                    routeInformationProvider:
                        MyRouter.router.routeInformationProvider,
                    routeInformationParser:
                        MyRouter.router.routeInformationParser,
            themeMode:
            Provider.of<SettingProvider>(context, listen: true).themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            title: AppConst.appName,
            debugShowCheckedModeBanner: false,
          );
        }
    ),
  );

}