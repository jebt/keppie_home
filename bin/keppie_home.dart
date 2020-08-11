import 'package:keppie_home/keppie_home.dart' as keppie_home;
import 'dart:io';
import 'dart:isolate';
import 'package:http/http.dart' as http;
//import 'dart:math';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:core';

//import 'package:url_launcher/url_launcher.dart';
//import 'dart:html' as html;

const sleepTime = Duration(milliseconds: 1000);

DateFormat dateFormat = DateFormat('HH:mm');

var pwConPort = ReceivePort();
File outputFile =
//File('C:\\DATA Samsung 500GB SSD\\Programmeren\\logs\\testlog.log');
File('Z:\\Live_Functionality\\keppie_central.log');

void log(String message) {
  //var now = new DateTime.now().toUtc().toIso8601String();
  String timeString = dateFormat.format(DateTime.now());
  outputFile.writeAsStringSync(
      "$timeString 👸🏼keppieEventLoop.dart:   $message\n",
      mode: FileMode.append);
}

main(List<String> arguments) async {
  print('starting');
  conPort();
  while (true) {
    sleep(sleepTime);
    await eventLoop();
  }
}

Future<void> eventLoop() async {
  //print('listening..');
  cmdReport();
  cmd69();
  cmdRedditShowerThought();
  cmdRedditCopyPasta();
  cmdRedditCopyPastaRandom();
  cmdRedditCopyPastaRandomLong();
  cmdVoiceStop();
  await cmdIssGoogleMaps(); //iss web api call, dan google maps openen met query met de coördinaten

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
  //cmdClearChat
  //cmdSetEggAlarm();
  //cmdWeatherApi();
  //cmdReadFirstParagraphOfWikipediaPageOf();
  //cmdDefineWord();
  //cmdTranslateEnToNl(); //translate api??
  //cmdTranslateNlToEn();
  //cmdAlbertHeijnBonus();

  //evt BKE, wolfram 1 dimensional automaton, GoK, etc

  //cmdSetFilter
}

void cmdReport() {
  if (outputFile.readAsStringSync().contains("!Report")) {
    print("!Report detected!");
    String updatedText =
    outputFile.readAsStringSync().replaceAll("!Report", "🤖!🤖Report🤖");
    outputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    //poke koolertron23.ahk
    Isolate.spawn(pokeKoolerTron, pwConPort.sendPort);
    //poke ArgLib.ahk
    Isolate.spawn(pokeArgLib, pwConPort.sendPort);

    log('On duty, sir!');
  }
}

pokeKoolerTron(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\koolertron23Receiver.exe',
    ['Report'],
  );
  print('koolertron poked!');
}

