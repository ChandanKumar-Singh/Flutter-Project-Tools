
import 'package:flutter/material.dart';
import 'package:my_global_tools/constants/app_const.dart';
import 'package:my_global_tools/repo_injection.dart';
import 'package:my_global_tools/route_management/my_router.dart';
import 'package:my_global_tools/utils/theme.dart';
import 'package:provider/provider.dart';

import 'providers/setting_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initRepos();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//todo: use this notifier provider to MultiProvider
  ///Multi provider provider-list getter.

  @override
  Widget build(BuildContext context) {
    var notifiers = getNotifiers;
    return MultiProvider(
      providers: notifiers,
      child: Consumer<SettingProvider>(
        builder: (context, settingProvider, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: settingProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            title: AppConst.appName,
           routerConfig: MyRouter.router,
          );
        },
      ),
    );
  }
}
