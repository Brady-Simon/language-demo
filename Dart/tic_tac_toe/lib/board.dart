import 'package:tic_tac_toe/player.dart';

class Board {
  /// The private board that keeps track of the player locations.
  final List<Player> _board;

  /// Creates a [Board] with an optional starting [board].
  /// Defaults to a 3x3 board filled with [Player.empty].
  Board([List<Player>? board]) : _board = board ?? Board.empty();

  static List<Player> empty() {
    return List.filled(9, Player.empty);
  }

  /// Whether or not the board has no winner and no remaining spaces.
  bool get isStalemate {
    // Still has remaining spaces to play.
    if (_board.contains(Player.empty)) {
      return false;
    }

    // Winner means the game isn't in a stalemate.
    if (isWinner(Player.X) || isWinner(Player.O)) {
      return false;
    }

    return true;
  }

  /// Tries to place [player] at the [index] and returns if the player was 
  /// placed.
  /// 
  /// Cannot be placed when the index is out of bounds or if a value is 
  /// already present.
  bool place(Player player, int index) {
    // Don't place the piece if the index is out of range.
    if (!inBounds(index)) {
      return false;
    }

    // Existing value must not be the default value, 0.
    final existingValue = _board[index];
    if (existingValue != Player.empty) {
      return false;
    }

    _board[index] = player;
    return true;
  }

  /// Whether or not [index] is a valid index on this board.
  bool inBounds(int index) {
    return index >= 0 && index < _board.length;
  }

  /// Returns whether or not [player] has a winning pattern.
  bool isWinner(Player player) {
    // All possible winning patterns.
    const winningPatterns = [
      // Horizontal patterns
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // Vertical patterns
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // Diagonal patterns
      [0, 4, 8],
      [2, 4, 6],
    ];

    // Go through each pattern and see if the value appears.
    var wonGame = false;
    for (final pattern in winningPatterns) {
      final didWin = pattern.every((index) => _board[index] == player);
      if (didWin) {
        wonGame = true;
      }
    }

    return wonGame;
  }

  /// Gets a string icon for the value on the board at [index].
  String iconAt(int index) {
    return inBounds(index) && _board[index] != Player.empty
        ? _board[index].icon()
        : index.toString();
  }

  @override
  String toString() {
    // Go through each horizontal pattern on the board.
    const horizontalPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
    ];

    // Build out each line of the board.
    var lines = <String>[];
    for (final pattern in horizontalPatterns) {
      // Get the patterns at their values.
      final icons = pattern.map((index) => iconAt(index));
      final line = icons.join(' | ');
      lines.add(line);
    }

    // Combine the lines together with newlines.
    final output = lines.join('\n');
    return output;
  }
}
