import 'package:keppie_home/issued_command.dart';
import 'package:keppie_home/utilities/speech.dart';

class Sixtynine extends IssuedCommand {
  Sixtynine() {
    commandList = ['69', 'sixtynine'];
  }

  @override
  void takeAction() {
    say('Nice...😏');
  }
}
