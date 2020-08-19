import 'dart:cli';

import 'package:keppie_home/issued_command.dart';
import 'package:keppie_home/fancy_hue.dart';
import 'package:keppie_home/utilities/speech.dart';

class HueWow extends IssuedCommand {
  HueWow() {
    commandList = [
      'wow',
    ];
  }

  @override
  void takeAction() async {
    FancyHue fancyHue = FancyHue();
    await fancyHue.goCrazy();
  }
}
