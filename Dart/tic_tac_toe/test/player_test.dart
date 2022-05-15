import 'package:test/test.dart';
import 'package:tic_tac_toe/player.dart';

void main() {
  group('Player values', () {
    test('empty is 0', () {
      expect(Player.empty.value, equals(0));
    });
    test('X is 1', () {
      expect(Player.X.value, equals(1));
    });
    test('O is 2', () {
      expect(Player.O.value, equals(2));
    });
  });

  group('Next player', () {
    test('X -> O', () {
      expect(Player.X.nextPlayer(), equals(Player.O));
    });
    test('O -> X', () {
      expect(Player.O.nextPlayer(), equals(Player.X));
    });
    test('empty -> X', () {
      expect(Player.empty.nextPlayer(), equals(Player.X));
    });
  });

  group('Icon', () {
    test('empty icon', () {
      expect(Player.empty.icon(colorize: false), equals(' '));
    });
    test('X icon', () {
      expect(Player.X.icon(colorize: false), equals('X'));
    });
    test('O icon', () {
      expect(Player.O.icon(colorize: false), equals('O'));
    });
  });
}
