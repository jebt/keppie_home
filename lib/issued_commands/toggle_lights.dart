import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:pedantic/pedantic.dart';

import 'package:keppie_home/utilities/fancy_hue.dart';
import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/utilities/speech.dart';

import '../high_level/isolate_mixin.dart';

//List<String> curlArgs1 = [
//  '-L',
//  '-X',
//  'PUT',
//  '192.168.178.210/api/p307ofvMjPAOX98VpDckmPBFGLdEcWxC8TaEsjDB/lights/1/state',
//  '-H',
//  'Content-Type: text/plain',
//  '--data-raw',
//  '{"on":false}'
//];
//
//List<String> curlArgs2 = [
//  '-L',
//  '-X',
//  'PUT',
//  '192.168.178.210/api/p307ofvMjPAOX98VpDckmPBFGLdEcWxC8TaEsjDB/lights/2/state',
//  '-H',
//  'Content-Type: text/plain',
//  '--data-raw',
//  '{"on":false}'
//];

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
