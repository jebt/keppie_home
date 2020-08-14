import 'dart:io';
import 'dart:isolate';

String uriTop = '';
List<String> argsTop = [];

void entryPoint(SendPort sendPort) {
  String uriTopFunc = uriTop;
  List<String> argsTopFunc = argsTop;
  Process.runSync(uriTopFunc, argsTopFunc);
}

class UriRunner {
  var pwConPort = ReceivePort();

  UriRunner(String uri, List<String> args) {
    uriTop = uri;
    argsTop = args;
  }

  void run() {
    Isolate.spawn(entryPoint, pwConPort.sendPort);
  }
}
