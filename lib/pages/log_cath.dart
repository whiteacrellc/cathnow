import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:cathnow/widgets/description_widget.dart';
import 'package:cathnow/widgets/custom_dropdown.dart';
import 'package:cathnow/widgets/custom_button.dart';
import 'package:cathnow/widgets/my_text.dart';
import 'package:cathnow/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:cathnow/utils/notification_module.dart';
import 'package:cathnow/widgets/navigation_bar.dart';
import 'package:cathnow/widgets/my_appbar.dart';
import 'package:cathnow/utils/settings.dart';
import 'dart:io';

class LogCathWidget extends StatefulWidget {
  const LogCathWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LogCathWidgetState createState() => _LogCathWidgetState();
}

class _LogCathWidgetState extends State<LogCathWidget> {
  late String _logCath;
  late DateTime nextTime;
  late String nextTimeString;
  late int customHours = 4;
  late String diffString;

  //late ApplicationState appState;

  @override
  void initState() {
    super.initState();
    _getLogCath();
    Timer.periodic(const Duration(seconds: 60), (Timer t) => _getLogCath());
    NotificationModule().deleteNotifications();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getLogCath() {
    if (mounted) {
      setState(() {
        _logCath =
            "Current Time ${DateFormat('h:mm a').format(DateTime.now())}";
      });
    }
  }

  void _onChanged(int? newValue) {
    setState(() {
      customHours = newValue!;
      _LogCathWidgetState().build(context);
    });
  }

  Future<void> setNotification(DateTime dt) async {
    await NotificationModule().deleteNotifications();
    await NotificationModule().scheduleNotification(dt);
  }

  // ignore: no_leading_underscores_for_local_identifiers
  String _makeDescriptionString(List<TimeOfDay> times) {
    nextTime = Utils.findNextDateTime(times);
    setNotification(nextTime);
    nextTimeString = Utils.convertDateTimeToString(nextTime);
    diffString = Utils.computeDurations(times);
    return "Your next reminder is set for $nextTimeString which is $diffString from now";
  }

  @override
  Widget build(BuildContext context) {
    final MyDropdownList dropdownList =
        MyDropdownList(setStateCallback: _onChanged);
    NavBar().page = NavigationPage.home;
    return Consumer<Settings>(
        builder: (context, appState, _) => Scaffold(
            appBar: const MyAppBar(title: "Cath Now - Schedule"),
            bottomNavigationBar: NavBar(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DescriptionWidget(text: _logCath),
                  Card(
                      borderOnForeground: true,
                      child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                DescriptionWidget(
                                    text: _makeDescriptionString(
                                        appState.cathList)),
                                const SizedBox(
                                  height: 20,
                                ),
                                const DescriptionWidget(
                                    borderRadius: 0,
                                    text:
                                        'If you would like override the current reminder and set a custom alert hoose the number of hours and press the schedule'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      dropdownList,
                                      CustomButton(
                                          buttonText:
                                              "Cath $customHours hours from now.",
                                          onPressed: () {
                                            var now = DateTime.now();
                                            var cathTime = DateTime(
                                                now.year,
                                                now.month,
                                                now.day,
                                                now.hour +
                                                    dropdownList.selectedValue,
                                                now.minute);
                                            setNotification(cathTime);
                                          })
                                    ]),
                                const DescriptionWidget(
                                    borderRadius: 0,
                                    text:
                                        'If you would like to leave the schedule unchanged, click the exit button.'),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    exit(0);
                                  },
                                  child: MyText(text: 'Exit'),
                                ),
                              ]))),
                  const SizedBox(
                    height: 20,
                  ),
                ])));
  }
}
