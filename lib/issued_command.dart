import 'event.dart';
import 'dart:io';
import 'package:keppie_home/utilities/constants.dart';

abstract class IssuedCommand extends Event {
  List<String> commandList;
  String cmd;

  @override
  void check() async {
    cmd = detect();
    if (cmd != null) {
      await respond();
    }
  }

  String detect() {
    for (String c in commandList) {
      if (kOutputFile.readAsStringSync().toLowerCase().contains('!' + c.toLowerCase() + '!')) {
        print('"$c" detected!');
        log('"$c" detected!');
        return c;
      }
    }
    return null;
  }

  void respond() async {
    markCommand();
    await takeAction();
  }

  void markCommand() {
    String updatedText = kOutputFile.readAsStringSync().replaceAll(RegExp('!$cmd!', caseSensitive: false), '🤖$cmd🤖');
    kOutputFile.writeAsStringSync(updatedText, mode: FileMode.write);
  }

  void takeAction();
}
