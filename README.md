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
            "type":"type",
            "id":"id",
            "body": "body",
            "title": "title",
            "mutable_content": false
        },
        "data":{
            "type":"type",
            "id":"id",
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "body": "body",
            "title": "title"
        },
        "to": "dBfQ3ArwSwmXB0B9mDEkpf:APA91bGDcPWgnp8VKC79H1P-u6D1fzxH0tieUvTZV-Zxui7jaVmN55S3EmonzgIpGMZrelVRukoDBdOGLe1NYodKklf6olmiAad2iqr9-1tb5obDQufLw1OYkMvlaIHXAWJ6uEgfEdAx"
      }
```

</details>

<details>
<summary>With Http V1 Push Notification</summary>
<br/>

[https://fcm.googleapis.com/v1/projects/[Your-Project-ID]/messages:send](https://fcm.googleapis.com/v1/projects/[Your-Project-ID]/messages:send)

#### Header:

- For Authorization please follow below link for Http V1.
  [https://firebase.google.com/docs/cloud-messaging/migrate-v1#update-authorization-of-send-requests](https://firebase.google.com/docs/cloud-messaging/migrate-v1#update-authorization-of-send-requests)

#### Payload:

```
        {
          "message": {
            "topic": "news",
            "notification": {
              "title": "Breaking News",
              "body": "New news story available."
            },
            "data": {
              "story_id": "story_12345"
            },
            "android": {
              "notification": {
                 "click_action": "TOP_STORY_ACTIVITY"
              }
            },
            "apns": {
              "payload": {
                "aps": {
                  "category" : "NEW_MESSAGE_CATEGORY"
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

</details>

<details>
<summary>IOS</summary>
<br>

- Add `GoogleService-Info.plist` to your `ios/Runner` folder which is connected with your bundle id.
- Also setup your iOS account as per below.
  [Configure IOS for Push Notification](https://firebase.google.com/docs/cloud-messaging/ios/client)

</details>

## How To Use

- Initialize Firebase Manager by below method in your main.dart class inside `main()` method.

```
  await FirebaseMessagingManager.instance.init();
  
```

- To manage click of notification you have to configure Notification Callback by below.

```
await FirebaseMessagingManager.instance
        .configureCallBackForClick(NotificationCallback(onNotificationClick: _onNotificationClick));
        
        
        void _onNotificationClick({id, String? type}) {
  }
```

- Also you can get find device token by calling below method

```
    String? token = await FirebaseMessagingManager.instance.getToken();
```

---
