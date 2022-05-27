mod player;
mod board;

use std::io;

use crate::player::Player;
use crate::board::Board;

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
                println!("{}", board.to_string());
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
        println!("{}", board.to_string());
        println!("Stalemate!");

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
    
}

/// Lets `player` choose their spot on the `board`.
fn play(board: &mut Board, player: &Player) {
    let error_message = "Invalid value. Pick again.";

    // Continue looping until the user picks a value.
    let mut is_valid_answer = false;
    while !is_valid_answer {

        // Print the current board so the user can see the options.
        println!("{}", board.to_string());
        println!("({}) Pick a spot: ", player.icon(true));

        let mut input = String::new();
        let stdin = io::stdin();

        match stdin.read_line(&mut input) {
            Ok(_) => {
                match input.trim().parse::<usize>() {
                    Ok(index) => {
                        // Input was parsed as a number.
                        let i = index as usize;
                        if *board.place(&player, &i) {
                            // Player was successfully placed
                            is_valid_answer = true;
                            break;
                        } else {
                            println!("{error_message}");
                        }
                    },
                    Err(_) => {
                        println!("{error_message}");
                    }
                }
            },
            Err(_) => {
                println!("{error_message}");
            }
        }
    }
}

/// Gets input from the user on whether to play again.
fn should_play_again() -> bool {
    println!("Play again? <y|n>: ");

    let mut input = String::new();
    let stdin = io::stdin();
    _ = stdin.read_line(&mut input);

    let play_again = *input.trim().to_lowercase() == String::from("y");
    play_again
}