import 'package:flutter/material.dart';
import 'package:cathnow/widgets/my_appbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:cathnow/utils/notification_module.dart';
import 'package:intl/intl.dart';
import 'package:cathnow/utils/settings.dart';
import 'package:provider/provider.dart';
import 'package:cathnow/widgets/my_text.dart';
import 'package:cathnow/widgets/description_widget.dart';
import 'package:cathnow/widgets/custom_button.dart';
import 'package:cathnow/utils/logger.dart';
import 'package:cathnow/widgets/navigation_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkModeEnabled = false;
  PermissionStatus _notificationStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  void toggleMode(bool val) {
    _darkModeEnabled = val;
    setState(() {});
  }

  void _showPermissionDialog() {
    AlertDialog(
      title: MyText(text: 'Notification Permission'),
      content: MyText(
          text: 'You must give Cath Now notification access to work. '
              'Please goto application settings and enable notifications'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            openAppSettings();
          },
          child: MyText(text: 'Application Settings'),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: MyText(text: 'Exit'),
        ),
      ],
    );
  }

  Future<void> _checkPermissions() async {
    if (await Permission.notification.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      _showPermissionDialog();
    }
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
    ].request();

    setState(() {
      _notificationStatus = statuses[Permission.notification]!;
    });

    if (_notificationStatus == PermissionStatus.permanentlyDenied) {
      _showPermissionDialog();
    }
  }

  void _showNotification() {
    var logger = LoggerSingleton().getLogger();
    NotificationModule().showNotification().then((value) {
      logger.info("yay");
    }).onError((error, stackTrace) {
      logger.warning("error popping notification $error $stackTrace");
    });
  }

  String _getPermissionStatusText(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Granted';
      case PermissionStatus.denied:
        return 'Denied';
      case PermissionStatus.restricted:
        return 'Restricted';
      case PermissionStatus.permanentlyDenied:
        return 'Permanently Denied';
      default:
        return 'Unknown';
    }
  }

  String _getNextNotification() {
    String ret = '';
    if (NotificationModule().notificationTime == null) {
      ret = "No notfications are set";
    } else {
      var d = DateFormat('MMM d HH:mm')
          .format(NotificationModule().notificationTime!);
      ret = 'The next notification is at $d';
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    NavBar().page = NavigationPage.settings;

    var notificationText =
        'Notification permission: ${_getPermissionStatusText(_notificationStatus)}';
    return Consumer<Settings>(
      builder: (context, appState, _) => Scaffold(
          appBar: const MyAppBar(title: "Settings"),
          bottomNavigationBar: NavBar(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: <Widget>[
                    MyText(
                        text:
                            'Dark Mode is ${appState.darkMode ? 'on' : 'off'}'),
                    const Spacer(),
                    DarkModeSwitch(
                      onChanged: toggleMode,
                    ),
                  ],
                ),
                MyText(text: notificationText),
                ValueListenableBuilder<bool>(
                    valueListenable: NotificationModule().notificationShown,
                    builder: (context, value, _) {
                      return DescriptionWidget(text: _getNextNotification());
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    buttonText: "Show Notification",
                    onPressed: _showNotification)
              ],
            )),
          )),
    );
  }
}

class DarkModeSwitch extends StatelessWidget {
  //final String text;
  final Settings settings = Settings();
  final void Function(bool)? onChanged;
  DarkModeSwitch({Key? key, required this.onChanged}) : super(key: key);

  void update(bool val) {
    settings.darkMode = val;
    onChanged!(val);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, _) {
        return Switch(
          value: settings.darkMode,
          onChanged: update,
        );
      },
    );
  }
}
