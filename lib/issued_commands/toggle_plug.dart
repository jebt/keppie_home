import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/high_level/issued_command.dart';

import 'package:keppie_home/high_level/isolate_mixin.dart';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:keppie_home/utilities/speech.dart';

String togglePlugPath = 'C:\\DATA Samsung 500GB SSD\\git\\Code\\Python\\tplink-smartplug-api-master\\toggle.py';

class TogglePlug extends IssuedCommand with IsolateMixin, ShortcutsMixin {
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
    say('Toggling tplink smartplug...');
    Isolate.spawn(togglePlug, pwConPort.sendPort);
  }
}

void togglePlug(SendPort sendPort) {
  Process.runSync('python', [togglePlugPath]);
}
