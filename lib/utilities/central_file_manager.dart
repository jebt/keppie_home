import 'dart:io';
import 'package:intl/intl.dart';

import 'constants.dart';

final Duration _retryDelayOnException = Duration(milliseconds: 100);

DateFormat dateFormat = DateFormat('yyyy_MM_dd_HH_mm_ss_SSS');

void backUpAndClearFile() {
  String timeStamp = dateFormat.format(DateTime.now());
  _backUpFile(timeStamp);
  _clearFile(timeStamp);
}

void _backUpFile(String timeStamp) {
  String content = tryReadLiveFileContent();
  String backUpFilePath = '${kOutputFileDir}onclearbackup\\$timeStamp.log';
  File backUpFile = File(backUpFilePath);
  backUpFile.writeAsStringSync(content, mode: FileMode.write);
}

void _clearFile(String timeStamp) {
  kOutputFile.writeAsStringSync(timeStamp + '\r\n\r\n', mode: FileMode.write);
}

String tryReadLiveFileContent({int failures = 0}) {
  int _fails = failures;
  try {
    return kOutputFile.readAsStringSync();
  } catch (e) {
    print(e);
    _fails++;
    print('Could not read live file content for IssuedCommand, failures: $_fails. Retry...');
    if (_fails < 10) {
      sleep(_retryDelayOnException);
      return tryReadLiveFileContent(failures: _fails);
    } else if (_fails >= 10) {
      throw Exception('Could not read live file content for IssuedCommand, failures: $_fails.');
    }
  }
  return null;
}

void tryWriteMarkCommand(String updatedText, {int failures = 0}) {
  int _fails = failures;
  try {
    kOutputFile.writeAsStringSync(updatedText, mode: FileMode.write);
  } catch (e) {
    print(e);
    _fails++;
    print('Could not write to live file to mark command, failures: $_fails. Retry...');
    if (_fails < 10) {
      sleep(_retryDelayOnException);
      tryWriteMarkCommand(updatedText, failures: _fails);
    } else if (_fails >= 10) {
      throw Exception('Could not write to live file to mark command, failures: $_fails.');
    }
  }
}
