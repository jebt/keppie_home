//todo: detection of commands (and chat-triggers) should really happen in one function with regex pattern matching and
// forwarded

import 'event.dart';
import 'dart:io';
import 'package:keppie_home/utilities/constants.dart';

abstract class IssuedCommand extends Event {
  List<String> commandList;
  final Duration _retryDelayOnException = Duration(milliseconds: 100);

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
        log('"$c" detected!');
        return c;
      }
    }
    return null;
  }

  String tryReadLiveFileContent() {
    int failures = 0;
    try {
      return kOutputFile.readAsStringSync();
    } catch (e) {
      print(e);
      failures++;
      if (failures < 10) {
        sleep(_retryDelayOnException);
        return tryReadLiveFileContent();
      } else if (failures >= 10) {
        throw Exception('Could not read live file content.');
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

  void tryWriteMarkCommand(String updatedText, {int failures = 0}) {
    int _fails = failures;
    try {
      kOutputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    } catch (e) {
      print(e);
      _fails++;
      if (_fails < 10) {
        sleep(_retryDelayOnException);
        tryWriteMarkCommand(updatedText, failures: _fails);
      } else if (_fails >= 10) {
        throw Exception('Could not write to live file to mark command.');
      }
    }
  }

  void takeAction();
}
