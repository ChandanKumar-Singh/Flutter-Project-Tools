// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart' hide Response;
// import 'package:mycarclub/constants/app_constants.dart';
// import 'package:mycarclub/database/functions.dart';
// import 'package:mycarclub/database/repositories/auth_repo.dart';
// import 'package:mycarclub/time_line_main_page.dart';
// import 'package:mycarclub/providers/notification_provider.dart';
// import 'package:mycarclub/screens/dashboard/main_page.dart';
// import 'package:mycarclub/screens/drawerPages/inbox/inbox_screen.dart';
// import 'package:mycarclub/sl_container.dart';
// import 'package:mycarclub/utils/default_logger.dart';
// import 'package:mycarclub/utils/default_logger.dart';
// import 'package:mycarclub/utils/network_info.dart';
// import 'package:mycarclub/utils/notification_sqflite_helper.dart';
// import 'package:path_provider/path_provider.dart';
//
// import '../myapp.dart';
// import '../screens/Notification/notification_page.dart';
//
// int id = 0;
//
// final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
//     StreamController<ReceivedNotification>.broadcast();
//
// final StreamController<String?> selectNotificationStream =
//     StreamController<String?>.broadcast();
//
// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');
//
// const String portName = 'notification_send_port';
//
// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });
//
//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }
//
// String? selectedNotificationPayload;
//
// /// A notification action which triggers a url launch event
// const String urlLaunchActionId = 'id_1';
//
// /// A notification action which triggers a App navigation event
// const String navigationActionId = 'id_3';
//
// /// Defines a iOS/MacOS notification category for text input actions.
// const String darwinNotificationCategoryText = 'textCategory';
//
// /// Defines a iOS/MacOS notification category for plain actions.
// const String darwinNotificationCategoryPlain = 'plainCategory';
//
// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // ignore: avoid_print
//   infoLog(
//       'notificationTapBackground notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}',
//       MyNotification.tag);
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     // ignore: avoid_print
//     // infoLog(data,MyNotification.tag)(
//     //     'notification action tapped with input: ${notificationResponse.input}');
//   }
// }
//
// bool _notificationsEnabled = false;
//
// class MyNotification {
//   static const String tag = 'MyNotification';
//   Future<void> initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     final FirebaseMessaging messaging = FirebaseMessaging.instance;
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);
//     await FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true);
//
//     ///flp initialisation
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/launcher_icon');
//     final List<DarwinNotificationCategory> darwinNotificationCategories =
//         <DarwinNotificationCategory>[
//       DarwinNotificationCategory(
//         darwinNotificationCategoryText,
//         actions: <DarwinNotificationAction>[
//           DarwinNotificationAction.text('text_1', 'Action 1',
//               buttonTitle: 'Send', placeholder: 'Placeholder')
//         ],
//       ),
//       DarwinNotificationCategory(
//         darwinNotificationCategoryPlain,
//         actions: <DarwinNotificationAction>[
//           DarwinNotificationAction.plain('id_1', 'Action 1'),
//           DarwinNotificationAction.plain(
//             'id_2',
//             'Action 2 (destructive)',
//             options: <DarwinNotificationActionOption>{
//               DarwinNotificationActionOption.destructive,
//             },
//           ),
//           DarwinNotificationAction.plain(
//             navigationActionId,
//             'Action 3 (foreground)',
//             options: <DarwinNotificationActionOption>{
//               DarwinNotificationActionOption.foreground,
//             },
//           ),
//           DarwinNotificationAction.plain(
//             'id_4',
//             'Action 4 (auth required)',
//             options: <DarwinNotificationActionOption>{
//               DarwinNotificationActionOption.authenticationRequired,
//             },
//           ),
//         ],
//         options: <DarwinNotificationCategoryOption>{
//           DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
//         },
//       )
//     ];
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification:
//           (int id, String? title, String? body, String? payload) async {
//         didReceiveLocalNotificationStream.add(
//           ReceivedNotification(
//             id: id,
//             title: title,
//             body: body,
//             payload: payload,
//           ),
//         );
//       },
//       notificationCategories: darwinNotificationCategories,
//     );
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       macOS: initializationSettingsDarwin,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse:
//           (NotificationResponse notificationResponse) {
//         switch (notificationResponse.notificationResponseType) {
//           case NotificationResponseType.selectedNotification:
//             selectNotificationStream
//                 .add(parseHtmlString(notificationResponse.payload ?? ""));
//             break;
//           case NotificationResponseType.selectedNotificationAction:
//             if (notificationResponse.actionId == navigationActionId) {
//               selectNotificationStream
//                   .add(parseHtmlString(notificationResponse.payload ?? ''));
//             }
//             break;
//         }
//       },
//       onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );
//
//     final RemoteMessage? initialMessages = await messaging.getInitialMessage();
//     if (initialMessages != null) {
//       ///TODO:handle the initial messages
//     }
//     infoLog(
//         'this is FirebaseMessaging on initialMessages ${initialMessages?.data}',
//         tag);
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _handleNotificationData(message, flutterLocalNotificationsPlugin, true);
//     });
//     //TODO:Periodic notification
//     /*    flutterLocalNotificationsPlugin.periodicallyShow(
//       1,
//       "Testing Notification",
//       'Hello Everyone. It\'s ${DateFormat().add_jm().format(DateTime.now())}',
//       RepeatInterval.hourly,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           'Periodic',
//           'Testing',
//           channelDescription: 'your channel desc',
//           importance: Importance.max,
//           priority: Priority.max,
//           playSound: true,
//         ),
//       ),
//       payload: jsonEncode({
//        "title": "Testing Notification",
//         "body":'Hello Everyone. It\'s ${DateFormat().add_jm().format(DateTime.now())}',
//       }),
//     );*/
//     // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     //   // infoLog(data)('this is FirebaseMessaging onMessageOpenedApp ',MyNotification.tag);
//     //   // showNotification(message,flutterLocalNotificationsPlugin,false);
//     //   infoLog(data,MyNotification.tag)(
//     //       "onOpenApp: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
//     //   // try {
//     //   //   if (message.notification?.titleLocKey != null &&
//     //   //       (message.notification?.titleLocKey ?? '').isNotEmpty) {
//     //   //     MyCarClub.navigatorKey.currentState?.push(MaterialPageRoute(
//     //   //         builder: (context) => NotificationPage(
//     //   //             // orderModel: null,
//     //   //             // orderId: int.parse(message.notification?.titleLocKey),
//     //   //             // orderType: 'default_type',
//     //   //             )));
//     //   //   }
//     //   // } catch (e) {}
//     // });
//     void _handleMessage(RemoteMessage message) {
//       infoLog('notification is selected now ', MyNotification.tag);
//       selectNotificationStream.add(parseHtmlString(jsonEncode(message.data)));
//       MyCarClub.navigatorKey.currentState
//           ?.pushNamed(NotificationPage.routeName, arguments: message.data);
//     }
//
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
//   }
//
//   // routing
//   static Future<void> isAndroidPermissionGranted() async {
//     if (Platform.isAndroid) {
//       final bool granted = await flutterLocalNotificationsPlugin
//               .resolvePlatformSpecificImplementation<
//                   AndroidFlutterLocalNotificationsPlugin>()
//               ?.areNotificationsEnabled() ??
//           false;
//       _notificationsEnabled = granted;
//     }
//   }
//
//   static Future<void> requestPermissions() async {
//     if (Platform.isIOS || Platform.isMacOS) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(alert: true, badge: true, sound: true);
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               MacOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(alert: true, badge: true, sound: true);
//     } else if (Platform.isAndroid) {
//       final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//           flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();
//
//       final bool? granted = await androidImplementation?.requestPermission();
//       _notificationsEnabled = granted ?? false;
//     }
//   }
//
//   static void configureDidReceiveLocalNotificationSubject() {
//     didReceiveLocalNotificationStream.stream
//         .listen((ReceivedNotification receivedNotification) async {
//       await showDialog(
//         context: Get.context!,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//           title: receivedNotification.title != null
//               ? Text(receivedNotification.title!)
//               : null,
//           content: receivedNotification.body != null
//               ? Text(receivedNotification.body!)
//               : null,
//           actions: <Widget>[
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               onPressed: () async {
//                 warningLog(
//                     'notification tapped from _configureDidReceiveLocalNotificationSubject',
//                     tag,
//                     'configureDidReceiveLocalNotificationSubject');
//                 Navigator.of(context, rootNavigator: true).pop();
//                 await MyCarClub.navigatorKey.currentState?.pushNamed(
//                     NotificationPage.routeName,
//                     arguments: receivedNotification.payload);
//               },
//               child: const Text('Ok'),
//             )
//           ],
//         ),
//       );
//     });
//   }
//
//   static void configureSelectNotificationSubject() {
//     selectNotificationStream.stream.listen((String? payload) async {
//       warningLog('notification tapped from _configureSelectNotificationSubject',
//           tag, 'configureSelectNotificationSubject');
//
//       Map<String, dynamic>? data = payload != null ? jsonDecode(payload) : null;
//       if (data != null) {
//         String? _topic = data['topic'];
//         String? _type = data['type'];
//         String? routeName;
//         infoLog(
//             'notification type is ${_type}  and it has match with ${matchType(_type, notificationType.inbox)}',
//             MyNotification.tag);
//         if (matchType(_type, notificationType.inbox)) {
//           routeName = InboxScreen.routeName;
//         } else {
//           routeName = NotificationPage.routeName;
//         }
//         await MyCarClub.navigatorKey.currentState
//             ?.pushNamed(routeName ?? MainPage.routeName, arguments: payload);
//       }
//     });
//   }
// }
//
// Future<void> _handleNotificationData(RemoteMessage message,
//     FlutterLocalNotificationsPlugin fln, bool data) async {
//   String _title;
//   String _body;
//   String? payload;
//   String? _image;
//   if (data) {
//     _title = parseHtmlString(message.data['title'] ?? '');
//     _body = parseHtmlString(message.data['body'] ?? '');
//     payload = jsonEncode(message.data);
//     _image = _getImageFromData(message);
//   } else {
//     _title = parseHtmlString(message.notification?.title ?? '');
//     _body = parseHtmlString(message.notification?.body ?? '');
//     if (Platform.isAndroid) {
//       _image = _getImageAndroidImage(message);
//     } else if (Platform.isIOS) {
//       _image = _getImageIosImage(message);
//     }
//   }
//
//   infoLog('image to show in notification is $_image', MyNotification.tag);
//   String localUser = (await sl.get<AuthRepo>().getUserID()).toLowerCase();
//   Map<String, dynamic> _data = payload != null ? jsonDecode(payload) ?? {} : {};
//   String unknownUser = 'unknown';
//   String notificationUser = (_data['user_id'] ?? '').toString().toLowerCase();
//   String topic = _data['topic'] ?? 'none';
//   String type = _data['type'] ?? '';
//   try {
//     infoLog(
//         'localUser user id $localUser   and  notificationUser is ** $notificationUser **',
//         MyNotification.tag);
//
//     /// 1. if notification is to specific user
//     // if ((topic == '' || topic == topics.testing.name)) {
//     /// 3. store if notification user is not blank
//     if (notificationUser != '') {
//       /// store
//       ///check for type
//       infoLog(
//           'notification type is ${type}  and it has match with ${matchType(type, notificationType.inbox)}',
//           MyNotification.tag);
//       if (!matchType(type, notificationType.inbox)) {
//         ///store notifications
//         await storeNotification(_title, notificationUser,
//                 data: jsonEncode(message.data))
//             .then((value) async {
//           infoLog('notification createItem to local db successfully!👏',
//               MyNotification.tag, notificationUser);
//           addToNotificationStream();
//           infoLog('notification added to controller successfully!👏',
//               MyNotification.tag, localUser);
//         }).then((value) => sl.get<NotificationProvider>().getUnRead());
//       }
//
//       /// 4. if user logged in
//       if (localUser != '') {
//         /// 6. check for same user
//         if (localUser == notificationUser) {
//           // show notification and navigate to the content
//           showDynamicNotification(_title, _body, payload, _image, fln);
//         }
//
//         /// 7. handle for diff user
//         else {
//           // don't show the notification
//         }
//       }
//
//       /// 5. if user not logged in
//       else {
//         // show login notification
//         showDynamicNotification('New message',
//             'Authentication required to read the message.', payload, null, fln);
//       }
//     }
//
//     ///   if notification user is blank
//     else {
//       infoLog('this is topic notification', MyNotification.tag);
//       await storeNotification(_title, localUser != '' ? localUser : unknownUser,
//               data: jsonEncode(message.data))
//           .then((value) async {
//         infoLog('notification createItem to local db successfully!👏',
//             MyNotification.tag, localUser != '' ? localUser : unknownUser);
//         addToNotificationStream();
//         infoLog('notification added to controller successfully!👏',
//             MyNotification.tag, localUser != '' ? localUser : unknownUser);
//       }).then((value) => sl.get<NotificationProvider>().getUnRead());
//       showDynamicNotification(_body, _body, payload, _image, fln);
//     }
//     // }
//
//     /// 2. handle topic notification
//     // else {
//     //   infoLog('handling topic notification to local db', MyNotification.tag);
//     //   await storeNotification(_title, 'unknown', data: jsonEncode(message.data))
//     //       .then((value) async {
//     //     infoLog('Topic notification createItem to local db successfully!👏',
//     //         MyNotification.tag);
//     //     addToNotificationStream();
//     //     infoLog('Topic notification added to controller successfully!👏',
//     //         MyNotification.tag);
//     //   }).then((value) => sl.get<NotificationProvider>().getUnRead());
//     //   showDynamicNotification(_title, _body, payload, _image, fln);
//     // }
//   } catch (e) {
//     infoLog('adding notification to local db failed', MyNotification.tag);
//   }
// }
//
// bool matchType(data, notificationType _type) {
//   return data != null && data.toString().toLowerCase() == _type.name;
// }
//
// Future<void> showDynamicNotification(String title, String body, String? payload,
//     String? image, FlutterLocalNotificationsPlugin fln) async {
//   infoLog(
//       'Finally notification -> title $title -> body $body -> payLoad $payload -> image $image ',
//       MyNotification.tag,
//       'showDynamicNotification');
//
//   //show notification
//   if (image != null && image.isNotEmpty) {
//     try {
//       await _showBigPictureNotificationHiddenLargeIcon(
//           title, body, payload, image, fln);
//     } catch (e) {
//       await _showBigTextNotification(title, body, payload, fln);
//     }
//   } else {
//     await _showBigTextNotification(title, body, payload, fln);
//   }
// }
//
// void addToNotificationStream() async => sl
//     .get<NotificationProvider>()
//     .notifications
//     .add(await sl.get<NotificationDatabaseHelper>().listenToSqlNotifications());
//
// Future<int> storeNotification(String? title, String? userId,
//     {dynamic data}) async {
//   return await sl
//       .get<NotificationDatabaseHelper>()
//       .createItem(title, userId, additional: data);
// }
//
// String? _getImageFromData(RemoteMessage message) {
//   return (message.data['image'] != null && message.data['image'].isNotEmpty)
//       ? message.data['image'].startsWith('http') ||
//               message.data['image'].startsWith('https')
//           ? message.data['image']
//           : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}'
//       : null;
// }
//
// String? _getImageAndroidImage(RemoteMessage message) {
//   var android = message.notification?.android;
//   return (android != null && android.imageUrl != null)
//       ? android.imageUrl!.startsWith('http') ||
//               android.imageUrl!.startsWith('https')
//           ? android.imageUrl!
//           : '${AppConstants.baseUrl}/storage/app/public/notification/${android.imageUrl}'
//       : null;
// }
//
// String? _getImageIosImage(RemoteMessage message) {
//   var apple = message.notification?.apple;
//   return (apple != null && apple.imageUrl != null)
//       ? apple.imageUrl!.startsWith('http') ||
//               apple.imageUrl!.startsWith('https')
//           ? apple.imageUrl!
//           : '${AppConstants.baseUrl}/storage/app/public/notification/${apple.imageUrl}'
//       : null;
// }
//
// // if (payload['topic'].toLowerCase() == 'survey') {
// // WidgetsBinding.instance.addPostFrameCallback((_) {
// // showSurvey(int.tryParse(payload['id']));
// // });
// // }
//
// Future<void> _showTextNotification(String title, String body, String payload,
//     FlutterLocalNotificationsPlugin fln) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your channel id',
//     'your channel name',
//     channelDescription: 'your channel desc',
//     playSound: true,
//     importance: Importance.max,
//     priority: Priority.max,
//     sound: RawResourceAndroidNotificationSound('notification'),
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await fln.show(0, title, body, platformChannelSpecifics, payload: payload);
// }
//
// Future<void> _showBigTextNotification(String title, String body,
//     String? payload, FlutterLocalNotificationsPlugin fln) async {
//   BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//     body,
//     htmlFormatBigText: true,
//     contentTitle: title,
//     htmlFormatContentTitle: true,
//   );
//   AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your channel id',
//     'your channel name',
//     channelDescription: 'your channel desc',
//     importance: Importance.max,
//     styleInformation: bigTextStyleInformation,
//     priority: Priority.max,
//     playSound: true,
//     // sound: RawResourceAndroidNotificationSound('notification'),
//   );
//   NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await fln.show(0, title, body, platformChannelSpecifics, payload: payload);
// }
//
// Future<void> _showBigPictureNotificationHiddenLargeIcon(
//     String title,
//     String body,
//     String? payload,
//     String image,
//     FlutterLocalNotificationsPlugin fln) async {
// // infoLog(data)('this is big picture notification',MyNotification.tag);
//   final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
//   final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
//   final BigPictureStyleInformation bigPictureStyleInformation =
//       BigPictureStyleInformation(
//     FilePathAndroidBitmap(bigPicturePath),
//     hideExpandedLargeIcon: true,
//     contentTitle: title,
//     htmlFormatContentTitle: true,
//     summaryText: body,
//     htmlFormatSummaryText: true,
//   );
//   final AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your channel id',
//     'your channel name',
// // 'your channel desc',
//     largeIcon: FilePathAndroidBitmap(largeIconPath),
//     priority: Priority.max,
//     playSound: true,
//     styleInformation: bigPictureStyleInformation,
//     importance: Importance.max,
// // sound: RawResourceAndroidNotificationSound('notification'),
//   );
//   final NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await fln.show(0, title, body, platformChannelSpecifics, payload: payload);
// }
//
// Future<String> _downloadAndSaveFile(String url, String fileName) async {
//   final Directory directory = await getApplicationDocumentsDirectory();
//   final String filePath = '${directory.path}/$fileName';
//   final Response response =
//       await Dio().get(url, options: Options(responseType: ResponseType.bytes));
//   final File file = File(filePath);
//   await file.writeAsBytes(response.data);
//   return filePath;
// }
//
// @pragma('vm:entry-point')
// Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await initRepos().then((value) async {
//     await sl.get<NetworkInfo>().isConnected;
//     await sl.get<NotificationDatabaseHelper>().db();
//   });
//   infoLog("Handling a background message: ${message.messageId}",
//       MyNotification.tag);
//   var title = parseHtmlString(message.data['title']);
//   var body = parseHtmlString(message.data['body']);
//   await FirebaseMessaging.instance.getInitialMessage();
//   AndroidNotificationChannel channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );
//
//   BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//     body,
//     htmlFormatBigText: true,
//     contentTitle: title,
//     htmlFormatContentTitle: true,
//   );
//   AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your channel id',
//     'your channel name',
//     channelDescription: 'your channel desc',
//     importance: Importance.max,
//     styleInformation: bigTextStyleInformation,
//     priority: Priority.high,
//     playSound: true,
//     // sound: RawResourceAndroidNotificationSound('notification'),
//   );
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true, badge: true, sound: true);
//   _handleNotificationData(message, flutterLocalNotificationsPlugin, true);
//   // await flutterLocalNotificationsPlugin
//   //     .show(0, title, body, platformChannelSpecifics, payload: 'orderID');
// }
//
// enum notificationType { inbox, notification, subscription }
//
// enum topics { none, all, testing }
