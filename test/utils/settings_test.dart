import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cathnow/utils/settings.dart';

void main() {
  group('Settings', () {
    late SharedPreferences sharedPreferences;
    late Settings settings;

    setUp(() async {
      final Map<String, Object> values = <String, Object>{'darkMode': true};
      SharedPreferences.setMockInitialValues(values);
      sharedPreferences = await SharedPreferences.getInstance();
      // Create a new Settings instance
      settings = Settings();
      await settings.loadSettingsFromLocal();
    });

    test('darkMode should true because we set it', () {
      expect(settings.darkMode, true);
    });

    test('darkMode should update and persist to local storage', () async {
      // Update darkMode
      settings.darkMode = false;
      settings.updateSettingsToLocal("darkMode", false);

      // Verify the updated value in the class
      expect(settings.darkMode, false);

      // Verify the persisted value in local storage
      final storedValue = sharedPreferences.getBool('darkMode');
      expect(storedValue, false);
    });

    test('should convert TimeOfDay list to String list', () {
      final timeList = [
        const TimeOfDay(hour: 9, minute: 0),
        const TimeOfDay(hour: 12, minute: 30),
        const TimeOfDay(hour: 17, minute: 45),
      ];

      final result = settings.convertTimeOfDayListToStringList(timeList);

      expect(result, ['9:00 AM', '12:30 PM', '5:45 PM']);
    });

    test('should convert String list to TimeOfDay list', () {
      final stringList = ['9:00 AM', '12:30 PM', '5:45 PM'];

      final result = settings.convertStringListToTimeOfDayList(stringList);

      expect(result, [
        const TimeOfDay(hour: 9, minute: 0),
        const TimeOfDay(hour: 12, minute: 30),
        const TimeOfDay(hour: 17, minute: 45),
      ]);
    });
  });
}
