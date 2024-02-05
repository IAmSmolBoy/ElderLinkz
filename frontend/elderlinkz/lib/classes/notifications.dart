import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {

    await notificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
    
    const initializationSettingsAndroid = AndroidInitializationSettings('elderlinkz_icon');
    
    // final initializationSettingsDarwin = DarwinInitializationSettings(
    //   onDidReceiveLocalNotification: (id, title, body, payload) {

    //     debugPrint("onDidReceiveLocalNotification: id: $id, title: $title, body: $body, payload: $payload");
        
    //   },
    // );
    // const initializationSettingsLinux = LinuxInitializationSettings(
    //   defaultActionName: 'Open notification'
    // );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsDarwin,
      // macOS: initializationSettingsDarwin,
      // linux: initializationSettingsLinux
    );
    
    await notificationsPlugin
      .initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          
          debugPrint(
'''onDidReceiveNotificationResponse {
  id: ${details.id}
  actionId: ${details.actionId}
  input: ${details.input}
  payload: ${details.payload}
  notificationResponseType: ${details.notificationResponseType}
}'''
          );

        },
      );
      

  }

  // static void myBackgroundMessageHandler(NotificationResponse message) {

  //     debugPrint(message.payload);

  // }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload
  }) async {
    
    const androidNotificationDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: false,
      enableVibration: false,
      // silent: true,
      // channelDescription: 'channelDescription',
      // importance: Importance.max,
      // priority: Priority.high,
      // ticker: 'ticker'
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );

    await notificationsPlugin
      .show(
        0,
        title,
        body,
        notificationDetails,
        payload: payload
      );

  }
  
    // await notificationsPlugin
    //   .show(
    //     id,
    //     title,
    //     body,
    //     const NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         "channelId",
    //         "channelName",
    //         importance: Importance.max
    //       )
    //     )
    //   );

}