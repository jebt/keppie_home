import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:pedantic/pedantic.dart';

import 'package:keppie_home/utilities/fancy_hue.dart';
import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/utilities/speech.dart';

import '../high_level/isolate_mixin.dart';

class ToggleLights extends IssuedCommand with IsolateMixin, ShortcutsMixin {
  ToggleLights() {
    commandList = [
      'toggle lights',
      'lights',
      'light',
    ];
  }

  @override
  void takeAction() async {
    FancyHue fancyHue = FancyHue();
    bool isOn = await fancyHue.isOn();
    if (isOn) {
      say('Turning lights off...');
      unawaited(Isolate.spawn(plugOff, pwConPort.sendPort));
    } else {
      say('Turning lights on...');
      unawaited(Isolate.spawn(plugOn, pwConPort.sendPort));
    }
    await fancyHue.toggleLights();
  }
}

void plugOff(SendPort sendPort) {
  Process.runSync('python', [kPlugOffPath]);
}

void plugOn(SendPort sendPort) {
  Process.runSync('python', [kPlugOnPath]);
}
