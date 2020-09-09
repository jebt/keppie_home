import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/utilities/central_file_manager.dart';

class ClearChat extends IssuedCommand {
  ClearChat() {
    commandList = [
      'clear chat',
      'clearchat',
      'clear',
    ];
  }

  @override
  void takeAction() {
    backUpAndClearFile();
  }
}
