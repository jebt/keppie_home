import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/issued_command.dart';

import '../isolate_mixin.dart';

//String togglePlugPath = 'C:\\DATA Samsung 500GB SSD\\git\\Code\\Python\\tplink-smartplug-api-master\\toggle.py';
String plugOnPath = 'C:\\DATA Samsung 500GB SSD\\git\\Code\\Python\\tplink-smartplug-api-master\\on.py'; //todo:set

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
    log('Turning lights on...');
    await Process.run('curl', curlArgs1, runInShell: true);
    await Process.run('curl', curlArgs2, runInShell: true);
    Isolate.spawn(plugOn, pwConPort.sendPort); // ignore: unawaited_futures
  }
}

void plugOn(SendPort sendPort) {
  Process.runSync('python', [plugOnPath]);
}
