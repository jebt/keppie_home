import 'dart:cli';
import 'dart:io';

import 'package:keppie_home/utilities/logger.dart';

import 'constants.dart';

void say(String text) {
  log(text);
  waitFor<void>(_sayInternal(text));
}

Future<void> _sayInternal(String text) async {
  Process.run(kArgLibPath, ['Say', text]);
}
