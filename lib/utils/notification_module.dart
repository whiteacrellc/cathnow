//import 'dart:js';

import 'package:cathnow/pages/snooze_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:cathnow/utils/utils.dart';
import 'package:cathnow/utils/logger.dart';
import 'package:logging/logging.dart';
import 'package:cathnow/utils/values.dart';
import 'package:cathnow/utils/settings.dart';

class NotificationModule extends ChangeNotifier {
  static Logger logger = LoggerSingleton().getLogger();
  static final NotificationModule _instance = NotificationModule._internal();

  factory NotificationModule() {
    return _instance;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final ValueNotifier<bool> notificationShown = ValueNotifier<bool>(false);
  late DateTime? notificationTime;

  Future<void> checkNotification() async {}
  late BuildContext _buildContext;
  BuildContext get buildContext => _buildContext;

  Future<void> init(BuildContext context) async {
    _buildContext = context;
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    final bool? initialized = await flutterLocalNotificationsPlugin
        .initialize(initializationSettings);

    if (!initialized!) {
      // ignore: use_build_context_synchronously
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error initializing notifications'),
            content: const Text(
                'Notifications could not be initialized. Please make sure that you have granted the necessary permissions.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  NotificationModule._internal();

  NotificationDetails _setupNotificationStuff() {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        Values.channel_id_background_service,
        Values.channel_name_background_service,
        channelDescription: Values.channel_description,
        ongoing: true,
        autoCancel: false,
        showWhen: false,
        timeoutAfter: Values.serviceNotificationTimeoutDuration,
        category: AndroidNotificationCategory.alarm,
        icon: '@mipmap/ic_launcher',
        importance: Importance.max,
        visibility: NotificationVisibility.public,
        priority: Priority.high,
        playSound: true,
        colorized: true,
        color: Colors.blue,
        enableLights: true,
        ledColor: Colors.deepOrangeAccent,
        ledOnMs: Values.animationDurationDefault,
        ledOffMs: Values.animationDurationDefault,
        sound: RawResourceAndroidNotificationSound('notification'),
        enableVibration: true,
        ticker: Values.appName,
        //largeIcon: DrawableResourceAndroidBitmap('app_icon'),
        styleInformation: BigTextStyleInformation(
            '<b>This is a reminder to cath.</b>',
            htmlFormatContent: true,
            htmlFormatTitle: true,
            htmlFormatBigText: true,
            htmlFormatContentTitle: true,
            contentTitle: "<h1>Cath Now</h1>",
            summaryText: 'It is time to cath!'));
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    return NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
  }

  void _setupNotificationCallbacks() {
    flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
          ),
        ),
        onDidReceiveNotificationResponse: _foregroundResponse,
        onDidReceiveBackgroundNotificationResponse: _backgroundResponse);
  }

  Future<void> snoozeNotification(int minutes) async {
    DateTime currentTime = DateTime.now();
    DateTime snoozer = currentTime.add(Duration(minutes: minutes));
    await scheduleNotification(snoozer);
  }

  Future<void> showNotification() async {
    DateTime currentTime = DateTime.now();
    DateTime snoozer = currentTime.add(const Duration(seconds: 60));
    await scheduleNotification(snoozer);
  }

  Future<void> scheduleNotification(DateTime timeOfDay) async {
    var platformChannelSpecifics = _setupNotificationStuff();
    await deleteNotifications();

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'CathNow',
        'It is time to cath. Click to snooze.',
        convert(timeOfDay),
        platformChannelSpecifics,
        //androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'notification_payload');
    // Set up a callback to be notified when the notification is shown
    _setupNotificationCallbacks();

    // update notificationTime to display on settings page
    notificationTime = timeOfDay;
  }

  static Future<void> onNotificationClicked(String payload) async {
    if (payload == 'notification_payload') {
      Navigator.push(
        NotificationModule().buildContext,
        MaterialPageRoute(builder: (context) => const SnoozePage()),
      );
    }
  }

  static void _foregroundResponse(NotificationResponse n) {
    var aid = n.actionId;
    var id = n.id;
    var payload = n.payload;
    var input = n.input;
    var type = n.notificationResponseType;
    logger.info("foregroundResponse cb $aid, $id, $payload, $input, $type");
    if (payload == 'notification_payload') {
      Navigator.push(
        NotificationModule().buildContext,
        MaterialPageRoute(builder: (context) => const SnoozePage()),
      );
    }
  }

  static void _backgroundResponse(NotificationResponse n) {
    var aid = n.actionId;
    var id = n.id;
    var payload = n.payload;
    var input = n.input;
    var type = n.notificationResponseType;
    logger.info("foregroundResponse cb $aid, $id, $payload, $input, $type");
  }

  // Takes a TimeOfDay and if the time is greater than now it will be converted
  // into a time today, if its less then it will make it tomorrow.
  static tz.TZDateTime convert(DateTime timeOfDay) {
    tz.initializeTimeZones();
    return tz.TZDateTime.from(timeOfDay, tz.local);
  }

  Future<void> onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    var list = Settings().cathList;
    var nextTime = Utils.findNextDateTime(list);
    await deleteNotifications();
    await scheduleNotification(nextTime);
    var ts = nextTime.toLocal();
    notificationShown.notifyListeners();

    logger.info("new notification set from onDidReceiveLocalNotification $ts");
  }

  Future<void> deleteNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
