import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:keppie_home/utilities/fancy_hue.dart';
import 'package:keppie_home/utilities/speech.dart';

class HueWow extends IssuedCommand with ShortcutsMixin {
  HueWow() {
    commandList = [
      'wow',
    ];
  }

  @override
  void takeAction() async {
    say('Woooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooowwwwww...');
    FancyHue fancyHue = FancyHue();
    await fancyHue.goCrazy();
  }
}
