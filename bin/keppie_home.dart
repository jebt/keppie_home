//todo: refactor to make use of a short lived instantiated object which holds and updates live file state and
// delegate to the IssuedCommands for action
// this should take care of the event processing, something like DetectedCommandProcess.

//todo: live file should really only be read once every loop and regex matched for commands and chat triggers

//todo: local webserver om status lampen/smartplugswitches op te vragen en liveFileContent (GET) en PUT string liveFile
// PUT string in liveFile kan dan gebruikt worden in flutter app ipv smb:// om vanaf telefoon te interfacen.

import 'dart:io';

import 'package:keppie_home/event.dart';
import 'package:keppie_home/event_list_initializer.dart';
import 'package:keppie_home/utilities/logger.dart';

const Duration sleepTime = Duration(milliseconds: 100);

void main(List<String> arguments) async {
  log('Initializing KeppieHome™ event loop...');
  List<Event> events = EventListInitializer().initialize();
  log('!report!');

  int i = 0;
  while (true) {
    if (i % 1000 == 0) {
      log('Event loop ${(i / 1000).floor()}k: listening...');
    }
    for (Event event in events) {
      await event.check();
    }
    sleep(sleepTime);
    i++;
  }
}

//todo: replace isolate spawns with waitFor<T>(someAsyncThatReturnsT) solution wherever desirable.

//todo: migrate AHK portions of the project to this repo. Push to github. Run KeppieConsole ahk script at start of this

//todo: change all references to keppie to jebt? for professionalism

//todo: make autohotkey writing to central file more stable with retries on failures in keppieTerminal, koolertron23.ahk
//todo: ...ArgLib.ahk, metakeys, everywhere.
