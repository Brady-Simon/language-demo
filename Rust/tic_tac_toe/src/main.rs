use std::io;

use crate::board::Board;
use crate::player::Player;

mod board;
mod player;

fn main() {
    println!("Tic-Tac-Toe!");
    let mut playing = true;

    // Playing loop
    while playing {
        let mut board = Board::new();
        let mut player = Player::X;

        // Main game loop
        while !board.is_stalemate() {
            // Let the player choose their spot.
            play(&mut board, &player);

            // Check if the player won.
            if board.is_winner(&player) {
                println!("{board}");
                println!("Player {} won!", player.icon(true));

                if should_play_again() {
                    // Restart the game
                    board = Board::new();
                    player = Player::X;
                    continue;
                } else {
                    playing = false;
                    break;
                }
            }

            // Update the player.
            player = player.next_player();
        }

        // Don't check for stalemates if the user stopped.
        if !playing {
            break;
        }

        // Stalemate reached.
        println!("{board}");
        println!("Stalemate!");

        if !should_play_again() {
            break;
        }
    }
}

/// Lets `player` choose their spot on the `board`.
fn play(board: &mut Board, player: &Player) {
    let invalid_input = "Invalid value. Pick again.";

    // Continue looping until the user picks a value.
    loop {
        // Print the current board so the user can see the options.
        println!("{board}");
        println!("({}) Pick a spot: ", player.icon(true));

        let mut input = String::new();
        let stdin = io::stdin();

        if stdin.read_line(&mut input).is_ok() {
            if let Ok(index) = input.trim().parse::<usize>() {
                if board.place(player, index) {
                    break;
                }
            }
        }

        println!("{invalid_input}");
    }
}

/// Gets input from the user on whether to play again.
fn should_play_again() -> bool {
    println!("Play again? <y|n>: ");

    let mut input = String::new();
    let stdin = io::stdin();
    _ = stdin.read_line(&mut input);

    input.trim() == "y"
}
