import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum AppMenu {
  about,
  privacy,
  settings,
}

class Utils {
  static List<DateTime> dateTimeConvert(List<TimeOfDay> timeOfDay,
      [DateTime? now]) {
    now ??= DateTime.now();

    List<DateTime> convertedTimes = timeOfDay.map((time) {
      return DateTime(now!.year, now.month, now.day, time.hour, time.minute);
    }).toList();
    return convertedTimes;
  }

  static List<TimeOfDay> timeOfDayConvert(List<DateTime> dateTimes) {
    return dateTimes
        .map((dateTime) => TimeOfDay.fromDateTime(dateTime))
        .toList();
  }

  static String convertTimeOfDayToString(TimeOfDay time) {
    return DateFormat('h:mm a')
        .format(DateTime(2022, 04, 09, time.hour, time.minute));
  }

  static String convertDateTimeToString(DateTime time) {
    return DateFormat('h:mm a')
        .format(DateTime(2022, 04, 09, time.hour, time.minute));
  }

  static TimeOfDay findNextTimeOfDay(List<TimeOfDay> times, [TimeOfDay? now]) {
    now ??= TimeOfDay.now();
    TimeOfDay? closest;

    for (final time in times) {
      if (time.hour < now.hour ||
          (time.hour == now.hour && time.minute <= now.minute)) {
        continue; // skip times that are earlier than or equal to the current time
      }

      if (closest == null ||
          time.hour < closest.hour ||
          (time.hour == closest.hour && time.minute < closest.minute)) {
        closest = time; // update closest time if it's the closest so far
      }
    }
    closest ??= times[0];
    return closest;
  }

  static DateTime findNextDateTime(List<TimeOfDay> times, [DateTime? now]) {
    now ??= DateTime.now();
    TimeOfDay? closest;
    DateTime returnDateTime = DateTime.now();

    var lastTime = times.last;

    if (now.hour > lastTime.hour ||
        (now.hour == lastTime.hour && now.minute > lastTime.minute)) {
      returnDateTime = DateTime(
          now.year, now.month, now.day + 1, times[0].hour, times[0].minute);
    } else {
      for (final time in times) {
        closest = time;
        var timediff =
            ((closest.hour - now.hour) * 60) + (closest.minute - now.minute);

        if (timediff > 0) {
          closest = time;
          break;
        }
      }
      returnDateTime =
          DateTime(now.year, now.month, now.day, closest!.hour, closest.minute);
    }
    return returnDateTime;
  }

  static String printHoursAndMinutesBetween(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    var h = hours == 1 ? "hour" : "hours";
    var m = minutes == 1 ? "minute" : "minutes";
    return ' $hours $h and $minutes $m';
  }

  static String computeDurations(List<TimeOfDay> times, [DateTime? now]) {
    now ??= DateTime.now();

    var nextDateTime = findNextDateTime(times, now);
    return printHoursAndMinutesBetween(now, nextDateTime);
  }

  static ButtonStyle enabledFilledButtonStyle(
      bool selected, ColorScheme colors) {
    return IconButton.styleFrom(
      foregroundColor: selected ? colors.onPrimary : colors.primary,
      backgroundColor: selected ? colors.primary : colors.surfaceVariant,
      disabledForegroundColor: colors.onSurface.withOpacity(0.38),
      disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
      hoverColor: selected
          ? colors.onPrimary.withOpacity(0.08)
          : colors.primary.withOpacity(0.08),
      focusColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
      highlightColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
    );
  }

  static AppBar getAppBar(context, title) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {},
          style: enabledFilledButtonStyle(true, Theme.of(context).colorScheme),
          icon: const Icon(Icons.sort_rounded),
        ),
        PopupMenuButton<AppMenu>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<AppMenu>>[
                  const PopupMenuItem<AppMenu>(
                    value: AppMenu.about,
                    child: Text('About us'),
                  ),
                  const PopupMenuItem<AppMenu>(
                    value: AppMenu.privacy,
                    child: Text('Privacy Policy'),
                  ),
                  const PopupMenuItem<AppMenu>(
                    value: AppMenu.settings,
                    child: Text('Settings'),
                  ),
                ],
            onSelected: (AppMenu result) {
              switch (result) {
                case AppMenu.about:
                  Navigator.of(context).pushNamed('/about');
                  break;
                case AppMenu.privacy:
                  Navigator.of(context).pushNamed('/privacy');
                  break;
                case AppMenu.settings:
                  Navigator.of(context).pushNamed('/home');
                  break;
              }
            })
      ],
      scrolledUnderElevation: 4.0,
      shadowColor: Theme.of(context).shadowColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: const Center(
        child: CircleAvatar(
          radius: 16,
          child: Icon(Icons.person),
        ),
      ),
    );
  }
}
