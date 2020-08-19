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

//todo: change all references to Keppie to Jebt? for professionalism

//todo: make autohotkey writing to central file more stable with retries on failures in keppieTerminal, koolertron23.ahk
//todo: ...ArgLib.ahk, metakeys, everywhere.
