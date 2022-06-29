# Firebase Messaging Manager
---

## Table Of Contents

* [Installation](#Installation)
* [Setup](#Setup)
* [How To Use](#how-to-use)

## Installation
---
- Add Below dependency in your `pubspec.yaml` file.

```
firebase_messaging_manager:
    git:
      url: https://github.com/hemang-concetto/firebase_messaging_manager.git
      ref: main
```

## Setup
---
<details>
<summary>Android</summary>
<br>

- Add `google-services.json` to your `android/app` folder which is connected with your package name.
- Add 'app_icon.png' to your `android/app/src/main/drawable` folder.

</details>

<details>
<summary>IOS</summary>
<br>

- Add `GoogleService-Info.plist` to your `ios/Runner` folder which is connected with your bundle id.
- Also setup your iOS account as per below.
[Configure IOS for Push Notification](https://firebase.google.com/docs/cloud-messaging/ios/client)

</details>

## How To Use
---
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