Future cmdIssGoogleMaps() async {
  if (outputFile.readAsStringSync().contains('!ISS')) {
    print('!ISS detected!');
    String updatedText =
    outputFile.readAsStringSync().replaceAll('!ISS', "🤖!🤖ISS🤖");
    outputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    var response = await http.get('http://api.open-notify.org/iss-now.json');
    if (response.statusCode == 200) {
      String data = response.body;
      var decoded = jsonDecode(data);
      var lat = decoded['iss_position']['latitude'];
      var lon = decoded['iss_position']['longitude'];
      print('lat: ' + lat.toString());
      print('lon: ' + lon.toString());

//      String url = 'https://www.google.com/maps/search/$lat' +
//          '%2C' +
//          '$lon/@$lat' +
//          '%2C' +
//          '$lon' +
//          '%2C' +
//          '4z';

      // escape: %5C

      //String url = 'https://www.google.com/maps/search/$lat,$lon/@$lat,$lon,4z';
      String url =
          'https://www.google.com/maps/search/$lat%2C$lon/@$lat%2C$lon%2C4z';

      //String encoded = Uri.encodeFull(url);

      url =
      'https://www.google.com/maps/search/42.5549%2C51.3666/%4042.5549,51.3666,4z';

      url =
      'https://www.google.com/maps/search/42.5549%2C51.3666/%4042.5549,C51.3666&z=5';

      url =
      'https://www.google.com/maps"^"?q=42.5549,51.3666&ll%3D42.5549,51.3666&z%3D5';
      //String encoded = Uri.encodeFull(url);
      //print(encoded);

//      url =
//          'https://maps.google.com/?q=38.6531004%2C-90.243462^&ll=38.6531004%2C-90.243462^&z=5';

      //%26
//
//      url =
//          'https://maps.google.com/?q=38.6531004%2C-90.243462%26ll=38.6531004%2C-90.243462%26z=5';

      url =
      '"https://www.google.com/maps/\?q=42.5549,51.3666&ll=42.5549,51.3666&z=5"';

      url = 'http://maps.google.nl/search/tiel/';

      url =
      'https://www.google.com/maps/search/42.5549%2C51.3666/%5C%4042.5549%5C%2C51.3666%5C%2C5z/';

      //WTF DEZE IS HET!?!?!?!?!?
      //WTF DEZE IS HET!?!?!?!?!?
      url = "https://www.google.com/maps/?q=$lat,$lon^&ll=$lat,$lon^&z=4";
      //WTF DEZE IS HET!?!?!?!?!?
      //WTF DEZE IS HET!?!?!?!?!?

      runBrowser(url);
      log("https://www.google.com/maps/?q=$lat,$lon&ll=$lat,$lon&z=4");
      //print(url);
      //print(encoded);

//      if (await canLaunch(url))
//        launch(url);
//      else {
//        print('error with canlauch');
//      }
      // can't launch url, there is some error

      //     https://www.google.com/maps/search/42.5549,51.3666/@42.5549,51.3666,4z
      //     https://www.google.com/maps/search/42.5549%2C51.3666/@42.5549%2C51.3666%2C4z
      //     https://www.google.com/maps/search/42.5549%2C51.3666/@42.5549%2C51.3666%5C%2C4z

      // https://www.google.com/maps/search/42.5549%2C51.3666/%4042.5549,51.3666,4z

      //%5C

    } else {
      log('Error: ' + response.statusCode.toString());
    }
    return response;
  }
}

void cmdRedditCopyPasta() {
  if (outputFile.readAsStringSync().contains("!CoPa")) {
    print("!CoPa detected!");
    String updatedText =
    outputFile.readAsStringSync().replaceAll("!CoPa", "🤖!🤖CoPa🤖");
    outputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    Isolate.spawn(copyPasta, pwConPort.sendPort);
  }
}

void cmdVoiceStop() {
  if (outputFile.readAsStringSync().contains("!VoiceStop")) {
    print("!VoiceStop detected!");
    String updatedText = outputFile
        .readAsStringSync()
        .replaceAll("!VoiceStop", "🤖!🤖VoiceStop🤖");
    outputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    Isolate.spawn(voiceStop, pwConPort.sendPort);
  }
}

void voiceStop(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\ArgLib.exe',
    ['VoiceStop'],
  );
}

void cmdRedditCopyPastaRandom() {
  if (outputFile.readAsStringSync().contains("!CPR")) {
    print("!CPR detected!");
    String updatedText =
    outputFile.readAsStringSync().replaceAll("!CPR", "🤖!🤖CPR🤖");
    outputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    Isolate.spawn(copyPastaRandom, pwConPort.sendPort);
  }
}

void cmdRedditCopyPastaRandomLong() {
  if (outputFile.readAsStringSync().contains("!CopyPastaRandom")) {
    print("!CopyPastaRandom detected!");
    String updatedText = outputFile
        .readAsStringSync()
        .replaceAll("!CopyPastaRandom", "🤖!🤖CopyPastaRandom🤖");
    outputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    Isolate.spawn(copyPastaRandom, pwConPort.sendPort);
  }
}

