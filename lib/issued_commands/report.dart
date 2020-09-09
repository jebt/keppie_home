import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/utilities/speech.dart';
import 'package:http/http.dart' as http;
import '../isolate_mixin.dart';

class Report extends IssuedCommand with IsolateMixin {
  Report() {
    commandList = ['report'];
  }

  @override
  void takeAction() {
    Isolate.spawn(pokePythonVoice, pwConPort.sendPort);
    Isolate.spawn(pokeKoolerTron, pwConPort.sendPort);
    Isolate.spawn(pokeArgLib, pwConPort.sendPort);
    http.get('http://192.168.178.238:5000/report');
    say('On duty, sir!');
  }
}

void pokeKoolerTron(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\koolertron23Receiver.exe',
    ['Report'],
  );
}

void pokeArgLib(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\ArgLib.exe',
    ['Report'],
  );
}

void pokePythonVoice(SendPort sendPort) {
  Process.runSync(
    'python',
    ['C:\\DATA Samsung 500GB SSD\\Programmeren\\pythonVoice\\pythonVoice.py', 'Report'],
  );
}
