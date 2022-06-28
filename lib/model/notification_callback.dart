typedef OnNotificationClick = void Function({String? type, dynamic id});

class NotificationCallback {
  OnNotificationClick? onNotificationClick;

  NotificationCallback({this.onNotificationClick});
}
