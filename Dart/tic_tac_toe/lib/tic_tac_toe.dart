import 'dart:io';

import 'package:tic_tac_toe/board.dart';
import 'package:tic_tac_toe/player.dart';

/// Plays Tic-Tac-Toe.
void playGame() {
  print('\nTic-Tac-Toe!');
  var playing = true;

  // Playing loop
  while (playing) {
    var board = Board();
    var player = Player.X;

    // Main game loop
    while (!board.isStalemate) {
      // Let the player choose their spot.
      _play(board, player);

      // Check if the player won.
      if (board.isWinner(player)) {
        print(board.toString());
        print('Player ${player.icon()} won!');

        if (_shouldPlayAgain()) {
          // Restart the game
          board = Board();
          player = Player.X;
          continue;
        } else {
          playing = false;
          break;
        }
      }

      // Update the player.
      player = player.nextPlayer();
    }

    // Don't check for stalemates if the user stopped.
    if (!playing) break;

    // Stalemate reached.
    print(board.toString());
    print('Stalemate!');
    if (_shouldPlayAgain()) {
      // Restart the game
      board = Board();
      player = Player.X;
      continue;
    } else {
      playing = false;
    }
  }
}

/// Lets [player] choose their spot on the [board].
void _play(Board board, Player player) {
  const errorMessage = 'Invalid value. Try again.';
  // Continue looping until the user picks a valid value.
  var isValidAnswer = false;
  while (!isValidAnswer) {
    // Print the current board so the user can see the options.
    print(board.toString());
    print('(${player.icon()}) Pick a spot: ');

    // Ensure input isn't null.
    final input = stdin.readLineSync();
    if (input == null) {
      print(errorMessage);
      continue;
    }

    // Ensure input can be parsed to an int.
    final boardIndex = int.tryParse(input);
    if (boardIndex == null) {
      print(errorMessage);
      continue;
    }

    // Try placing the player at that index.
    var didPlay = board.place(player, boardIndex);
    if (didPlay) {
      isValidAnswer = true;
    }

    // The user picked an invalid value.
    if (!isValidAnswer) {
      print(errorMessage);
    }
  }
}

/// Gets input from the user on whether to play again.
bool _shouldPlayAgain() {
  print('Play again? <y|n>: ');
  final input = stdin.readLineSync();
  final playAgain = input != null && input.trim().toLowerCase() == 'y';
  return playAgain;
}
