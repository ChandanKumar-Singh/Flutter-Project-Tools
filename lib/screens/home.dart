import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/providers/setting_provider.dart';
import 'package:my_global_tools/route_management/route_path.dart';
import 'package:my_global_tools/utils/my_toasts.dart';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:my_global_tools/widgets/dialogs_page.dart';
import 'package:my_global_tools/providers/connectivity_provider.dart';
import 'package:my_global_tools/utils/my_advanved_toasts.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:provider/provider.dart';

import '../widgets/app_web_view_page.dart';

Widget _buildItem(
  BuildContext context,
  MyToastModel item,
  int index,
  Animation<double> animation,
) {
  return ToastItem(
    animation: animation,
    item: item,
    onTap: () => context.hideToast(
      item,
      (context, animation) => _buildItem(context, item, index, animation),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, settingProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Connectivity Demo'),
            actions: [
              IconButton(
                  onPressed: () => settingProvider.setThemeMode(context),
                  icon: Icon(settingProvider.themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode))
            ],
          ),
          body: Consumer<ConnectivityProvider>(
            builder: (context, provider, _) {
              return ListView(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Text(
                          provider.getOnline ? 'Online' : 'Offline',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder())),
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
                        onPressed: () => context.showToast(MyToastModel(
                            ToastType.failed.name, ToastType.success)),
                        child: const Icon(Icons.add_a_photo),
                      ),
                      bodyLargeText('Elegant Notifications', context),
                      FilledButton(
                        onPressed: () => AdvanceToasts.showNormalElegant(
                            context,
                            'An elegant notification to display important',
                            showProgressIndicator: false,
                            notificationType: NotificationType.success),
                        child: const Icon(Icons.add_a_photo),
                      ),
                      FilledButton(
                        onPressed: () => AdvanceToasts.showNormalElegant(
                            context,
                            'An elegant notification to display important',
                            showProgressIndicator: false,
                            notificationType: NotificationType.info),
                        child: const Icon(Icons.add_a_photo),
                      ),
                      FilledButton(
                        onPressed: () => AdvanceToasts.showNormalElegant(
                            context,
                            'An elegant notification to display important',
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
                        onPressed: () => AdvanceToasts.showNormalElegant(
                            context,
                            'An elegant notification to display important messages to users',
                            showProgressIndicator: false,
                            showLeading: false,
                            showTrailing: false),
                        child: const Icon(Icons.add_a_photo),
                      ),
                      FilledButton(
                        onPressed: () => AdvanceToasts.showNormalElegant(
                            context,
                            'An elegant notification to display important',
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
                            MaterialPageRoute(
                                builder: (_) => const DialogPage())),
                        child: const Icon(Icons.add_a_photo),
                      ),
                      const Divider(),
                      bodyLargeText('Web View', context),
                      FilledButton(
                        onPressed: () => context.goNamed(RoutePath.explore),
                        child: const Icon(Icons.map_sharp),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
