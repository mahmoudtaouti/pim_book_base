import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {


  _init() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    final androidImplementation =  flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    bool? isNotificationAlowed = await androidImplementation?.requestNotificationsPermission();


    final androidDetails = AndroidNotificationDetails(
        '...','...',channelDescription: '...',icon: '@mipmap/ic_launcher_trp');

    flutterLocalNotificationsPlugin.show(0, 'title', 'body',NotificationDetails(android: androidDetails) );
  }

}


class NotificationData{

  int id;
  String name;
  String description;

  NotificationData(this.id, this.name, this.description);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationData &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}