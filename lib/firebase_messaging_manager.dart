import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_manager/model/notification_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'model/notification.dart' as notification_model;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class FirebaseMessagingManager {
  FirebaseMessagingManager._privateConstructor();

  static final FirebaseMessagingManager _instance = FirebaseMessagingManager._privateConstructor();

  static FirebaseMessagingManager get instance => _instance;

  NotificationCallback? notificationCallback;

  Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance
        .requestPermission(announcement: true, carPlay: true, criticalAlert: true)
        .then((value) {
      debugPrint("Firebase status::${value.authorizationStatus}");
    });
    getToken();
    //initNotifications();
    FirebaseMessaging.onMessage.listen((message) {
      notificationMessageHandler(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
      if (message != null) {
        Future.delayed(const Duration(milliseconds: 4000), () {
          _onLaunchNotification(message);
        });
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        Future.delayed(const Duration(milliseconds: 4000), () {
          _onLaunchNotification(message);
        });
      }
    });
  }

  configureCallBackForClick(NotificationCallback notificationCallback) {
    this.notificationCallback = notificationCallback;
  }

  Future<String?> getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      debugPrint("Token: $token");
      return token;
    } catch (error) {
      debugPrint(error.toString());
      return "N/A";
    }
  }

  _onLaunchNotification(RemoteMessage? message) async {
    debugPrint("Message: ${jsonEncode(message?.data)}");
    notification_model.Notification? notification = notification_model.Notification.fromJson(message?.data ?? {});
    if (notification.type != null) openNotificationDetailScreen(notification, notificationCallback);
  }
}

void openNotificationDetailScreen(
    notification_model.Notification notification, NotificationCallback? notificationCallback) {
  if (notificationCallback?.onNotificationClick != null) {
    notificationCallback?.onNotificationClick!(id: notification.id, type: notification.type);
  }
}

/*void initNotifications() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = const IOSInitializationSettings();
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _onNotificationSelect);
}

Future _onNotificationSelect(String? payload) async {
  if (payload != null) {
    notification_model.Notification? notification = notification_model.Notification.fromJson(jsonDecode(payload));
    if (notification.type != null) openNotificationDetailScreen(notification);
  }
}*/

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Remote Message in Background");
  //notificationMessageHandler(message);
}

notificationMessageHandler(RemoteMessage message) async {
  debugPrint(
      "Message: ${jsonEncode(message.data)} or ${message.notification?.title} and ${message.notification?.body}");
  notification_model.Notification? notification =
      notification_model.Notification.fromJson((message.notification?.toMap()) ?? {});
  showNotificationWithDefaultSound(notification.id, notification.title, notification.body, notification);
}

Future showNotificationWithDefaultSound(
    String? id, String? title, String? body, notification_model.Notification? notification) async {
  debugPrint("Title : $title Body : $body");
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
  flutterLocalNotificationsPlugin
      .show(
          int.parse(id ?? "0"),
          title,
          body,
          NotificationDetails(
              iOS: iOSPlatformChannelSpecifics,
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description, icon: 'app_icon')),
          payload: jsonEncode(notification))
      .catchError((error) {
    print("Error: $error");
  });
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'iguard_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
