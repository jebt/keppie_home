import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/fancy_hue.dart';
import 'package:keppie_home/issued_command.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/utilities/speech.dart';

import '../isolate_mixin.dart';

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

class ToggleLights extends IssuedCommand with IsolateMixin {
  ToggleLights() {
    commandList = [
      'toggle lights',
    ];
  }

  @override
  void takeAction() async {
    FancyHue fancyHue = FancyHue();
    bool isOn = await fancyHue.isOn();
    if (isOn) {
      say('Turning lights off...');
      Isolate.spawn(plugOff, pwConPort.sendPort);
    } else {
      say('Turning lights on...');
      Isolate.spawn(plugOn, pwConPort.sendPort);
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