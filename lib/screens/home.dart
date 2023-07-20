import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/functions/functions.dart';
import 'package:my_global_tools/providers/auth_provider.dart';
import 'package:my_global_tools/providers/setting_provider.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/screens/components/drawer.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/my_toasts.dart';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:my_global_tools/widgets/custom_bottom_sheet_dialog.dart';
import 'package:my_global_tools/widgets/MultiStageButton.dart';
import 'package:my_global_tools/widgets/FadeScaleTransitionWidget.dart';
import 'package:my_global_tools/widgets/buttonStyle.dart';
import 'package:my_global_tools/widgets/custom_steps_and_pages.dart';
import 'package:my_global_tools/widgets/dialogs_page.dart';
import 'package:my_global_tools/providers/connectivity_provider.dart';
import 'package:my_global_tools/utils/my_advanved_toasts.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/auth_service.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final StreamAuth info = StreamAuthScope.of(context);

    return WillPopScope(
      // onWillPop: () => willPopScope(),
      onWillPop: () async => false,
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Consumer<SettingProvider>(
            builder: (context, settingProvider, child) {
              return Scaffold(
                appBar: buildAppBar(info, settingProvider, context),
                drawer: const MainDrawer(),
                body: buildBody(authProvider),
              );
            },
          );
        },
      ),
    );
  }

  Consumer<ConnectivityProvider> buildBody(AuthProvider authProvider) {
    return Consumer<ConnectivityProvider>(
      builder: (context, provider, _) {
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      provider.getOnline ? 'Online' : 'Offline',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  TextFormField(),
                  FilledButton(
                      onPressed: () => Toasts.warningBanner(),
                      child: const Icon(Icons.add)),
                  FilledButton(
                    onPressed: () => Toasts.showAwesomeToast(context,
                        title: 'title',
                        content: 'content',
                        contentType: ContentType.success,
                        asBanner: true),
                    child: const Icon(Icons.add_a_photo),
                  ),
                  FilledButton(
                    onPressed: () => context.showToast(
                        MyToastModel(ToastType.failed.name, ToastType.success)),
                    child: const Icon(Icons.add_a_photo),
                  ),
                  bodyLargeText('Elegant Notifications', context),
                  MyCustomAnimatedWidget(
                    child: FilledButton(
                      onPressed: () => AdvanceToasts.showNormalElegant(context,
                          'An elegant notification to display important',
                          showProgressIndicator: false,
                          notificationType: NotificationType.success),
                      child: const Icon(Icons.animation),
                    ),
                  ),
                  FilledButton(
                    onPressed: () => AdvanceToasts.showNormalElegant(
                        context, 'An elegant notification to display important',
                        showProgressIndicator: false,
                        notificationType: NotificationType.info),
                    child: const Icon(Icons.add_a_photo),
                  ),
                  FilledButton(
                    onPressed: () => AdvanceToasts.showNormalElegant(
                        context, 'An elegant notification to display important',
                        aDuration: 300,
                        tDuration: 7000,
                        action: linkifyText(
                            'Contact Us: https://www.mycarclub.com/refCode?sponsor=tds'),
                        onActionPressed: () => log(
                            'https://www.mycarclub.com/refCode?sponsor=tds'),
                        notificationType: NotificationType.error),
                    child: const Icon(Icons.add_a_photo),
                  ),
                  FilledButton(
                    onPressed: () => AdvanceToasts.showNormalElegant(context,
                        'An elegant notification to display important messages to users',
                        showProgressIndicator: false,
                        showLeading: false,
                        showTrailing: false),
                    child: const Icon(Icons.add_a_photo),
                  ),
                  FilledButton(
                    onPressed: () => AdvanceToasts.showNormalElegant(
                        context, 'An elegant notification to display important',
                        // aDuration: 300,
                        // tDuration: 7000,
                        // action: linkifyText(
                        //     'https://www.mycarclub.com/refCode?sponsor=tds'),
                        // onActionPressed: () => log(
                        //     'https://www.mycarclub.com/refCode?sponsor=tds'),
                        // showLeading: false,
                        // showTrailing: false,
                        showProgressIndicator: false,
                        notificationType: NotificationType.error),
                    child: const Icon(Icons.add_a_photo),
                  ),
                  const Divider(),
                  bodyLargeText('Dialogs', context),
                  FilledButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const DialogPage())),
                    child: const Icon(Icons.add_a_photo),
                  ),
                  const Divider(),
                  bodyLargeText('Web View', context),
                  FilledButton(
                    onPressed: () => context.goNamed(RoutePath.explore),
                    child: const Icon(Icons.map_sharp),
                  ),
                  const Divider(),
                  bodyLargeText('Multi Stage Button', context),
                  Row(
                    children: [
                      Expanded(
                        child: MultiStageButton(
                            // idleIcon: const Icon(Icons.start,color: Colors.black),
                            // completedIcon: SizedBox(
                            //     height: 30,
                            //     width: 30,
                            //     child: assetRive(RiveAssets.successDone)),
                            loadingText: 'Loading...',
                            buttonLoadingState: authProvider.loginStatus,
                            // idleColor: Colors.white,
                            // completedColor: Colors.white,
                            // failColor: Colors.white,
                            // idleTextColor: Colors.black,
                            // failTextColor: Colors.red,
                            // completedTextColor: Colors.green,
                            helperText: authProvider.errorText,
                            onPressed: () => authProvider.login(status: false)),
                      ),
                    ],
                  ),
                  const Divider(),
                  bodyLargeText('Bottom Sheets', context),
                  FilledButton(
                    onPressed: () => showCustomBottomSheet(context),
                    child: const Text('Custom Bottom Sheet'),
                  ),
                  const Divider(),
                  bodyLargeText('Multi Step Widget', context),
                  FilledButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MultiStepWidget())),
                    child: const Text('Multi Step Widget'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showCustomBottomSheet(BuildContext context) {
    CustomBottomSheet.show(
      context: context,
      curve: Curves.bounceIn,
      duration: 200,
      dismissible: false,
      onDismiss: () async {
        bool? willPop = await CustomBottomSheet.show<bool>(
          context: context,
          // backgroundColor: Colors.transparent,
          showCloseIcon: false,
          curve: Curves.bounceIn,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      style: buttonStyle(bgColor: Colors.green),
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Confirm'),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      style: buttonStyle(bgColor: Colors.red),
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        logD('will pop scope $willPop');
        return willPop ?? false;
      },
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Custom Bottom Sheet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const FlutterLogo(size: 100),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close')),
          ],
        );
      },
    );
  }

  AppBar buildAppBar(
      StreamAuth info, SettingProvider settingProvider, BuildContext context) {
    return AppBar(
      title: Text(getLang.helloWorld),
      actions: [
        IconButton(
          onPressed: () => info.signOut(),
          tooltip: 'Logout: ${info.currentUser}',
          icon: const Icon(Icons.logout),
        ),
        IconButton(
            onPressed: () => settingProvider.setThemeMode(context),
            icon: Icon(settingProvider.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode))
      ],
    );
  }
}