void conPort() {
  pwConPort.listen((data) {
    print(data);
    pwConPort.close();
  }, onError: (err) {
    print(err);
  });
}

void cmd69() {
  if (outputFile.readAsStringSync().contains("!69")) {
    print("!69 detected!");
    String updatedText =
    outputFile.readAsStringSync().replaceAll("!69", "🤖!🤖69🤖");
    outputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    log("Nice...😏");
  }
}

void cmdRedditShowerThought() {
  if (outputFile.readAsStringSync().contains("!ShowerThought")) {
    print("!ShowerThought detected!");
    String updatedText = outputFile
        .readAsStringSync()
        .replaceAll("!ShowerThought", "🤖!🤖ShowerThought🤖");
    outputFile.writeAsStringSync(updatedText, mode: FileMode.write);
    Isolate.spawn(showerThought, pwConPort.sendPort);
  }
}

void showerThought(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\ArgLib.exe',
    ['ShowerThoughtTop'],
  );
}

void copyPasta(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\ArgLib.exe',
    ['CopyPastaTop'],
  );
}

void copyPastaRandom(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\ArgLib.exe',
    ['CopyPastaTopRandom'],
  );
}

void pokeArgLib(SendPort sendPort) {
  Process.runSync(
    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\ArgLib.exe',
    ['Report'],
  );
}

void runBrowser(String url) {
  var fail = false;
  switch (Platform.operatingSystem) {
    case "linux":
      Process.runSync("x-www-browser", [url]);
      break;
    case "macos":
      Process.runSync("open", [url]);
      break;
    case "windows":
    //"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
      Process.runSync(
          "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe",
          [url],
          runInShell: true);
//      Process.start(
//          //'"C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"',
//          'explorer',
//          [url],
//          runInShell: true,
//          mode: ProcessStartMode.detached);
      print('hij komt hier nog');
      break;
    default:
      fail = true;
      break;
  }
  if (!fail) {
    print("Start browsing...");
  }

//todo: schematisch uittekenen hoe alles samenhangt, classes definieren, api's definieren

//todo: migreren naar standalone dart applicatie die in cmd kan draaien, daar om de 100 loops listening... print en geminimaliseerd kan worden naar de system tray. git Repositories maken, inchecken, pushen naar github

//todo: switch statement, regular expression, only last 100 lines, all commands at once from 1 file read. also only 1 file write per loop, more nice interactive commands with parameters and triggers with regular expression like je bent dom --> je bent zelf dom / daar kan ik niks aan doen

//todo: language filter met hashmap{naughty:replacement}, for each hashmap item regular replaceAll(naughty, replacement)

//todo: functies, triggers, commando's, grappige dingetjes etc van TRIP overnemen.

//todo: ansi colors mogelijk? helaas waarschijnlijk niet? eclipse quivalente extensie zoeken?

//todo: choose your own adventure maken (half jatten en dan hans en shifra thema bijv ofzo), spelen in console

//todo: voice onderbreken

//todo: !ReadForMe gaat gewoon shit in de chat voorlezen

//todo: voice to text voice commando activation (echte bot!!) (bijv python script dat luistert en plakt in chat)

//todo: log naar NAS

//todo: log naar DB

//todo: uiteindelijk wss firebase ofzo

//todo: flutter app om de fun te joinen (ook via wireguard), uiteindelijk anders web api bijv python flask

//todo: keppie console extra functionaliteit zoals lijstjes met commando's om uit te kiezen

//todo: try, catch voor IO. anders geheid crashes

//todo: \- Emojifier / UwUfier bots implementeren (reddit copypasta) / cummybot?

//todo: microfoon kopen die constant kan luisteren

//todo: een IOT apparaat kopen. een lamp lijkt me het beste om mee te beginnen en die dan aansturen met spraak en laten reageren op shit. ook een general purpose (light)switch TP-Link HS200? en dan bijvoorbeeld ventilator op aansluiten XD
}
