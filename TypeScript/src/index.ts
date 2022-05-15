import Player from './player.js';
import Board from './board.js';
import PromptSync from 'prompt-sync';

/** Allows prompts on the command line. */
const prompt = PromptSync();

/** Plays Tic-Tac-Toe. */
function main() {
  console.log('\nTic-Tac-Toe!');
  var playing = true;

  // Playing loop
  while (playing) {
    var board = new Board();
    var player = Player.X;

    // Main game loop
    while (!board.isStalemate) {
      // Let the player choose their spot.
      play(board, player);

      // Check if the player won.
      if (board.isWinner(player)) {
        console.log(board.toString());
        console.log(`Player ${player.icon()} won!`);

        if (shouldPlayAgain()) {
          // Restart the game
          board = new Board();
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
    console.log(board.toString());
    console.log('Stalemate!');
    if (shouldPlayAgain()) {
      // Restart the game
      board = new Board();
      player = Player.X;
      continue;
    } else {
      playing = false;
    }
  }
}

/**
 * Lets `player` choose their spot on the `board`.
 * @param {Board} board The board being played.
 * @param {Player} player The current player.
 */
function play(board: Board, player: Player) {
  // Continue looping until the user picks a valid value.
  var isValidAnswer = false;
  while (!isValidAnswer) {
    // Print the current board so the user can see the options.
    console.log(board.toString());

    const input = prompt(`(${player.icon()}) Pick a spot: `);
    var boardIndex = parseInt(input);

    if (!Number.isNaN(boardIndex)) {
      var didPlay = board.place(player, boardIndex);
      if (didPlay) isValidAnswer = true;
    }

    // The user picked an invalid value.
    if (!isValidAnswer) {
      console.log('Invalid value. Try again.');
    }
  }
}

/**
 * Gets input from the user on whether to play again.
 * @returns Whether the user wants to play again.
 */
function shouldPlayAgain(): boolean {
  const input = prompt('Play again? <y|n>: ');
  const playAgain = input.trim().toLowerCase() === 'y';
  return playAgain;
}

main();
