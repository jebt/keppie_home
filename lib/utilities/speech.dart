import 'dart:cli';
import 'dart:io';

import 'constants.dart';

void say(String text) {
  waitFor<void>(_sayInternal(text));
}

Future<void> _sayInternal(String text) async {
  Process.run(kArgLibPath, ['Say', text]);
}
