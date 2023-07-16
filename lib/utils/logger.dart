import 'package:logging/logging.dart';

class LoggerSingleton {
  static final LoggerSingleton _instance = LoggerSingleton._internal();

  factory LoggerSingleton() {
    return _instance;
  }

  LoggerSingleton._internal() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  Logger getLogger() {
    return Logger('cathnow');
  }
}
