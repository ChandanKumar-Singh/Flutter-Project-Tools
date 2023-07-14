import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/utils/picture_utils.dart';

import '../constants/app_const.dart';
import '../constants/asset_constants.dart';
import '../utils/sized_utils.dart';
import '../utils/text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool searchMode = false;

  late AnimationController _animationController;
  late Animation<double> _splashOffsetAnimation;

  @override
  void initState() {
    primaryFocus?.unfocus();
    super.initState();
    listenDeepLinks();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _splashOffsetAnimation = Tween<double>(begin: 300, end: 0).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.fastOutSlowIn));

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    Future.delayed(
        const Duration(seconds: 3), () => context.go(RoutePath.onBoarding));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Transform.translate(
          offset: Offset(0, _splashOffsetAnimation.value),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                assetImages(PNGAssets.appLogo),
                height20(),
                titleLargeText(AppConst.appName, context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  late StreamSubscription<Map<dynamic, dynamic>> deppLinkSubscription;
  //todo:  add deeplink listener here
  ///Listener for deep links
  void listenDeepLinks() {
    // deppLinkSubscription = FlutterBranchSdk.initSession().listen((event) {
    //   logD(event.toString(),RoutePath.splash);
    // });
  }
}
