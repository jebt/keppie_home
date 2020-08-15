import 'package:keppie_home/issued_commands/iss.dart';
import 'package:keppie_home/issued_commands/report.dart';
import 'package:keppie_home/issued_commands/shower_thought.dart';
import 'package:keppie_home/issued_commands/test_event.dart';

import 'event.dart';
import 'issued_commands/sixtynine.dart';
import 'package:keppie_home/issued_commands/toggle_plug.dart';
import 'package:keppie_home/issued_commands/copy_pasta.dart';

class EventListInitializer {
  List<Event> initialize() {
    return [
      Report(),
      Sixtynine(),
      TestEvent(),
      TogglePlug(),
      CopyPastaTop1(),
      CopyPastaRandomTop10(),
      ShowerThought1(),
      Iss(),
    ];
  }
}

//cmdHueToggle(); //toggle lamps on/off with !htl oid

//trig69();

//cmdRedditJoke();
//cmdQuote();
//cmdRollTheDice();
//cmdLeftOrRight();
//cmdYesOrNo();
//cmdRandomAction();
//cmdSetRandomActionInterval(); //times per hour?
//trigKeppie();
//cmdSoSadDespacito();
//cmdBackupAndClearChat
//cmdSetEggAlarm();
//cmdWeatherApi();
//cmdReadFirstParagraphOfWikipediaPageOf();
//cmdDefineWord();
//cmdTranslateEnToNl(); //translate api??
//cmdTranslateNlToEn();
//cmdAlbertHeijnBonus();

//evt BKE, wolfram 1 dimensional automaton, GoK, etc

//cmdSetFilter
