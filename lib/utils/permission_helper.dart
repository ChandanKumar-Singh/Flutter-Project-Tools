import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  static Future<bool> checkPermissionStatus(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Error'),
          content: Text(message),
          actions: <Widget>[
            FilledButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<bool> checkPermission(
      BuildContext context, Permission permission) async {
    bool granted = await checkPermissionStatus(permission);
    if (granted) {
      return granted;
    } else {
      requestPermission(Permission.camera).then((isGranted) {
        if (isGranted) {
          // Permission granted, proceed with desired functionality
          PermissionHelper.showSuccessSnackbar(
              context, 'Camera permission granted');
        } else {
          // Permission denied or not requested
          PermissionHelper.showErrorDialog(context, 'Camera permission denied');
        }
      });
      return granted;
    }
  }
}
