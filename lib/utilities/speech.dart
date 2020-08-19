import 'dart:cli';
import 'dart:io';

import 'package:keppie_home/utilities/logger.dart';

import 'constants.dart';

void say(String text) {
  log(text);
  waitFor<void>(_sayInternal(text));
}

Future<void> _sayInternal(String text) async {
  Process.run(kArgLibPath, ['Say', text]);
}

//const String _emojiTestText = 'Umm 😅... so, personally 👨... this is the first 🥇 time 🕰⏰⏳ this has happened 🤔, '
//'so I\'m 👌😳 a bit 😢😁 surprised 😲. Only a centimeter 😳 away 😂... I 👁 mean 😏🤭🤫, '
//'I 👁 don\'t 🚫 think 🤔 there\'s 👌👍 ever 😠 been someone 😏 who\'s 🤷 gotten 💘 that close 🚪🚫 to me... '
//'without 🚫 a, you 👈 know 🤔... calamity 🌎💥☄ occurring 🍆🔥. I\'m 💘 not really 💯... '
//'not really 😜😏💯 sure 👍 what happens 😱 at one 1️⃣ centimeter 😳 away 😂... '
//'\'cause 🎗 it\'s my first 🥇 time ⏰. I 👥 don\'t 🚫 really 😍👍😭 understand 📚 it either ↔. '
//'Seriously 😐. But 🍑 in the flow 🌊 of calamity 🌎💥☄... there\'s 👌 nobody 🙅🏻‍♀️😤 who can attack 😍💦👊 me. '
//'Not a single 🏻 person 👫. That, I 👁 know 🤔 for sure 👍.';
