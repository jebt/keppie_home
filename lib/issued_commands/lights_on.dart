//todo: refactor to use fancy hue

import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/issued_command.dart';
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
  '{"on":true}'
];

List<String> curlArgs2 = [
  '-L',
  '-X',
  'PUT',
  '192.168.178.210/api/p307ofvMjPAOX98VpDckmPBFGLdEcWxC8TaEsjDB/lights/2/state',
  '-H',
  'Content-Type: text/plain',
  '--data-raw',
  '{"on":true}'
];

class LightsOn extends IssuedCommand with IsolateMixin {
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
    await Process.run('curl', curlArgs1, runInShell: true);
    await Process.run('curl', curlArgs2, runInShell: true);
    Isolate.spawn(plugOn, pwConPort.sendPort); // ignore: unawaited_futures
  }
}

void plugOn(SendPort sendPort) {
  Process.runSync('python', [kPlugOnPath]);
}
