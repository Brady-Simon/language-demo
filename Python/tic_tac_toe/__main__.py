from tic_tac_toe.player import Player
from tic_tac_toe.board import Board


def playGame():
    """Plays Tic-Tac-Toe."""
    print("Tic-Tac-Toe!")
    playing = True

    while playing:
        board = Board()
        player = Player.X

        # Main game loop
        while not board.is_stalemate:
            # Let the plaeyr choose their spot.
            play(board, player)

            # Check if the player won.
            if board.is_winner(player):
                print(board)
                print(f"Player {player.icon()} won!")

                if should_play_again():
                    # Restart the game
                    board = Board()
                    player = Player.X
                    continue
                else:
                    playing = False
                    break

            # Update the player at the end of the turn.
            player = player.nextPlayer()

        # Don't check for stalemates if the user stopped playing.
        if not playing:
            break

        # Stalemate reached
        print(board)
        print("Stalemate!")
        if should_play_again():
            # Restart the game
            board = Board()
            player = Player.X
            continue
        else:
            playing = False


def play(board: Board, player: Player):
    """Lets `player` choose their spot on the `board`."""
    errorMessage = "Invalid value. Pick again."
    isValidAnswer = False
    while not isValidAnswer:
        print(board)

        try:
            position = input(f"({player.icon()}) Pick a spot: ")
            index = int(position)

            if board.place(player, index):
                isValidAnswer = True
                break
            else:
                # The user picked an invalid index.
                print(errorMessage)

        except ValueError:
            # The picked value wasn't an integer.
            print(errorMessage)
            continue


def should_play_again():
    """Gets input from the user on whether to play again."""
    answer = input("Play again? <y|n>: ")
    playAgain = answer.strip().lower() == "y"
    return playAgain


if __name__ == "__main__":
    playGame()
