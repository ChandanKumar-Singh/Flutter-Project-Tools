import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/functions/repositories/auth_repo.dart';
import 'package:my_global_tools/repo_injection.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/screens/home.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/widgets/app_web_view_page.dart';

import '../models/user/user_data_model.dart';
import '../providers/auth_provider.dart';
import '../screens/splash_screen.dart';
import '../widgets/page_not_found.dart';
import 'route_animation.dart';
import 'route_name.dart';

class MyRouter {
  static const String tag = 'MyRouter';

  static  GoRouter router(String? initialRoute) => GoRouter(
    initialLocation:initialRoute?? RoutePath.splash,
    refreshListenable: sl.get<AuthProvider>(),
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      //todo: add your router here
      GoRoute(
          name: RouteName.splash,
          path: RoutePath.splash,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen()),

      GoRoute(
          name: RouteName.home,
          path: RoutePath.home,
          builder: (BuildContext context, GoRouterState state) => const Home(),
          routes: [
            GoRoute(
                name: RouteName.explore,
                path: RoutePath.explore,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return animatedRoute(
                      state,
                      WebViewExample(
                        url: state.queryParameters['url'],
                      ));
                }),
          ]),

      /*
        GoRoute(
            name: RouteName.onBoarding,
            path: RoutePath.onBoarding,
            builder: (BuildContext context, GoRouterState state) =>
                const OnBoardingScreen()),
        GoRoute(
            name: RouteName.mlmDash,
            path: RoutePath.mlmDash,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return animatedRoute(state, const MLMDashboardPage());
            }),
        GoRoute(
            name: RouteName.ecomDash,
            path: RoutePath.ecomDash,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return animatedRoute(state, const EcommerceDashboardPage());
            },
            routes: [
              GoRoute(
                  name: RouteName.ecomCategoryPage,
                  path: RoutePath.ecomCategoryPage,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return animatedRoute(
                        state,
                        EcomCategoryPage(
                          index:
                              int.parse(state.queryParameters['index'] ?? '0'),
                        ));
                  }),
            ]),
        GoRoute(
            name: RouteName.login,
            path: RoutePath.login,
            builder: (BuildContext context, GoRouterState state) =>
                const LoginScreen()),*/

      ///MLM
      /* GoRoute(
            name: RouteName.mLMTransactionPage,
            path: RoutePath.mLMTransactionPage,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return animatedRoute(state, const MLMTransactionPage());
            }),*/

      ///Ecommerce
    ],
    errorPageBuilder: (context, state) =>
        MaterialPage(child: NotFoundPage(state: state)),
    redirect: guard,
  );

  static Future<String?> guard(
      BuildContext context, GoRouterState state) async {
    String path = state.matchedLocation;

    var authRepo = sl.get<AuthRepo>();
    await authRepo.saveUser(UserData(status: '2'));
    UserData? user = await authRepo.getUser();

    final bool loggedIn = user != null;
    final bool loggingIn = path == RoutePath.login;
    final bool onBoarding = path == RoutePath.onBoarding;
    infoLog(
        '** routing $path loggedIn $loggedIn   loggingIn $loggingIn **', tag);
    if (!loggedIn && onBoarding) {
      return RoutePath.onBoarding;
    } else if (!loggedIn && loggingIn) {
      return RoutePath.login;
    } else if (!loggedIn && path == RoutePath.splash) {
      return RoutePath.splash;
    } else if (!loggedIn) {
      return RoutePath.login;
    }

    ///user is guest or real
    bool isGuest = true;
    isGuest = user.status == '2';
    infoLog(
        'my router user is logged in $loggedIn, guest $isGuest, status is ${user.status} and path is $path',
        tag);

    ///if user is logged in
    // if user is guest
    if (loggedIn && isGuest) {
      if (path == RoutePath.onBoarding) {
        return RoutePath.ecomDash;
      }
    } else {
      infoLog('user is logged in and trying to route in home', tag);
      if (path == RoutePath.onBoarding) {
        return RoutePath.home;
      }
    }
    return null;
  }
}
