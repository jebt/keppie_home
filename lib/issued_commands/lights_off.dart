import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/utilities/fancy_hue.dart';
import 'package:keppie_home/utilities/speech.dart';
import 'package:pedantic/pedantic.dart';

import '../high_level/isolate_mixin.dart';

class LightsOff extends IssuedCommand with IsolateMixin {
  LightsOff() {
    commandList = [
      'off',
      'lightsoff',
      'lights off',
      'light off',
      'lightoff',
    ];
  }

  @override
  void takeAction() async {
    say('Turning lights off...');
    Isolate.spawn(plugOff, pwConPort.sendPort); // ignore: unawaited_futures
    FancyHue fancyHue = FancyHue();
    await fancyHue.turnDownstairsLightsOff();
  }
}

void plugOff(SendPort sendPort) {
  Process.runSync('python', [kPlugOffPath]);
}
