import 'dart:convert';
import 'dart:isolate';

import 'package:keppie_home/high_level/issued_command.dart';
import 'package:http/http.dart' as http;
import 'package:keppie_home/utilities/browser_runner.dart';
import 'package:keppie_home/isolate_mixin.dart';
import 'package:keppie_home/utilities/logger.dart';
import 'package:keppie_home/utilities/speech.dart';

class Iss extends IssuedCommand with IsolateMixin {
  Iss() {
    commandList = [
      'iss',
      'where is the ISS',
      'international space station',
      'where is the international space station',
    ];
  }

  @override
  void takeAction() async {
    await Isolate.spawn(iss, pwConPort.sendPort);
    say('This is the current location of the International Space Station.');
  }
}

void iss(SendPort sendPort) async {
  await cmdIssGoogleMaps();
}

Future cmdIssGoogleMaps() async {
  var response = await http.get('http://api.open-notify.org/iss-now.json');
  if (response.statusCode == 200) {
    String data = response.body;
    var decoded = jsonDecode(data);
    var lat = decoded['iss_position']['latitude'];
    var lon = decoded['iss_position']['longitude'];
    print('lat: ' + lat.toString());
    print('lon: ' + lon.toString());
    //The format/encoding of url/query with escaping characters in a specific way when using it while opening it
    // in the browser through shell is extremely arcane and strict. It seems it should be EXACTLY as follows:
    String url = 'https://www.google.com/maps/?q=$lat,$lon^&ll=$lat,$lon^&z=4';
    runBrowser(url);
    //The following logged message differs from the url passed into runBrowser so that it looks more normal and is
    // clickable for example in VSCode. It's unfortunate that we can't use a variable instead of a literal.
    log('https://www.google.com/maps/?q=$lat,$lon&ll=$lat,$lon&z=4');
  } else {
    log('Error: ' + response.statusCode.toString());
    return response;
  }
}
