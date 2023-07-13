import 'package:animated_toast_list/animated_toast_list.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:my_global_tools/providers/connectivity_provider.dart';
import 'package:my_global_tools/utils/my_toasts.dart';
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  Center(
                    child: Text(
                      provider.isOnline ? 'Online' : 'Offline',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  FilledButton(
                    onPressed: () => Toasts.successBanner(),
                    child: Icon(Icons.add),
                  ),
                  FilledButton(
                    onPressed: () => Toasts.showAwesomeToast(context,
                        title: 'title',
                        content: 'content',
                        contentType: ContentType.success,
                        asBanner: true),
                    child: Icon(Icons.add_a_photo),
                  ),
                  FilledButton(
                    onPressed: () => context.showToast(
                        MyToastModel(ToastType.failed.name, ToastType.success)),
                    child: Icon(Icons.add_a_photo),
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
