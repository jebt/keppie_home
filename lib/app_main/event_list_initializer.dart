import 'package:keppie_home/issued_commands/clear_chat.dart';
import 'package:keppie_home/issued_commands/hue_wow.dart';
import 'package:keppie_home/issued_commands/iss.dart';
import 'package:keppie_home/issued_commands/lights_off.dart';
import 'package:keppie_home/issued_commands/lights_on.dart';
import 'package:keppie_home/issued_commands/report.dart';
import 'package:keppie_home/issued_commands/shower_thought.dart';
import 'package:keppie_home/issued_commands/toggle_lights.dart';
import 'package:keppie_home/issued_commands/sixtynine.dart';
import 'package:keppie_home/issued_commands/toggle_plug.dart';
import 'package:keppie_home/issued_commands/copy_pasta.dart';
import 'package:keppie_home/issued_commands/default_ambient_lights.dart';
//import 'package:keppie_home/issued_commands/test_event.dart';

import 'package:keppie_home/high_level/event.dart';
import 'package:keppie_home/issued_commands/spotify_sultans_of_swing.dart';

class EventListInitializer {
  List<Event> initialize() {
    return [
      //TestEvent(),
      Report(),
      ClearChat(),
      Sixtynine(),
      TogglePlug(),
      CopyPastaTop1(),
      CopyPastaRandomTop10(),
      ShowerThought1(),
      SpotifySultansOfSwing(),
      Iss(),
      LightsOn(),
      LightsOff(),
      ToggleLights(),
      HueWow(),
      DefaultAmbientLights(),
    ];
  }
}

//flutterapp: the ISS is ...km from here

//trigIssClose //alert when iss is within like 500 km orso and prevent same alert for like 2 hours
//trigFemkePostedNewVideo //with hue lights effects and soundfile
//trigHansAndShifraPostedNewVideo //with hue lights effects and soundfile

//trig69();
//trigKeppie();

//cmdRegexIntToRoman
//cmdRegexRomanToInt
//cmdKeppieBotGoShitPostOnSlashRSlashKeppie
//cmdCommandNotRecognizedRepeatCommand
//cmdBackupAndClearChat
//cmdLightsOnNiceDefaultAmbientLightSetting
//cmdRedditJoke(); //tell a random joke
//cmdQuote();
//cmdRollTheDice();
//cmdLeftOrRight();
//cmdYesOrNo();
//cmdRandomAction();
//cmdSetRandomActionInterval(); //times per hour?
//cmdSoSadDespacito(); //this is so sad, Keppiebot, play despacito, play spotify
//cmdSoSadDatZijnWij(); //samen met jou//[delay], wow this is so beautifull..
//cmdSetEggAlarm();
//cmdWeatherApi();
//cmdReadFirstParagraphOfWikipediaPageOf(); //usage: "what is {var}?"
//cmdDefineWord(); //usage: "define {var}?" //take from some api but have special cases like keppie programmed in
//cmdTranslateEnToNl(); //translate api??
//cmdTranslateNlToEn();

//cmdAlbertHeijnBonus();

//evt BKE, wolfram 1 dimensional automaton, GoK, etc

//cmdSetFilter
