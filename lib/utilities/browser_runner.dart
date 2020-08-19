import 'dart:io';

void runBrowser(String url) {
  var fail = false;
  switch (Platform.operatingSystem) {
    case 'linux':
      Process.runSync('x-www-browser', [url]);
      break;
    case 'macos':
      Process.runSync('open', [url]);
      break;
    case 'windows':
      //"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
      Process.runSync('C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe', [url], runInShell: true);
      break;
    default:
      fail = true;
      break;
  }
  if (!fail) {
    print('Ran browser.');
  }
}
