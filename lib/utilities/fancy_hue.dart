import 'dart:convert';
import 'package:http/http.dart' as http;

class FancyHue {
  static const String _bridgeApiUrl = 'http://192.168.178.210/api/p307ofvMjPAOX98VpDckmPBFGLdEcWxC8TaEsjDB/';
  static const String _lightStateUrl =
      'http://192.168.178.210/api/p307ofvMjPAOX98VpDckmPBFGLdEcWxC8TaEsjDB/lights/1/state/';
  static const String _lightStateUrl2 =
      'http://192.168.178.210/api/p307ofvMjPAOX98VpDckmPBFGLdEcWxC8TaEsjDB/lights/4/state/';
  Future<http.Response> _initialBridgeState;
  static const String defaultAmbientLightBody =
      '{"on":true,"sat":222, "bri":64,"hue":7235, "colormode":"xy", "xy": [0.5235,0.4137]}';

  final Duration durOn = Duration(milliseconds: 75);
  final Duration durOff = Duration(milliseconds: 10);
  final Duration _someExtraTimeToProcess = Duration(milliseconds: 50);

  static const int hueMax = 65535;
  static const int satMax = 254;
  static const int satMed = 127;
  static const int satMin = 0;
  static const int briMax = 254;
  static const int briMed = 127;
  static const int briDim = 50;
  static const int briMin = 0;
  static const int red = 0;
  static const int yellow = 10923; //10922.5 rounded
  static const int green = 21845;
  static const int cyan = 32768; //32767.5 rounded
  static const int blue = 43690;
  static const int magenta = 54613; //54612.5 rounded

  FancyHue() {
    _initialBridgeState = fetchBridgeState();
  }

  Future<http.Response> fetchBridgeState() {
    return http.get(_bridgeApiUrl);
  }

//  Map<String, int> vals = {
//    'hueMax': 65535,
//    'satMax': 254,
//    'satMed': 127,
//    'satMin': 0,
//    'briMax': 254,
//    'briMed': 127,
//    'briDim': 50,
//    'briMin': 0,
//    'red': 0,
//    'yellow': 10923,
//    'green': 21845,
//    'cyan': 32768,
//    'blue': 43690,
//    'magenta': 54613
//  };

  static const List<int> colorWheel = [red, yellow, green, cyan, blue, magenta];
  static const String _offBody = '{"on":false}';

  String bodyWithColor(int color) {
    return '{"on":true, "sat":$satMax, "bri":$briMax,"hue":$color}';
  }

  Future<void> goCrazy() async {
    for (int i = 0; i < 3; i++) {
      await traverseGamut();
    }
    await Future.delayed(_someExtraTimeToProcess);
    await backToInitialWithOn();
    await Future.delayed(_someExtraTimeToProcess);
    await backToInitialWithOn(); //second time because sometimes a bug happens where it end with bright red
    //todo: read http status codes like 200 success to catch/log/handle errors, maybe repeat requests
    await Future.delayed(_someExtraTimeToProcess);
    await backToInitialOnOrOffSetting();
    await Future.delayed(_someExtraTimeToProcess);
  }

  Future<void> traverseGamut() async {
    for (int i = 0; i < colorWheel.length; i++) {
      await putBody(bodyWithColor(colorWheel[i]));
      await Future.delayed(durOn);
      await turnOff();
      await Future.delayed(durOff);
    }
  }

  Future<http.Response> turnOff() async {
    return await putBody(_offBody);
  }

  Future<http.Response> putBody(String body) async {
    return await http.put(_lightStateUrl, body: body);
  }

  Future<http.Response> putBody2(String body) async {
    return await http.put(_lightStateUrl2, body: body);
  }

  Future<http.Response> backToInitialWithOn() async {
    dynamic decoded = jsonDecode((await _initialBridgeState).body);
    int bri = decoded['lights']['1']['state']['bri'];
    int sat = decoded['lights']['1']['state']['sat'];
    int hue = decoded['lights']['1']['state']['hue'];
    String colormode = decoded['lights']['1']['state']['colormode'];
    double x = decoded['lights']['1']['state']['xy'][0];
    double y = decoded['lights']['1']['state']['xy'][1];
    return await putBody('{"on":true,"sat":$sat, "bri":$bri,"hue":$hue, "colormode":"$colormode", "xy": [$x,$y]}');
  }

  Future<http.Response> backToInitialOnOrOffSetting() async {
    dynamic decoded = jsonDecode((await _initialBridgeState).body);
    bool on = decoded['lights']['1']['state']['on'];
    return await putBody('{"on":$on}');
  }

  Future<http.Response> backToInitialOnOrOffSettingWithoutFade() async {
    dynamic decoded = jsonDecode((await _initialBridgeState).body);
    bool on = decoded['lights']['1']['state']['on'];
    await putBody('{"on":$on}');
    return await putBody('{"on":$on}'); //second time to get a hard instant off instead of a slow fading effect
  }

  Future<bool> isOn() async {
    dynamic decoded = jsonDecode((await _initialBridgeState).body);
    return decoded['lights']['1']['state']['on'];
  }

  void toggleLights() async {
    dynamic decoded = jsonDecode((await _initialBridgeState).body);
    bool on = decoded['lights']['1']['state']['on'];
    if (on) {
      await turnAllLightsOff();
    } else {
      await turnAllLightsOn();
    }
  }

  Future<void> turnAllLightsOn() async {
    await putBody('{"on":true}');
    await putBody2('{"on":true}');
  }

  Future<void> turnAllLightsOff() async {
    await putBody('{"on":false}');
    await putBody2('{"on":false}');
  }

  Future<void> activateDefaultAmbientLights() async {
    await putBody(defaultAmbientLightBody);
    await putBody2(defaultAmbientLightBody);
  }
}
