import Foundation
import CoreGame

/// Plays Tic-Tac-Toe.
func playGame() {
    print("\nTic-Tac-Toe!")
    var playing = true 

    // Playing loop
    while playing {
        var board = Board.empty
        var player = Player.x

        // Main game loop
        while !board.isStalemate {
            // Let the player choose their spot
            play(board: &board, player: player)

            // Check if the player won
            if board.isWinner(player) {
                print(board)
                print("Player \(player.icon()) won!")

                if shouldPlayAgain() {
                    // Restart the game
                    board = Board.empty
                    player = .x
                    continue
                } else {
                    playing = false 
                    break 
                }
            }

            // Update the player
            player = player.nextPlayer
        }

        // Don't check for stalemates if the user stopped playing
        guard playing else { break }

        // Stalemate reached
        print(board)
        print("Stalemate!")
        if !shouldPlayAgain() {
            break
        }
    }
}

func play(board: inout Board, player: Player) {
    let invalidMessage = "Invalid value. Try again."

    // Continue looping until the user picks a valid value
    var isValidAnswer = false 
    while !isValidAnswer {
        // Print the current board so the user can see the options
        print(board)
        print("(\(player.icon())) Pick a spot: ", terminator: "")

        let input = readLine()
        guard let input = input else { 
            print(invalidMessage)
            continue
        }

        // Ensure the input can be parsed to an Int
        guard let boardIndex = Int(input) else {
            print(invalidMessage)
            continue
        }

        // Try placing the player at that index
        let didPlay = board.place(player, at: boardIndex)
        if didPlay {
            isValidAnswer = true 
        }

        // The user picked an invalid value
        if !isValidAnswer {
            print(invalidMessage)
        }
    }
}

/// Gets input from the user on whether to play again.
/// - Returns: Whether a new game should be created.
func shouldPlayAgain() -> Bool {
    print("Play again? <y|n> ", terminator: "")
    guard let input = readLine() else { return false }
    return input.trimmingCharacters(in: .whitespaces).lowercased() == "y"
}

// Plays the game.
playGame()