import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:my_global_tools/constants/app_const.dart';
import 'package:my_global_tools/repo_injection.dart';
import 'package:my_global_tools/route_management/my_router.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/default_logger.dart';
import 'package:my_global_tools/utils/my_advanved_toasts.dart';
import 'package:my_global_tools/utils/my_dialogs.dart';
import 'package:my_global_tools/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

import 'providers/setting_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initRepos();
  runApp(const MyApp());
}

bool _initialUriIsHandled = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uri? _initialUri;
  Uri? _latestUri;
  String? _path;
  Object? _err;
  String tag = 'MyApp';

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        infoLog('got uri: $uri', tag);
        setState(() {
          _latestUri = uri;
          _err = null;
          if (uri != null) {
            _path = uri.path;
            if (_path != null) {
              warningLog('Found a path $_path', tag);
              try {
              } catch (e) {
                errorLog('Error while passing dep link $_path   $e', tag);
              }
            }
          }
        });
      }, onError: (Object err) {
        if (!mounted) return;
        infoLog('got err: $err', tag);
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a widget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      AdvanceToasts.showNormalElegant(context, '_handleInitialUri called');
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          infoLog('no initial uri', tag);
        } else {
          infoLog('got initial uri: $uri', tag);
        }
        if (!mounted) return;
        setState(() => _initialUri = uri);
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        infoLog('failed to get initial uri', tag);
      } on FormatException catch (err) {
        if (!mounted) return;
        infoLog('malformed initial uri', tag);
        setState(() => _err = err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var notifiers = getNotifiers;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: notifiers,
        child: Consumer<SettingProvider>(
          builder: (context, settingProvider, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              themeMode: settingProvider.themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              title: AppConst.appName,
              routerConfig: MyRouter.router(_path),
            );
          },
        ),
      ),
    );
  }
}
