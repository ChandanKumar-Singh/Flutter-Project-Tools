import 'package:flutter/material.dart';
import 'package:my_global_tools/constants/api_const.dart';
import 'package:my_global_tools/utils/api_handler_utils.dart';
import 'package:my_global_tools/utils/default_logger.dart';

import '../functions/repositories/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  final String tag = 'AuthProvider';
  AuthProvider({required this.authRepo});

  bool loadingStates = false;
  Future<void> getStates(BuildContext context) async {
    loadingStates = true;
    notifyListeners();
    var (map, cacheStatus) = await ApiHandler.hitApi(
        context, tag, ApiConst.register, () => authRepo.register({}));
    try {
      if (map != null) {}
    } catch (e) {
      errorLog('error on getStates', tag);
    }
    loadingStates = false;
    notifyListeners();
  }

  Future<bool> clearSharedData() async => await authRepo.clearSharedData();

  clear() async {
    await clearSharedData();
  }
}
