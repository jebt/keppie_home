import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/utilities/constants.dart';

import 'package:keppie_home/high_level/issued_command.dart';

import 'package:keppie_home/high_level/isolate_mixin.dart';

String togglePlugPath = 'C:\\DATA Samsung 500GB SSD\\git\\Code\\Python\\tplink-smartplug-api-master\\toggle.py';

class TestEvent extends IssuedCommand with IsolateMixin {
  TestEvent() {
    commandList = ['test', 'keppie'];
  }

  @override
  void takeAction() {
    log('test event triggered!');
    print('test event triggered!');
    //Isolate.spawn(togglePlug, pwConPort.sendPort);
  }
}

void showerThought(SendPort sendPort) {
  Process.runSync(kArgLibPath, ['ShowerThoughtTop']);
}

void togglePlug(SendPort sendPort) {
  Process.runSync('python', [togglePlugPath]);
}
