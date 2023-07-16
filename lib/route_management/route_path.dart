import 'package:my_global_tools/route_management/route_name.dart';

class RoutePath {
  RouteName routeName = RouteName();
  static const String splash = '/${RouteName.splash}';
  static const String notFoundScreen = '/${RouteName.notFoundScreen}';
  static const String onBoarding = '/${RouteName.onBoarding}';
  static const String login = '/${RouteName.login}';
  static const String home = '/${RouteName.home}';
  static const String ecomDash = '/${RouteName.ecomDash}';


  //sub-paths
  static const String explore = RouteName.explore;

  ///MLM
  ///drawer pages
  static const String mLMTransactionPage = '/${RouteName.mLMTransactionPage}';
  // static const String mLMFlutterSideMenu = '/mLMFlutterSideMenu';

  ///Ecommerce
  static const String ecomCategoryPage = RouteName.ecomCategoryPage;
}
