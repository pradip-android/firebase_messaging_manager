typedef OnNotificationClick = void Function({Map<String, dynamic> data});

class NotificationCallback {
  OnNotificationClick? onNotificationClick;

  NotificationCallback({this.onNotificationClick});
}
