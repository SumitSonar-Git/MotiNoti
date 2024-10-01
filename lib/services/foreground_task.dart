import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:motinoti/services/notifiService.dart';

class ForegroundTaskHandler extends TaskHandler {
  NotificationService? notificationService;

  @override
  void onStart(DateTime timestamp) {
    notificationService = NotificationService();
    print('Foreground task started at: $timestamp');
    notificationService!.scheduleNotification(
      // id: 0, // Ensure unique IDs if calling multiple times
      // title: 'Lost in Phone?',
      // // body: 'Checkout this quote by...', scheduledNotificationDateTime: scheduleTime,
      //           payload: '/MotiQuotesUI',

    );
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    print('Foreground task repeated at: $timestamp');
    // Optional: add logic to show notification again
  }

  @override
  void onDestroy(DateTime timestamp) {
    print('Foreground task destroyed at: $timestamp');
  }

  @override
  void onNotificationButtonPressed(String id) {
    print('Notification button pressed: $id');
  }

  @override
  void onNotificationPressed() {
    print('Notification pressed');
  }

  @override
  void onNotificationDismissed() {
    print('Notification dismissed');
  }

}
