import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/functions/functions.dart';
import 'package:my_global_tools/providers/auth_provider.dart';
import 'package:my_global_tools/providers/setting_provider.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/screens/chat/ChatPageExample.dart';
import 'package:my_global_tools/screens/components/drawer.dart';
import 'package:my_global_tools/screens/send_mail_page.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/my_toasts.dart';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:my_global_tools/utils/sized_utils.dart';
import 'package:my_global_tools/widgets/activity_list_widget.dart';
import 'package:my_global_tools/widgets/app_web_view_page.dart';
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
import 'CachedMediaFileExamplePage.dart';
import 'FastCacheNetworkImageExamplePage.dart';
import 'concentric_onboarding.dart';
import 'container_overlay_example.dart';
import 'container_overlay_example2.dart';
import 'container_overlay_example3.dart';
import 'time_line_page/time_line_main_page.dart';

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
          margin: const EdgeInsetsDirectional.all(10),
          child: ListView(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10, vertical: 20),
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
                    onPressed: () =>
                        context.goNamed(RoutePath.explore, queryParameters: {
                      'url': 'https://vimeo.com/event/3582236/embed',
                      'showAppBar': '1',
                      'showToast': '0',
                      'changeOrientation': '0',
                    }),
                    child: const Icon(Icons.map_sharp),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () =>
                        context.goNamed(RoutePath.explore, queryParameters: {
                      'url': 'https://vimeo.com/event/3582236/embed',
                      'showAppBar': '0',
                      'changeOrientation': '1',
                      'showToast': '0',
                    }),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: Get.width * 0.5,
                        child: Stack(
                          children: [
                            const WebViewExample(
                              url: 'https://vimeo.com/event/3582236/embed',
                              showAppBar: '0',
                              changeOrientation: '0',
                              showToast: '0',
                            ),
                            Container(
                              color: Colors.transparent,
                              width: double.maxFinite,
                              height: double.maxFinite,
                            )
                          ],
                        ),
                      ),
                    ),
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
                      child: const Text('Custom Bottom Sheet')),
                  const Divider(),
                  bodyLargeText('Multi Step Widget', context),
                  FilledButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MultiStepWidget())),
                    child: const Text('Multi Step Widget'),
                  ),
                  const Divider(),
                  bodyLargeText('Custom Activity Widget', context),
                  FilledButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CustomActivityList())),
                    child: const Text('Multi Step Widget'),
                  ),
                  const Divider(),
                  bodyLargeText('My TimeLine App', context),
                  FilledButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MyTimeLineApp())),
                    child: const Text('My TimeLine App'),
                  ),
                  const Divider(),
                  bodyLargeText('Container Overlay Example', context),
                  FilledButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ContainerOverlayExample())),
                    child: const Text('Container Overlay Example'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MyShowcaseViewApp())),
                    child: const Text('Container Overlay Example 2'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MyTutorialCoachMarkPage())),
                    child: const Text('Container Overlay Example 3'),
                  ),
                  const Divider(),
                  bodyLargeText('Concentric OnBoarding Example', context),
                  FilledButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const ConcentricOnBoardingExample())),
                    child: const Text('Concentric OnBoarding Example'),
                  ),
                  const Divider(),
                  bodyLargeText('OnBoarding Screen Package', context),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('flutter_overboard: ^3.1.1'),
                  ),
                  const Divider(),
                  bodyLargeText('Chat App Example', context),
                  FilledButton(
                    onPressed: () {
                      Get.to(const ChatScreen());
                    },
                    child: const Text('Chat App Example'),
                  ),
                  const Divider(),
                  bodyLargeText('Fast Cache NetworkImage ExamplePage', context),
                  FilledButton(
                    onPressed: () {
                      Get.to(const FastCacheNetworkImageExamplePage());
                    },
                    child: const Text('Fast Cache Network Image ExamplePage'),
                  ),
                  const Divider(),
                  bodyLargeText('Cached Media File ExamplePage', context),
                  FilledButton(
                    onPressed: () {
                      Get.to(const CachedMediaFileExamplePage());
                    },
                    child: const Text('Cached Media File ExamplePage'),
                  ),
                     const Divider(),
                  bodyLargeText('Email Sender Page ExamplePage', context),
                  FilledButton(
                    onPressed: () {
                      Get.to(const EmailSenderPage());
                    },
                    child: const Text('Email Sender Page ExamplePage'),
                  ),
                  height100(),
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
