import 'dart:collection';

import 'package:keppie_home/high_level/event.dart';
import 'package:keppie_home/high_level/issued_command.dart';
import 'package:keppie_home/high_level/shortcuts_mixin.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

var uuid = Uuid();

const String skeleton =
    '{"categories": [{"id": "3db07153-84cd-4a89-9245-bb3824b53147","name": "Shortcuts","shortcuts": []}],"version": 40}';

const String reportString = '{"description": "!report!","iconName": "flat_color_lightbulb_2","id": "66863962-194a-43b'
    '0-bcca-4cb497784276","method": "POST","name": "Report","parameters": [{"id": "e12dd509-ed1a-409d-af6c-d8c2bb298c6b","key": "message","value": "report"}],"requestBodyType": "x_www_form_urlencode","responseHandling": {"id": "94eb553e-a5ac-4bed-8c84-9d8d80da5ea3"},"timeout": 0,"url": "http://192.168.178.238:5000/keppie"}';

String generateHttpShortcutsJson(List<Event> events) {
  List<IssuedCommand> scList = getScList(events);

  var jsonObject = jsonDecode(skeleton);
  var jsonObjectReport = jsonDecode(reportString);
  List<dynamic> shortcutsObject = [];
  for (IssuedCommand issuedCommand in scList) {
    LinkedHashMap sc = json.decode(json.encode(jsonObjectReport));
    String command = issuedCommand.commandList[0];
    sc['description'] = ('!' + command + '!');
    sc['iconName'] = 'freepik_rocket';
    sc['id'] = uuid.v4();
    sc['name'] = command;
    sc['parameters'][0]['id'] = uuid.v4();
    sc['parameters'][0]['value'] = command;
    sc['responseHandling']['id'] = uuid.v4();
    shortcutsObject.add(sc);
  }
  jsonObject['categories'][0]['shortcuts'] = shortcutsObject;
  String jsonString = jsonEncode(jsonObject);
  print(jsonString);
  return jsonString;
}

List<IssuedCommand> getScList(List<Event> events) {
  List<IssuedCommand> scList = [];
  for (Event event in events) {
    if (event is ShortcutsMixin && event is IssuedCommand) {
      IssuedCommand shortcutCommand = event;
      scList.add(shortcutCommand);
    }
  }
  return scList;
}
