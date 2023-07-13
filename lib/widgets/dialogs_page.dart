import 'package:flutter/material.dart';
import 'package:my_global_tools/utils/permission_helper.dart';
import 'package:my_global_tools/widgets/fluid_dialog.dart';
import 'package:my_global_tools/utils/my_dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:permission_handler/permission_handler.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({Key? key}) : super(key: key);

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    final successAlert = buildButton(
      onTap: () => MyDialogs.showQuickSuccessDialog(context),
      title: 'Success',
      text: 'Transaction Completed Successfully!',
      leadingImage: 'assets/success.gif',
    );

    final errorAlert = buildButton(
      onTap: () => MyDialogs.showQuickErrorsDialog(context),
      title: 'Error',
      text: 'Sorry, something went wrong',
      leadingImage: 'assets/error.gif',
    );

    final warningAlert = buildButton(
      onTap: () => MyDialogs.showQuickWarningDialog(context),
      title: 'Warning',
      text: 'You just broke protocol',
      leadingImage: 'assets/warning.gif',
    );

    final infoAlert = buildButton(
      onTap: () => MyDialogs.showQuickInfoDialog(context,
          title: 'Info', desc: 'Buy two, get one free'),
      title: 'Info',
      text: 'Buy two, get one free',
      leadingImage: 'assets/info.gif',
    );

    final confirmAlert = buildButton(
      onTap: () => MyDialogs.showQuickConfirmDialog(context),
      title: 'Confirm',
      text: 'Do you want to logout',
      leadingImage: 'assets/confirm.gif',
    );

    final loadingAlert = buildButton(
      onTap: () => MyDialogs.showQuickLoadingDialog(context),
      title: 'Loading',
      text: 'Fetching your data',
      leadingImage: 'assets/loading.gif',
    );

    final customAlert = buildButton(
      onTap: () => MyDialogs.showQuickCustomDialog(context),
      title: 'Customs ',
      text: 'Custom Widget Alert',
      leadingImage: 'assets/custom.gif',
    );
    final panaraInfoDialog = buildButton(
      onTap: () => MyDialogs.showPanaraInfoDialog(context),
      title: 'info ',
      text: 'info Widget Alert',
      leadingImage: 'assets/custom.gif',
    );
    final panaraSuccessDialog = buildButton(
      onTap: () => MyDialogs.showPanaraConfirmDialog(context),
      title: 'info ',
      text: 'info Widget Alert',
      leadingImage: 'assets/custom.gif',
    );
    final panaraConfirmDialog = buildButton(
      onTap: () => MyDialogs.showPanaraSuccessDialog(context),
      title: 'info ',
      text: 'info Widget Alert',
      leadingImage: 'assets/custom.gif',
    );
    final permissionDialog = buildButton(
      onTap: () => PermissionHelper.requestPermissionSingle(context,Permission.camera,'Camera','Camera permission'),
      title: 'info ',
      text: 'info Widget Alert',
      leadingImage: 'assets/custom.gif',
    );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "QuickAlert Demo",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          successAlert,
          const SizedBox(height: 20),
          errorAlert,
          const SizedBox(height: 20),
          warningAlert,
          const SizedBox(height: 20),
          infoAlert,
          const SizedBox(height: 20),
          confirmAlert,
          const SizedBox(height: 20),
          loadingAlert,
          const SizedBox(height: 20),
          customAlert,
          const SizedBox(height: 20),
          const Divider(),
          bodyLargeText('Material Dialogs', context),
          const SizedBox(height: 20),
          SizedBox(height: 600, child: _TestPage()),
          const Divider(),
          bodyLargeText('Panara Dialog', context),
          const SizedBox(height: 20),
          panaraInfoDialog,
          const SizedBox(height: 20),
          panaraConfirmDialog,
          const SizedBox(height: 20),
          panaraSuccessDialog,
          const SizedBox(height: 20),
          FilledButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const FluidDialogTestPage())),
              child: titleLargeText('Fluid Dialog Page', context)),
          const SizedBox(height: 20),

          permissionDialog,
          const SizedBox(height: 20),

        ],
      ),
    );
  }

  Card buildButton({
    required onTap,
    required title,
    required text,
    required leadingImage,
  }) {
    return Card(
      shape: const StadiumBorder(),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: ListTile(
        onTap: onTap,
        // leading: CircleAvatar(backgroundImage: AssetImage(leadingImage)),
        title: Text(title ?? ""),
        subtitle: Text(text ?? ""),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded),
      ),
    );
  }
}

class _TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestState();
  }
}

class TestState extends State<_TestPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          btn1(context),
          btn2(context),
          btn3(context),
          btn4(context),
        ],
      ),
    );
  }

  Widget btn1(BuildContext context) {
    return MaterialButton(
      color: Colors.grey[300],
      minWidth: 300,
      onPressed: () => Dialogs.materialDialog(
          msg: 'Are you sure ? you can\'t undo this',
          title: "Delete",
          color: Colors.white,
          context: context,
          dialogWidth: kIsWeb ? 0.3 : null,
          onClose: (value) => print("returned value is '$value'"),
          actions: [
            IconsOutlineButton(
              onPressed: () {
                Navigator.of(context).pop(['Test', 'List']);
              },
              text: 'Cancel',
              iconData: Icons.cancel_outlined,
              textStyle: const TextStyle(color: Colors.grey),
              iconColor: Colors.grey,
            ),
            IconsButton(
              onPressed: () {},
              text: "Delete",
              iconData: Icons.delete,
              color: Colors.red,
              textStyle: const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]),
      child: const Text("Show Material Dialog"),
    );
  }

  Widget btn2(BuildContext context) {
    return MaterialButton(
      minWidth: 300,
      color: Colors.grey[300],
      onPressed: () => Dialogs.bottomMaterialDialog(
          msg: 'Are you sure? you can\'t undo this action',
          title: 'Delete',
          context: context,
          actions: [
            IconsOutlineButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'Cancel',
              iconData: Icons.cancel_outlined,
              textStyle: const TextStyle(color: Colors.grey),
              iconColor: Colors.grey,
            ),
            IconsButton(
              onPressed: () {},
              text: 'Delete',
              iconData: Icons.delete,
              color: Colors.red,
              textStyle: const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]),
      child: const Text("Show Bottom Material Dialog"),
    );
  }

  Widget btn3(BuildContext context) {
    return MaterialButton(
      minWidth: 300,
      color: Colors.grey[300],
      onPressed: () => Dialogs.materialDialog(
        color: Colors.white,
        msg: 'Congratulations, you won 500 points',
        title: 'Congratulations',
        lottieBuilder: Lottie.asset(
          'assets/cong_example.json',
          fit: BoxFit.contain,
        ),
        dialogWidth: kIsWeb ? 0.3 : null,
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'Claim',
            iconData: Icons.done,
            color: Colors.blue,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ],
      ),
      child: const Text("Show animations Material Dialog"),
    );
  }

  Widget btn4(BuildContext context) {
    return MaterialButton(
      color: Colors.grey[300],
      minWidth: 300,
      onPressed: () => Dialogs.bottomMaterialDialog(
        msg: 'Congratulations, you won 500 points',
        title: 'Congratulations',
        color: Colors.white,
        lottieBuilder: Lottie.asset(
          'assets/cong_example.json',
          fit: BoxFit.contain,
        ),
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'Claim',
            iconData: Icons.done,
            color: Colors.blue,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ],
      ),
      child: const Text("Show animations Bottom Dialog"),
    );
  }
}
