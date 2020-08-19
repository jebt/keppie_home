import 'package:keppie_home/issued_command.dart';

class Template extends IssuedCommand {
  Template() {
    commandList = [
      'template1',
      'template 2',
      'temp3',
    ];
  }

  @override
  void takeAction() {
    log('Doing certain template stuff...');
    //do something
  }
}
