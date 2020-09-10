import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/high_level/isolate_mixin.dart';
import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:keppie_home/utilities/fancy_hue.dart';
import 'package:keppie_home/utilities/constants.dart';
import 'package:keppie_home/utilities/speech.dart';

class DefaultAmbientLights extends IssuedCommand with IsolateMixin, ShortcutsMixin {
  DefaultAmbientLights() {
    commandList = [
      'default ambient lights',
      'amb',
      'ambient',
      'default',
      'default lights',
      'dl',
      'ambient lights',
      'ambient light',
      'default light',
    ];
  }

  @override
  void takeAction() async {
    say('Activating default ambient light settings...');
    FancyHue fancyHue = FancyHue();
    await fancyHue.activateDefaultAmbientLights();
    Isolate.spawn(plugOn, pwConPort.sendPort); // ignore: unawaited_futures
  }
}

void plugOn(SendPort sendPort) {
  Process.runSync('python', [kPlugOnPath]);
}
