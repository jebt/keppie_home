import 'utilities/logger.dart' as logger;

abstract class Event {
  void check();

  void log(String s) {
    logger.log(s);
  }
}
