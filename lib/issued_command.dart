import 'event.dart';
import 'dart:io';
import 'package:keppie_home/utilities/constants.dart';

abstract class IssuedCommand implements Event {
  List<String> commandList;
  String cmd;

  @override
  void check() {
    cmd = detect();
    if (cmd != null) {
      respond();
    }
  }

  String detect() {
    for (String c in commandList) {
      if (outputFile.readAsStringSync().toLowerCase().contains('!' + c.toLowerCase() + '!')) {
        return c;
      }
    }
    return null;
  }

  void respond() {
    markCommand();
    takeAction();
  }

  void markCommand() {
    String updatedText = outputFile.readAsStringSync().replaceAll(RegExp('!$cmd!', caseSensitive: false), '🤖$cmd🤖');
    outputFile.writeAsStringSync(updatedText, mode: FileMode.write);
  }

  void takeAction();
}
