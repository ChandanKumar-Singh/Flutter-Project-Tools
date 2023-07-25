/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/functions/repositories/auth_repo.dart';
import 'package:my_global_tools/repo_injection.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/screens/home.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/my_dialogs.dart';
import 'package:my_global_tools/widgets/app_web_view_page.dart';

import '../models/user/user_data_model.dart';
import '../providers/auth_provider.dart';
import '../screens/splash_screen.dart';
import '../widgets/page_not_found.dart';
import 'route_animation.dart';
import 'route_name.dart';

class MyRouter {
  static const String tag = 'MyRouter';

  final GoRouter goRouter;

  MyRouter(String? initialRoute) : goRouter = router(initialRoute);

  static GoRouter router(String? initialRoute) => GoRouter(
        navigatorKey: Get.key,
        initialLocation: RoutePath.splash,
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
              builder: (BuildContext context, GoRouterState state) =>
                  const Home(),
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
          GoRoute(
            name: RouteName.notFoundScreen,
            path: RoutePath.notFoundScreen,
            builder: (BuildContext context, GoRouterState state) =>
                NotFoundScreen(uri: state.location, state: state),
          ),

          */ /*
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
                const LoginScreen()),*/ /*

          ///MLM
          */ /* GoRoute(
            name: RouteName.mLMTransactionPage,
            path: RoutePath.mLMTransactionPage,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return animatedRoute(state, const MLMTransactionPage());
            }),*/ /*

          ///Ecommerce
        ],
        errorPageBuilder: (context, state) => MaterialPage(
            child: NotFoundScreen(state: state, uri: state.location)),
        redirect: guard,
      );

  static Future<String?> guard(
      BuildContext context, GoRouterState state) async {
    String path = state.matchedLocation;
    infoLog('The path is--> ${state.location}');

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
    } else if (loggedIn && !isGuest) {
      // MyDialogs.showQuickLoadingDialog(Get.context!);
      // await Future.delayed(const Duration(seconds: 5));
      // Navigator.pop(Get.context!);
      infoLog('The path is ${state.location}');
      // if (path == RoutePath.onBoarding) {
      //   return RoutePath.home;
      // }
      // else
        if (path.startsWith(RoutePath.home)) {
        infoLog('user is logged in and trying to route in home', tag);
        // await Future.delayed(const Duration(seconds: 5));
        return state.location;
      }
    }
    return null;
  }
}

Copyright 2013 The Flutter Authors. All rights reserved.
Use of this source code is governed by a BSD-style license that can be
found in the LICENSE file.*/

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/screens/about_page.dart';
import 'package:my_global_tools/screens/contact_page.dart';
import 'package:my_global_tools/screens/setting_page.dart';
import '../screens/gallery_page.dart';
import '../widgets/page_not_found.dart';
import 'route_animation.dart';
import 'route_name.dart';
import 'route_path.dart';

import '../screens/auth/login_screen.dart';
import '../screens/home.dart';
import '../screens/splash_screen.dart';
import '../services/auth_service.dart';
import '../utils/default_logger.dart';
import '../widgets/app_web_view_page.dart';

class MyRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: Get.key,
    initialLocation: RoutePath.splash,
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
          path: RoutePath.home,
          builder: (BuildContext context, GoRouterState state) => const Home(),
          routes: [
            _newRoute2(
                RouteName.explore,
                (GoRouterState state) => WebViewExample(
                    url: state.queryParameters['url'],
                    showAppBar: state.queryParameters['showAppBar'] ?? '1',
                    showToast: state.queryParameters['showToast'] ?? '1',
                    changeOrientation:
                        state.queryParameters['changeOrientation'] ?? '0'),
                null),
            _newRoute2(RouteName.contact,
                (GoRouterState state) => const ContactPage(), null),
            _newRoute2(RouteName.gallery,
                (GoRouterState state) => const GalleryPage(), null),
            _newRoute2(RouteName.setting,
                (GoRouterState state) => SettingsPage(), null),
            _newRoute2(RouteName.about,
                (GoRouterState state) => const AboutPage(), null),
          ]),
      GoRoute(
        path: RoutePath.login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: RoutePath.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
    ],
    errorPageBuilder: (context, state) =>
        animatedRoute(state, NotFoundScreen(state: state, uri: state.location)),
    redirect: _redirect,
  );
}

FutureOr<String?> _redirect(BuildContext context, GoRouterState state) async {
  // Using `of` method creates a dependency of StreamAuthScope. It will
  // cause go_router to reparse current route if StreamAuth has new sign-in
  // information.
  String path = state.matchedLocation;
  final bool loggedIn = await StreamAuthScope.of(context).isSignedIn();
  final bool loggingIn = path == RoutePath.login;

  infoLog('path is $path  , user is logged in $loggedIn');
  if (path == RoutePath.splash) {
    return RoutePath.splash;
  }
  if (!loggedIn) {
    return RoutePath.login;
  }

  // if the user is logged in but still on the login page, send them to
  // the home page
  if (loggingIn) {
    infoLog(
        'path is $path   *contains home  ${path.startsWith(RoutePath.home)}',
        'User is logged in');
    if (path.startsWith(RoutePath.home)) {
      return path;
    } else {
      return RoutePath.home;
    }
  }

  // no need to redirect at all
  return null;
}

GoRoute _newRoute(String name, Widget page, String transition,
        {bool subPath = true}) =>
    GoRoute(
        name: name,
        path: '${!subPath ? '/' : ''}$name',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            animatedRoute(state, page));

GoRoute _newRoute2(String name, Widget Function(GoRouterState state) page,
        RouteTransition? transition, {bool subPath = true}) =>
    GoRoute(
        name: name,
        path: '${!subPath ? '/' : ''}$name',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            animatedRoute2(state, page, transition: transition));
