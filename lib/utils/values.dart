/// Constants that cannot be localized
/// taken as a convention from Android
// ignore_for_file: constant_identifier_names

class Values {
  static const appId = 'org.tomw.cathnow';
  static const appName = 'CathNow';
  static const appLabel = 'cathnow';
  static const appNameLong = 'Cath Now';
  static const appDisplayName = 'CathNow';

  static const empty = '';
  static const channel_id = '${appLabel}_notifications_v2';
  static const channel_id_background_service =
      '${appName}_background_notification_v2';
  static const default_channel_title = appName;

  static const channel_group_key = 'org.tomw.cathnow.MESSAGES';
  static const channel_name_messages = 'Messages';
  static const channel_name_background_service = 'cath now service';
  static const channel_description =
      '$appName messaging client message and status notifications';

  // Animations
  static const animationDurationDefault = 350; // millis
  static const animationDurationDefaultFast = 275;
  static const serviceNotificationTimeoutDuration = 75000; // millis
}
