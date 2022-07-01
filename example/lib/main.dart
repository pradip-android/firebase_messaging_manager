import 'package:firebase_messaging_manager/firebase_messaging_manager.dart';
import 'package:firebase_messaging_manager/model/notification_callback.dart';
import 'package:flutter/material.dart';

void main() async {
  await FirebaseMessagingManager.instance
      .init(notificationCallback: NotificationCallback(onNotificationClick: onNotificationClick));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() async {
    super.initState();
    String? token = await FirebaseMessagingManager.instance.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: const Text('Running on:'),
        ),
      ),
    );
  }
}

void onNotificationClick({Map<String, dynamic>? data}) {
  print("onNotificationClick : $data");
}
