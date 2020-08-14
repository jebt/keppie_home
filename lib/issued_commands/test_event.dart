/// KeppieHome™ by KeppieSoft™
/// A Not-So-Smart Home Solution with Personal Assistant and Home Automation Toolset
/// github.com/jebt
/// roelantvanderhilst@gmail.com
/// todo: author
/// todo: license
/// todo: example use

import 'dart:io';
import 'dart:isolate';

import 'package:keppie_home/issued_command.dart';
import 'package:keppie_home/utilities/logger.dart';

import '../isolate_mixin.dart';

/// KeppieHome™ by KeppieSoft™
/// A Not-So-Smart Home Solution with Personal Assistant and Home Automation Toolset
/// github.com/jebt
/// roelantvanderhilst@gmail.com
/// todo: author
/// todo: license
/// todo: example use
String argLibPath = 'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\ArgLib.exe';
String togglePlugPath = 'C:\\DATA Samsung 500GB SSD\\git\\Code\\Python\\tplink-smartplug-api-master\\toggle.py';
String pythonPath = 'C:\\DATA Samsung 500GB SSD\\Programmeren\\py38\\python.exe';

// "C:\DATA Samsung 500GB SSD\git\Code\Python\tplink-smartplug-api-master\toggle.py"
// "C:\DATA Samsung 500GB SSD\Programmeren\py38\python.exe"

/// KeppieHome™ by KeppieSoft™
/// A Not-So-Smart Home Solution with Personal Assistant and Home Automation Toolset
/// github.com/jebt
/// roelantvanderhilst@gmail.com
/// todo: author
/// todo: license
/// todo: example use
class TestEvent extends IssuedCommand with IsolateMixin {
  /// KeppieHome™ by KeppieSoft™
  /// A Not-So-Smart Home Solution with Personal Assistant and Home Automation Toolset
  /// github.com/jebt
  /// roelantvanderhilst@gmail.com
  /// todo: author
  /// todo: license
  /// todo: example use
  TestEvent() {
    commandList = ['test', 'keppie'];
  }

  @override
  void takeAction() {
    log('test event triggered!');
    print('test event triggered!');
    //Isolate.spawn(togglePlug, pwConPort.sendPort);
  }
}

void showerThought(SendPort sendPort) {
  Process.runSync(argLibPath, ['ShowerThoughtTop']);
}

void togglePlug(SendPort sendPort) {
  Process.runSync('python', [togglePlugPath]);
}
