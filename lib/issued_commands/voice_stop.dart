//void cmdVoiceStop() {
//  if (kOutputFile.readAsStringSync().contains('!VoiceStop')) {
//    print('!VoiceStop detected!');
//    String updatedText = kOutputFile.readAsStringSync().replaceAll('!VoiceStop', '🤖!🤖VoiceStop🤖');
//    kOutputFile.writeAsStringSync(updatedText, mode: FileMode.write);
//    Isolate.spawn(voiceStop, pwConPort.sendPort);
//  }
//}

//void voiceStop(SendPort sendPort) {
//  Process.runSync(
//    'C:\\DATA Samsung 500GB SSD\\git\\Code\\AutoHotkey\\ArgLib.exe',
//    ['VoiceStop'],
//  );
//}

//void conPort() {
//  pwConPort.listen((data) {
//    print(data);
//    pwConPort.close();
//  }, onError: (err) {
//    print(err);
//  });
//}
