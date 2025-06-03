import 'package:logger/logger.dart';

final logger = Logger(
  printer: SimplePrinter(printTime: true),
  // printer: PrettyPrinter(
  //   methodCount: 0,
  //   errorMethodCount: 8,
  //   lineLength: 120,
  //   colors: true,
  //   printEmojis: true,
  //   dateTimeFormat: DateTimeFormat.dateAndTime,
  // ),
);
