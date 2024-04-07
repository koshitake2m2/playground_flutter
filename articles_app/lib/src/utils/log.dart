import 'package:logging/logging.dart' as logging;

class Log {
  // https://github.com/dart-lang/logging
  static final _logger = _initLogger();

  static logging.Logger _initLogger() {
    final logger = logging.Logger('MyLogger');
    logging.Logger.root.level = logging.Level.ALL;
    logging.Logger.root.onRecord.listen((logging.LogRecord rec) {
      // ignore: avoid_print
      print('[${rec.level.name}]: ${rec.time}: ${rec.message}');
    });
    return logger;
  }

  static void info(String message) {
    _logger.info(message);
  }
}
