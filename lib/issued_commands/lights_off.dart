import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/issued_command.dart';

import '../isolate_mixin.dart';

//String togglePlugPath = 'C:\\DATA Samsung 500GB SSD\\git\\Code\\Python\\tplink-smartplug-api-master\\toggle.py';
String plugOffPath = 'C:\\DATA Samsung 500GB SSD\\git\\Code\\Python\\tplink-smartplug-api-master\\off.py'; //todo:set

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
    log('Turning lights off...');
    await Process.run('curl', curlArgs1, runInShell: true);
    await Process.run('curl', curlArgs2, runInShell: true);
    Isolate.spawn(plugOff, pwConPort.sendPort); // ignore: unawaited_futures
  }
}

void plugOff(SendPort sendPort) {
  Process.runSync('python', [plugOffPath]);
}
