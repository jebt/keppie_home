import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/high_level/issued_command.dart';
import '../isolate_mixin.dart';

class SpotifySultansOfSwing extends IssuedCommand with IsolateMixin {
  SpotifySultansOfSwing() {
    commandList = [
      'sos',
      'ds',
      'dire straits',
      'play dire straits',
      'play sultans of swing',
      'sultans of swing',
      'music',
      'play music',
      'play',
    ];
  }

  @override
  void takeAction() {
    Isolate.spawn(sultansOfSwing, pwConPort.sendPort);
  }
}

void sultansOfSwing(SendPort sendPort) {
  Process.runSync(
    kArgLibPath,
    ['SultansOfSwing'],
  );
}
