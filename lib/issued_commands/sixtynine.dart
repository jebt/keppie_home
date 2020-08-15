import 'package:keppie_home/issued_command.dart';

class Sixtynine extends IssuedCommand {
  Sixtynine() {
    commandList = ['69', 'sixtynine'];
  }

  @override
  void takeAction() {
    log('Nice...😏');
  }
}
