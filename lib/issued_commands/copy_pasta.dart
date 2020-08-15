import 'dart:io';
import 'dart:isolate';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/issued_command.dart';
import '../isolate_mixin.dart';

class CopyPastaTop1 extends IssuedCommand with IsolateMixin {
  CopyPastaTop1() {
    commandList = [
      'cp1' 'copy pasta',
      'copypasta',
      'cpt',
      'cpt1',
      'cp',
    ];
  }

  @override
  void takeAction() {
    Isolate.spawn(cp1, pwConPort.sendPort);
  }
}

class CopyPastaRandomTop10 extends IssuedCommand with IsolateMixin {
  CopyPastaRandomTop10() {
    commandList = [
      'cp10',
      'cpr',
      'cpr10',
      'cprt10',
      'copy pasta 10',
      'copypasta10',
      'copypastarandom',
      'copy pasta random',
      'copypasta random',
    ];
  }

  @override
  void takeAction() {
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
