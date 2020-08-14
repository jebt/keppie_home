import 'package:keppie_home/issued_commands/test_event.dart';

import 'event.dart';
import 'issued_commands/sixtynine.dart';
import 'package:keppie_home/issued_commands/toggle_plug.dart';

class EventListInitializer {
  List<Event> initialize() {
    return [
      Sixtynine(),
      TestEvent(),
      TogglePlug(),
    ];
  }
}
