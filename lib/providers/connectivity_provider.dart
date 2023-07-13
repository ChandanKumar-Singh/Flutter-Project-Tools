import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool isOnline = false;

class ConnectivityProvider extends ChangeNotifier {
  bool _isOnline = true;
  final Connectivity _connectivity = Connectivity();

  get getOnline => _isOnline;
  ConnectivityProvider() {
    _initialize();
  }

  void _initialize() async {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _isOnline = result != ConnectivityResult.none;
      isOnline = _isOnline;
      notifyListeners();

      if (!_isOnline) {
        _showOfflineToast();
      }
    });
  }

  void _showOfflineToast() {
    Fluttertoast.showToast(
        msg: "Offline", backgroundColor: Colors.red, textColor: Colors.white);
  }
}
