/// A Tic-Tac-Toe player represented by a number.
enum Player {
  empty(0),
  X(1),
  O(2);

  /// The raw value associated with this player.
  final int value;
  const Player(this.value);

  /// Alternate between [Player.X] and [Player.O].
  Player nextPlayer() {
    return this == Player.X ? Player.O : Player.X;
  }

  /// Gets an icon to use for this [Player]. Including [colorize] will add
  /// escape codes for a colorful output when printed on the command line.
  String icon({bool colorize = true}) {
    // Get the base icon to use.
    String icon;
    switch (this) {
      case Player.X:
        icon = "X";
        break;
      case Player.O:
        icon = 'O';
        break;
      default:
        icon = ' ';
    }

    // Colorize the icon if possible.
    if (colorize && this != Player.empty) {
      switch (this) {
        case Player.X:
          icon = [_cyanEscapeCode, icon, _resetEscapeCode].join();
          break;
        case Player.O:
          icon = [_magentaEscapeCode, icon, _resetEscapeCode].join();
          break;
        default:
          break;
      }
    }

    return icon;
  }
}

const _cyanEscapeCode = "\u001b[36m";
const _magentaEscapeCode = "\u001b[35m";
const _resetEscapeCode = "\u001b[0m";
