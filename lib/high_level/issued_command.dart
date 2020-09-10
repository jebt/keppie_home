//todo: detection of commands (and chat-triggers) should really happen in one function with regex pattern matching and
// forwarded

import 'event.dart';
import 'package:keppie_home/utilities/central_file_manager.dart';

abstract class IssuedCommand extends Event {
  List<String> commandList;

  @override
  void check() async {
    String liveFileContent = tryReadLiveFileContent();
    String cmd = detect(liveFileContent);
    if (cmd != null) {
      await respond(cmd, liveFileContent);
    }
  }

  String detect(String liveFileContent) {
    String liveFileContentLoweredCase = liveFileContent.toLowerCase();
    for (String c in commandList) {
      if (liveFileContentLoweredCase.contains('!' + c.toLowerCase() + '!')) {
        print('"$c" detected!');
        return c;
      }
    }
    return null;
  }

  void respond(String cmd, String liveFileContent) async {
    markCommand(cmd, liveFileContent);
    await takeAction();
  }

  void markCommand(String cmd, String liveFileContent) {
    String updatedText = liveFileContent.replaceAll(RegExp('!$cmd!', caseSensitive: false), '🤖$cmd🤖');
    tryWriteMarkCommand(updatedText);
  }

  void takeAction();
}
