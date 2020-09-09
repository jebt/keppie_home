import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/high_level/issued_command.dart';

import '../isolate_mixin.dart';

String togglePlugPath = 'C:\\DATA Samsung 500GB SSD\\git\\Code\\Python\\tplink-smartplug-api-master\\toggle.py';

class TogglePlug extends IssuedCommand with IsolateMixin {
  TogglePlug() {
    commandList = [
      'plug',
      'toggleplug',
      'toggle plug',
      'smartplug',
      'smart plug',
      'togglesmartplug',
      'toggle smart plug',
    ];
  }

  @override
  void takeAction() {
    log('Toggling tplink smartplug...');
    Isolate.spawn(togglePlug, pwConPort.sendPort);
  }
}

void togglePlug(SendPort sendPort) {
  Process.runSync('python', [togglePlugPath]);
}
