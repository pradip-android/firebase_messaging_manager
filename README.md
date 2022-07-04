# Firebase Messaging Manager

<p> This plugin will help you to configure onClick of Push Notification and also will help you to handle click of Notification. You just need to send push notification with below Format from server side.</p>

<details>
<summary>With Legacy Enabled Push Notification</summary>
<br/>

[https://fcm.googleapis.com/fcm/send](https://fcm.googleapis.com/fcm/send)

#### Header:

```Authorization : key=Your_Server_Key```

#### Payload:

```
      {
        "notification": {
            "body": "body",
            "title": "title",
            "mutable_content": false,
            "click_action": "FLUTTER_NOTIFICATION_CLICK"
        },
        "data":{
            "type":"type",
            "id":"id"
        },
        "to": "Your_Device_Token"
      }
```

</details>

<details>
<summary>With Http V1 Push Notification</summary>
<br/>

[https://fcm.googleapis.com/v1/projects/[Your-Project-ID]/messages:send](https://fcm.googleapis.com/v1/projects/[Your-Project-ID]/messages:send)

#### Header:

- For Authorization please follow below link for Http V1.\
  [https://firebase.google.com/docs/cloud-messaging/migrate-v1#update-authorization-of-send-requests](https://firebase.google.com/docs/cloud-messaging/migrate-v1#update-authorization-of-send-requests)

#### Payload:

```
        {
    "message": {
        "token": "your_device_token",
        "notification": {
            "title": "title",
            "body": "body"
        },
        "data": {
            "type": "type",
            "id": "id"
        },
        "android": {
            "notification": {
                "click_action": "FLUTTER_NOTIFICATION_CLICK"
            }
        },
        "apns": {
            "payload": {
                "aps": {
                    "mutable-content": 1,
                    "content-available": 1
                }
            }
        }
    }
}
```

</details>

## Table Of Contents

* [Installation](#Installation)
* [Setup](#Setup)
* [How To Use](#how-to-use)

## Installation

- Add Below dependency in your `pubspec.yaml` file.

```
firebase_messaging_manager:
    git:
      url: https://github.com/hemang-concetto/firebase_messaging_manager.git
      ref: main
```

## Setup

<details>
<summary>Android</summary>
<br>

- Add `google-services.json` to your `android/app` folder which is connected with your package name.
- Add 'app_icon.png' to your `android/app/src/main/drawable` folder.
- Add below `intent-filter` inside your `AndoridManifest.xml` and wrap it with
  your `MainActivity.kt`.
  ``` 
  <intent-filter>
                    <action android:name="FLUTTER_NOTIFICATION_CLICK" />
                    <category android:name="android.intent.category.DEFAULT" />
                </intent-filter>
  ```
- Add below line to your `android/app/build.gradle` at very bottom.
  ``` apply plugin: 'com.google.gms.google-services' ```

- Add classpath for google-services to your `android/build.gradle` as below.
  ```  classpath 'com.google.gms:google-services:4.3.10'  ```

</details>

<details>
<summary>IOS</summary>
<br>

- Add `GoogleService-Info.plist` to your `ios/Runner` folder which is connected with your bundle id.
- Also setup your iOS account as per below.
  [Configure IOS for Push Notification](https://firebase.google.com/docs/cloud-messaging/ios/client)
- Add below code if you face any error for iOS.
  `<key>FirebaseAppDelegateProxyEnabled</key>
  <false/>`

</details>

## How To Use
- Add below line for the import package.

```
  import 'package:firebase_messaging_manager/firebase_messaging_manager.dart';
```

- Initialize Firebase Manager by below method in your main.dart class inside `main()` method.

```
  await FirebaseMessagingManager.instance
      .init(notificationCallback: NotificationCallback(onNotificationClick: _onNotificationClick));
 
```
- To manage click of notification you have to configure Notification Callback by below.
```
  void _onNotificationClick({Map<String, dynamic>? data}) {
  print("Notification Click : ---------- $data");
  // Here you will get your data when tapping on Push Notification.
  }
 
```

- Also you can get find device token by calling below method

```
    String? token = await FirebaseMessagingManager.instance.getToken();
```

---
