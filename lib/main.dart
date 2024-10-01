import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:motinoti/UIs/MotiQuotesUI.dart';
import 'package:motinoti/UIs/MyHomePage.dart';
import 'package:motinoti/services/foreground_task.dart';
import 'package:motinoti/services/notifiService.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  final NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  // Get the initial notification action, if the app was launched via a notification
  ReceivedAction? initialAction =
      await AwesomeNotifications().getInitialNotificationAction();

  runApp(MyApp(
      notificationService: notificationService, initialAction: initialAction));
}

class MyApp extends StatefulWidget {
  final NotificationService notificationService;
  final ReceivedAction? initialAction;

  const MyApp({Key? key, required this.notificationService, this.initialAction})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    ForegroundTaskHandler();

    // Listen for notification actions when the app is in the foreground or background
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) async {
        if (receivedAction.payload?['navigate'] == 'MotiQuotesUI') {
          navigatorKey.currentState?.pushNamed('/MotiQuotesUI');
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        iconButtonTheme: IconButtonThemeData(),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Check if the app was launched by a notification click
        if (widget.initialAction?.payload?['navigate'] == 'MotiQuotesUI') {
          return MaterialPageRoute(builder: (_) => MotiQuotesUI());
        }
        // Default route
        return MaterialPageRoute(
            builder: (_) =>
                MyHomePage(notificationService: widget.notificationService));
      },
      routes: {
        '/': (context) =>
            MyHomePage(notificationService: widget.notificationService),
        '/MotiQuotesUI': (context) => MotiQuotesUI(),
      },
    );
  }
}
