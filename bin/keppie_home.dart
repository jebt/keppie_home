import 'dart:io';

import 'package:keppie_home/event.dart';
import 'package:keppie_home/event_list_initializer.dart';
import 'package:keppie_home/utilities/logger.dart';

const Duration sleepTime = Duration(milliseconds: 1000);

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
