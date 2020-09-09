import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/utilities/speech.dart';

import '../isolate_mixin.dart';

List<String> curlArgs1 = [
  '-L',
  '-X',
  'PUT',
  '192.168.178.210/api/p307ofvMjPAOX98VpDckmPBFGLdEcWxC8TaEsjDB/lights/1/state',
  '-H',
  'Content-Type: text/plain',
  '--data-raw',
  '{"on":false}'
];

List<String> curlArgs2 = [
  '-L',
  '-X',
  'PUT',
  '192.168.178.210/api/p307ofvMjPAOX98VpDckmPBFGLdEcWxC8TaEsjDB/lights/2/state',
  '-H',
  'Content-Type: text/plain',
  '--data-raw',
  '{"on":false}'
];

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
    await Process.run('curl', curlArgs1, runInShell: true);
    await Process.run('curl', curlArgs2, runInShell: true);
    Isolate.spawn(plugOff, pwConPort.sendPort); // ignore: unawaited_futures
  }
}

void plugOff(SendPort sendPort) {
  Process.runSync('python', [kPlugOffPath]);
}
