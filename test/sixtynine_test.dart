import 'file:///C:/DATA%20Samsung%20500GB%20SSD/gitRepos/keppie_home/lib/issued_commands/sixtynine.dart';
import 'package:test/test.dart';

void main() {
  Sixtynine sixtynine = Sixtynine();

  test('commandlist_must_not_be_null', () {
    expect(sixtynine.commandList == null, false);
  });
}
