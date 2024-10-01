import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {

  AwesomeNotifications awesomeNotifications = AwesomeNotifications();


  Future<void> initialize() async {
    requestPermission();
    await awesomeNotifications.initialize(
      'resource://drawable/applogo',
      [
        NotificationChannel(
            channelKey: 'Key1',
            channelName: 'Notification channel',
            channelDescription: 'Notification channel',
            defaultColor: Color(0xFF9B9B9B),
            importance: NotificationImportance.Max,
            playSound: true)
      ],
      debug: false,
    );
    
  }

  Future<void> requestPermission() async {
    await awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        awesomeNotifications.requestPermissionToSendNotifications();
      }
    });
  }

  Future<void> scheduleNotification() async {
    print("Scheduling notification...");
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'Key1',
        title: 'Lost in phone?',
        body: 'need motivation? checkout this quote',
        notificationLayout: NotificationLayout.Default,
        payload: {'navigate': 'MotiQuotesUI'},
      ),
      schedule: NotificationInterval(
        interval: 3600, // Time interval in seconds (60 seconds = 1 minute)
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
        repeats: true,
        allowWhileIdle: true,
      ),
    );
    print("Notification scheduled.");
  }

  Future<void> cancelNotifications() async {
    await awesomeNotifications.cancel(1);
  }

  void onNotificationclicked(ReceivedNotification receivedNotification){
    if(receivedNotification.payload !=null && receivedNotification.payload!['navigate']=='MotiQuotesUI'){
    // awesomeNotifications.pushNamed('/MotiQuotesUI');
         }
  }
}
