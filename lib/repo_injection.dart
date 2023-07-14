import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_global_tools/providers/auth_provider.dart';
import 'package:my_global_tools/providers/connectivity_provider.dart';
import 'package:my_global_tools/providers/setting_provider.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'constants/app_const.dart';
import 'functions/dio/dio_client.dart';
import 'functions/dio/logging_interceptor.dart';
import 'functions/repositories/auth_repo.dart';
import 'providers/web_view_provider.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

final sl = GetIt.instance;
Future<void> initRepos() async {
  // Core
  //   sl.registerLazySingleton(() => NetworkInfo(sl()));
  //   sl.registerLazySingleton(() => NotificationDatabaseHelper());
  // if (!sl.isRegistered<DioClient>()) {
  sl.registerLazySingleton(() => DioClient(AppConst.baseUrl, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));
  // }

  //Repositories
  // if (!sl.isRegistered<AuthRepo>()) {
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  // }

  //Providers
  sl.registerLazySingleton(() => AuthProvider(authRepo: sl()));
  sl.registerLazySingleton(() => SettingProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => WebViewProvider());
  sl.registerLazySingleton(() => ConnectivityProvider());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}

getNotifiersList(List<ChangeNotifier> notifiers) => notifiers
    .map((notifier) => ChangeNotifierProvider(create: (context) => notifier))
    .toList();
get getNotifiers => [
      ChangeNotifierProvider(create: (_) => sl.get<AuthProvider>()),
      ChangeNotifierProvider(create: (_) => sl.get<SettingProvider>()),
      ChangeNotifierProvider(create: (_) => sl.get<WebViewProvider>()),
      ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
    ];
