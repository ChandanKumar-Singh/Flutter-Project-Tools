import 'package:my_global_tools/route_management/route_name.dart';

class RoutePath {
  RouteName routeName = RouteName();
  static const String splash = '/${RouteName.splash}';
  static const String notFoundScreen = '/${RouteName.notFoundScreen}';
  static const String onBoarding = '/${RouteName.onBoarding}';
  static const String login = '/${RouteName.login}';
  static const String home = '/${RouteName.home}';

  //sub-paths
  static const String explore = RouteName.explore;
  static const String about = RouteName.about;
  static const String setting = RouteName.setting;
  static const String gallery = RouteName.gallery;
  static const String contact = RouteName.contact;

  ///MLM
  ///drawer pages
  static const String mLMTransactionPage = '/${RouteName.mLMTransactionPage}';
  // static const String mLMFlutterSideMenu = '/mLMFlutterSideMenu';

  ///Ecommerce
  static const String ecomCategoryPage = RouteName.ecomCategoryPage;
}
