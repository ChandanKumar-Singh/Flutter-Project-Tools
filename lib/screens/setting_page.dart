import 'package:flutter/material.dart';
import '/functions/functions.dart';
import '/utils/sized_utils.dart';
import '/widgets/custom_bottom_sheet_dialog.dart';
import '/widgets/app_language_change_widget.dart';
import 'package:provider/provider.dart';

import '../providers/setting_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(getLang.settings),
          ),
          body: ListView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            children: [
              height5(),
              ListTile(
                // tileColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                title: Text(getLang.notification),
                trailing: const Icon(Icons.notifications),
              ),
              height5(),
              ListTile(
                // tileColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                title: Text(getLang.sound),
                trailing: const Icon(Icons.volume_up),
              ),
              height5(),
              ListTile(
                // tileColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                title: Text(getLang.darkMode),
                trailing: GestureDetector(
                    onTap: () => provider.setThemeMode(context),
                    child: Icon(provider.themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode)),
              ),
              height5(),
              ListTile(
                  // tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                  title: Row(children: [Text(getLang.language)]),
                  trailing: Container(
                    constraints: const BoxConstraints(maxWidth: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(provider.currentLanguage.name),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () => showLanguagePicker(context, provider)),
            ],
          ),
        );
      },
    );
  }

  void showLanguagePicker(BuildContext context, SettingProvider provider) =>
      CustomBottomSheet.show(
          context: context, builder: (_) => AppLanguageWidget());
}
