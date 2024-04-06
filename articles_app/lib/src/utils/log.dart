import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart' as logging;

class Log {
  // https://github.com/dart-lang/logging
  static final _logger = logging.Logger('MyLogger');

  static void info(String message) {
    _logger.info(message);
    if (kDebugMode) {
      print(message);
    }
  }
}
