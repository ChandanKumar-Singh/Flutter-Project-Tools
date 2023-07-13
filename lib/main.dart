import 'dart:developer';

import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:my_global_tools/widgets/dialogs_page.dart';
import 'package:my_global_tools/providers/connectivity_provider.dart';
import 'package:my_global_tools/utils/my_advanved_toasts.dart';
import 'package:my_global_tools/utils/my_toasts.dart';
import 'package:my_global_tools/utils/text.dart';
import 'package:provider/provider.dart';

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

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ConnectivityProvider(),
      child: ToastListOverlay<MyToastModel>(
          itemBuilder: (BuildContext context, MyToastModel item, int index,
              Animation<double> animation) {
            return ToastItem(
              animation: animation,
              item: item,
              onTap: () => context.hideToast(
                  item,
                  (context, animation) =>
                      _buildItem(context, item, index, animation)),
            );
          },
          child: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connectivity Demo',
      home: Material(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Connectivity Demo'),
          ),
          body: Consumer<ConnectivityProvider>(
            builder: (context, provider, _) {
              return Column(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Text(
                          provider.getOnline ? 'Online' : 'Offline',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
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
                            MaterialPageRoute(builder: (_) => const DialogPage())),
                        child: const Icon(Icons.add_a_photo),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
