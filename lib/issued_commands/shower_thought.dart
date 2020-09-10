import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/high_level/isolate_mixin.dart';

class ShowerThought1 extends IssuedCommand with IsolateMixin, ShortcutsMixin {
  ShowerThought1() {
    commandList = [
      'shower thought',
      'st1',
      'showerthought',
      'stt',
      'stt1',
      'st',
      'shower thought',
      'shower thoughts',
    ];
  }

  @override
  void takeAction() {
    Isolate.spawn(st1, pwConPort.sendPort);
  }
}

//class ShowerThoughtRandomTop10 extends IssuedCommand with IsolateMixin {
//  ShowerThoughtRandomTop10() {
//    commandList = [
//      'st10',
//      'str',
//      'str10',
//      'strt10',
//      'shower thought 10',
//      'showerthought10',
//      'showerthoughtrandom',
//      'shower thought random',
//      'showerthought random',
//    ];
//  }
//
//  @override
//  void takeAction() {
//    Isolate.spawn(strt10, pwConPort.sendPort);
//  }
//}

void st1(SendPort sendPort) {
  Process.runSync(
    kArgLibPath,
    ['ShowerThoughtTop'],
  );
}

//void strt10(SendPort sendPort) {
//  Process.runSync(
//    kArgLibPath,
//    [Nog aan te maken random showerthought in arglib],
//  );
//}
