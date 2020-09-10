import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/utilities/speech.dart';
import 'package:keppie_home/high_level/isolate_mixin.dart';

class CopyPastaTop1 extends IssuedCommand with IsolateMixin {
  CopyPastaTop1() {
    commandList = [
      'cp1',
      'cpt',
      'cpt1',
    ];
  }

  @override
  void takeAction() {
    say('Enjoy this copy pasta!');
    Isolate.spawn(cp1, pwConPort.sendPort);
  }
}

class CopyPastaRandomTop10 extends IssuedCommand with IsolateMixin {
  CopyPastaRandomTop10() {
    commandList = [
      't10RandCopyPasta',
      'cp10',
      'cpr',
      'cpr10',
      'cprt10',
      'copy pasta 10',
      'copypasta10',
      'copypastarandom',
      'copy pasta random',
      'copypasta random',
      'copy pasta',
      'cp',
    ];
  }

  @override
  void takeAction() {
    say('Enjoy this random copy pasta!');
    Isolate.spawn(cprt10, pwConPort.sendPort);
  }
}

void cp1(SendPort sendPort) {
  Process.runSync(
    kArgLibPath,
    ['CopyPastaTop'],
  );
}

void cprt10(SendPort sendPort) {
  Process.runSync(
    kArgLibPath,
    ['CopyPastaTopRandom'],
  );
}
