import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/high_level/isolate_mixin.dart';

class SpotifySultansOfSwing extends IssuedCommand with IsolateMixin, ShortcutsMixin {
  SpotifySultansOfSwing() {
    commandList = [
      'play sultans of swing',
      'sos',
      'ds',
      'dire straits',
      'play dire straits',
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
