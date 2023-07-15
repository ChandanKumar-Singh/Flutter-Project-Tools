
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum ConfirmAction { cancel, accept }

class PermissionHelper {
  static Future<bool> requestPermissionSingle(
      BuildContext context, Permission permission, String title, String tips,
      {bool useDialog = true}) async {
    var status = await permission.status;
    var granted = status == PermissionStatus.granted;
    if (granted) return granted;
    if (useDialog) {
      // ignore: use_build_context_synchronously
      final action = await showDialog<ConfirmAction>(
          context: context,
          builder: (BuildContext context) {
            return buildPermissionDialog(context, title, tips);
          });
      if (action == ConfirmAction.accept) {
        granted = await requestSingle(permission);
      }
    } else {
      granted = await requestSingle(permission);
    }
    return granted;
  }

  static CupertinoAlertDialog buildPermissionDialog(
      BuildContext context, String title, String tips) {
    return CupertinoAlertDialog(
      title: Text('$tips Not Available'),
      content: Text(
          'This function requires $tips, please allow $title to access your $tips？'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(ConfirmAction.cancel);
          },
        ),
        CupertinoDialogAction(
          child: const Text('Settings'),
          onPressed: () {
            Navigator.of(context).pop(ConfirmAction.accept);
          },
        ),
      ],
    );
  }

  static Future<bool> requestSingle(Permission request) async {
    PermissionStatus status = await request.request();
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return status == PermissionStatus.granted;
  }
}
