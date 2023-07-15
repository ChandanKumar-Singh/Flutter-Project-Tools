import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class MyDialogs {
  //todo: use awesome_dialog

  // quick alert
  static showQuickSuccessDialog({String? desc, String? title}) {
    QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        title: title,
        text: desc);
  }

  static showQuickErrorsDialog({String? desc, String? title}) {
    QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: title ?? 'Oops...',
        text: desc ?? 'Sorry, something went wrong');
  }

  static showQuickWarningDialog({String? desc, String? title}) {
    QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.warning,
        title: title ?? 'Oops...',
        text: desc ?? 'Sorry, something went wrong');
  }

  static showQuickInfoDialog({String? desc, String? title}) {
    QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.warning,
        title: title ?? 'Oops...',
        text: desc ?? 'Sorry, something went wrong');
  }

  static showQuickConfirmDialog(
      {String? desc,
      String? title,
      Function? onConfirm,
      Function? onCancel}) async {
    await QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.confirm,
        title: title,
        text: desc,
        confirmBtnText: 'Confirm',
        cancelBtnText: 'Cancel',
        confirmBtnColor: Colors.white,
        // backgroundColor: Colors.black,
        confirmBtnTextStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        // barrierColor: Colors.white,
        // titleColor: Colors.white,
        // textColor: Colors.white,
        onCancelBtnTap: onCancel != null ? () => onCancel() : null,
        onConfirmBtnTap: onConfirm != null ? () => onConfirm() : null);
  }

  static showQuickLoadingDialog({String? desc, String? title}) {
    QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.loading,
      title: title ?? 'Loading...',
      text: desc ?? 'Fetching your data',
    );
  }

  static showQuickCustomDialog({String? desc, String? title}) {
    var message = '';
    QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.info,
      barrierDismissible: true,
      confirmBtnText: 'Save',
      title: title ?? 'My Dialog',
      text: desc,
      // customAsset: 'assets/custom.gif',
      widget: TextFormField(
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Enter Phone Number',
          prefixIcon: Icon(Icons.phone_outlined),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        onChanged: (value) => message = value,
      ),
      onConfirmBtnTap: () async {
        if (message.length < 5) {
          await QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.error,
            text: 'Please input something',
          );
          return;
        }
        Navigator.pop(Get.context!);
        await showQuickLoadingDialog();
        await Future.delayed(const Duration(milliseconds: 3000));
        Navigator.pop(Get.context!);
        await Future.delayed(const Duration(milliseconds: 3000));
        await QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.success,
            text: "Phone number '$message' has been saved!.");
      },
    );
  }

  // Panara Confirm Dialog
  static showPanaraInfoDialog(
      {String? desc,
      String? title,
      bool dismissible = false,
      VoidCallback? onCancel,
      VoidCallback? onConfirm}) {
    PanaraConfirmDialog.showAnimatedGrow(
      Get.context!,
      title: title ?? "Hello",
      message: desc ?? "This is the Panara Confirm Dialog Normal.",
      confirmButtonText: "Confirm",
      cancelButtonText: "Cancel",
      onTapCancel: () {
        Navigator.pop(Get.context!);
      },
      onTapConfirm: () {
        Navigator.pop(Get.context!);
        if (onConfirm != null) onConfirm();
      },
      barrierDismissible: dismissible,
      panaraDialogType: PanaraDialogType.normal,
    );
  }

  static showPanaraConfirmDialog({
    String? desc,
    String? confirmButtonText,
    String? title,
    String? image,
    String? cancelButtonText,
    bool dismissible = false,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool noImage = true,
  }) {
    PanaraConfirmDialog.showAnimatedGrow(
      Get.context!,
      title: title,
      noImage: noImage || image == null,
      imagePath: image,
      message: desc ?? "This is the Panara Confirm Dialog Normal.",
      confirmButtonText: confirmButtonText ?? "Confirm",
      cancelButtonText: cancelButtonText ?? "Cancel",
      onTapCancel: () {
        Navigator.pop(Get.context!);
      },
      onTapConfirm: () {
        Navigator.pop(Get.context!);
        if (onConfirm != null) onConfirm();
      },
      barrierDismissible: dismissible,
      panaraDialogType: PanaraDialogType.custom,
    );
  }

  static showPanaraSuccessDialog(
      {String? desc,
      String? title,
      bool dismissible = false,
      VoidCallback? onCancel,
      VoidCallback? onConfirm}) {
    PanaraConfirmDialog.showAnimatedGrow(
      Get.context!,
      title: title,
      message: desc ?? "This is the Panara Confirm Dialog Normal.",
      confirmButtonText: "Confirm",
      cancelButtonText: "Cancel",
      onTapCancel: () {
        Navigator.pop(Get.context!);
      },
      onTapConfirm: () {
        Navigator.pop(Get.context!);
        if (onConfirm != null) onConfirm();
      },
      barrierDismissible: dismissible,
      panaraDialogType: PanaraDialogType.success,
    );
  }
}
