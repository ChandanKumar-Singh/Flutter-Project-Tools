import 'package:dio/dio.dart';
import 'package:my_global_tools/constants/api_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/base/api_response.dart';
import '../dio/dio_client.dart';
import '../dio/exception/api_error_handler.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.dioClient, required this.sharedPreferences});

  ///:register
  Future<ApiResponse> register(Map<String, dynamic> data) async {
    try {
      Response response = await dioClient.post(ApiConst.register, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for  user token
  Future<void> saveUser(dynamic userData) async {
    // try {
    //   await sharedPreferences.setString(
    //       SPConstants.user, jsonEncode(userData.toJson()));
    // } catch (e) {
    //   throw e;
    // }
  }

  Future<dynamic> getUser() async {
    // UserData? _userData;
    // try {
    //   var data = await sharedPreferences.getString(SPConstants.user);
    //   if (data != null) {
    //     _userData = jsonDecode(data);
    //   }
    // } catch (e) {
    //   throw e;
    // }
    // return _userData;
  }

  Future<String> getUserID() async {
    // UserData? _userData;
    String id = '';
    // try {
    //   var data = await sharedPreferences.getString(SPConstants.user);
    //   if (data != null) {
    //     _userData = UserData.fromJson(jsonDecode(data));
    //     id = _userData.id ?? '';
    //   }
    // } catch (e) {
    //   throw e;
    // }
    return id;
  }



}
