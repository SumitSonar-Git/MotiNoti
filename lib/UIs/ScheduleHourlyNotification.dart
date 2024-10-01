import 'package:flutter/material.dart';
import 'package:motinoti/services/notifiService.dart';
import 'package:motinoti/services/sharedprefclass.dart';

class ScheduleHourlyNotification extends StatefulWidget {
  const ScheduleHourlyNotification({Key? key}) : super(key: key);

  @override
  _ScheduleHourlyNotification createState() => _ScheduleHourlyNotification();
}

class _ScheduleHourlyNotification extends State<ScheduleHourlyNotification> {
  final SharedPrefClass _sharedPrefService = SharedPrefClass();
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  void _loadSwitchState() async {
    bool savedState = await _sharedPrefService.getHourlyNotification();
    setState(() {
      isSwitched = savedState;
    });
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
      _sharedPrefService.setHourlyNotification(value);

      final notificationService = NotificationService(); // Single instance

      if (isSwitched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hourly notifications enabled'),
            duration: Duration(seconds: 2),
          ),
        );
        notificationService.scheduleNotification();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hourly notifications disabled'),
            duration: Duration(seconds: 2),
          ),
        );
        notificationService.cancelNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: toggleSwitch,
      activeColor: Colors.grey,
      inactiveTrackColor: Colors.white,
    );
  }
}
