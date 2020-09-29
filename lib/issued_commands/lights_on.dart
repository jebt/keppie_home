//todo: refactor to use fancy hue

import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/utilities/fancy_hue.dart';
import 'package:keppie_home/utilities/speech.dart';
import 'package:pedantic/pedantic.dart';

import '../high_level/isolate_mixin.dart';

class LightsOn extends IssuedCommand with IsolateMixin, ShortcutsMixin {
  LightsOn() {
    commandList = [
      'on',
      'lightson',
      'lights on',
      'light on',
      'lighton',
    ];
  }

  @override
  void takeAction() async {
    say('Turning lights on...');
    Isolate.spawn(plugOn, pwConPort.sendPort); // ignore: unawaited_futures
    FancyHue fancyHue = FancyHue();
    await fancyHue.turnDownstairsLightsOn();
  }
}

void plugOn(SendPort sendPort) {
  Process.runSync('python', [kPlugOnPath]);
}
