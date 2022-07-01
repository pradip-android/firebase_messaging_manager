import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart' as fb_core;
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

  Future<void> init({NotificationCallback? notificationCallback}) async {
    try {
      await fb_core.Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      this.notificationCallback = notificationCallback;
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(announcement: true, carPlay: true, criticalAlert: true);
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        debugPrint('User granted provisional permission');
      } else {
        debugPrint('User declined or has not accepted permission');
      }
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      getToken();
      //initNotifications();
      FirebaseMessaging.onMessage.listen((message) {
        notificationMessageHandler(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
        if (message != null) {
          _onLaunchNotification(message);
        }
      });

      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
        if (message != null) {
          _onLaunchNotification(message);
        }
      });
    } catch (error) {
      debugPrint("Firebase Initialisation Error : $error");
    }
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
    openNotificationDetailScreen(message?.data ?? {}, notificationCallback);
  }
}

void openNotificationDetailScreen(Map<String, dynamic> data, NotificationCallback? notificationCallback) {
  if (notificationCallback?.onNotificationClick != null) {
    notificationCallback?.onNotificationClick!(data: data);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await fb_core.Firebase.initializeApp();
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
