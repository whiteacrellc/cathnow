import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:cathnow/utils/logger.dart';

class Settings with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Logger logger = LoggerSingleton().getLogger();

  static bool _darkMode = false;
  bool get darkMode => _darkMode;
  set darkMode(bool value) {
    _darkMode = value;
    updateSettingsToLocal("darkMode", value);
    notifyListeners();
  }

  // ignore: prefer_final_fields
  static List<TimeOfDay> _cathList = [];
  List<TimeOfDay> get cathList => _cathList;

  bool haveList() {
    return _cathList.isNotEmpty;
  }

  addListEntry(TimeOfDay td) {
    _cathList.add(td);
    _cathList.sort(
        (a, b) => a.hour == b.hour ? a.minute - b.minute : a.hour - b.hour);
    _updateCathList();
  }

  _updateCathList() async {
    List<String> sl = convertTimeOfDayListToStringList(_cathList);
    logger.info('writing $sl');

    SharedPreferences prefs = await _prefs;
    prefs.setStringList("cathList", sl);
  }

  static double _textSize = 18;
  double get textSize => _textSize;
  set textSize(double value) {
    _textSize = value;
    updateSettingsToLocal("textSize", value);
    notifyListeners();
  }

  loadSettingsFromLocal() async {
    SharedPreferences prefs = await _prefs;
    _darkMode = prefs.getBool("darkMode") ?? false;
    logger.info('loaded _darkMode as $_darkMode');

    await prefs.setDouble('testSize', 18);

    _textSize = prefs.getDouble("textSize") ?? 18;

    List<String> stringList = prefs.getStringList("cathList") ?? [];
    logger.info('loaded string list $stringList');

    if (stringList.isNotEmpty) {
      _cathList = convertStringListToTimeOfDayList(stringList);
      logger.info('_cathList elemnts');
      for (var item in _cathList) {
        logger.info(item);
      }
    }
    notifyListeners();
  }

  void updateSettingsToLocal<T>(String setting, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (T == bool) {
      await prefs.setBool(setting, value as bool);
    } else if (T == int) {
      await prefs.setInt(setting, value as int);
    } else if (T == double) {
      await prefs.setDouble(setting, value as double);
    }
  }

  List<String> convertTimeOfDayListToStringList(List<TimeOfDay> timeList) {
    return timeList.map((timeOfDay) {
      final hour = timeOfDay.hourOfPeriod;
      final minute = timeOfDay.minute;
      final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

      final formattedHour = hour.toString(); //.padLeft(2, '0');
      final formattedMinute = minute.toString().padLeft(2, '0');

      return '$formattedHour:$formattedMinute $period';
    }).toList();
  }

  List<TimeOfDay> convertStringListToTimeOfDayList(List<String> stringList) {
    return stringList.map((timeString) {
      final parts = timeString.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1].substring(0, 2));
      final period = parts[1].substring(3);

      int hourIn24Format;
      if (period.toUpperCase() == 'PM') {
        hourIn24Format = hour == 12 ? 12 : hour + 12;
      } else {
        hourIn24Format = hour == 12 ? 0 : hour;
      }

      return TimeOfDay(hour: hourIn24Format, minute: minute);
    }).toList();
  }

  void reomoveListEntry(int i) {
    TimeOfDay t = _cathList[i];
    if (_cathList.contains(t)) {
      _cathList.remove(t);
      _cathList.sort(
          (a, b) => a.hour == b.hour ? a.minute - b.minute : a.hour - b.hour);
      _updateCathList();
    }
  }
}
