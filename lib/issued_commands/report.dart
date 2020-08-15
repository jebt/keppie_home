import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/issued_command.dart';
import '../isolate_mixin.dart';

class Report extends IssuedCommand with IsolateMixin {
  Report() {
    commandList = ['report'];
  }

  @override
  void takeAction() {
    String updatedText = kOutputFile.readAsStringSync().replaceAll('!Report', '🤖!🤖Report🤖');
    kOutputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    Isolate.spawn(pokeKoolerTron, pwConPort.sendPort);
    Isolate.spawn(pokeArgLib, pwConPort.sendPort);
    log('On duty, sir!');
  }
}

void pokeKoolerTron(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\koolertron23Receiver.exe',
    ['Report'],
  );
  print('koolertron poked!');
}

void pokeArgLib(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\ArgLib.exe',
    ['Report'],
  );
}
