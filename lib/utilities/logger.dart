import 'dart:io';

import 'constants.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat('HH:mm');

void log(String message) {
  String timeString = dateFormat.format(DateTime.now());
  String prefix = '$timeString 👸🏼keppie_home.dart:       ';
  kOutputFile.writeAsStringSync('$prefix$message\n', mode: FileMode.append);
}
