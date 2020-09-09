import 'dart:io';

import 'constants.dart';
import 'package:intl/intl.dart';

final Duration _retryDelayOnException = Duration(milliseconds: 100);
DateFormat dateFormat = DateFormat('HH:mm');

void log(String message) {
  print(message);
  String timeString = dateFormat.format(DateTime.now());
  String prefix = '$timeString 👨‍🦼keppie_home.dart:       ';
  String composedString = '$prefix$message\n';
  tryWrite(composedString);
}

void tryWrite(String message, {int failures = 0}) {
  int _fails = failures;
  try {
    kOutputFile.writeAsStringSync(message, mode: FileMode.append);
  } catch (e) {
    print(e);
    _fails++;
    if (_fails < 10) {
      sleep(_retryDelayOnException);
      tryWrite(message, failures: _fails);
    } else if (_fails >= 10) {
      throw Exception('Could not write to live file to log message.');
    }
  }
}
