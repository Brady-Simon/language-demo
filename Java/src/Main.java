package Java.src;

import java.util.Scanner;

public class Main {

    public static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        System.out.println("Tic-Tac-Toe!");
        var playing = true;
        while (playing) {
            var board = new Board();
            var player = Player.X;

            while (!board.isStalemate()) {
                // Let the player choose their spot.
                play(board, player);

                // Check if the player won.
                if (board.isWinner(player)) {
                    System.out.println(board);
                    System.out.println("Player " + player.icon(true) + " won!");

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

            // Stalamate reached.
            System.out.println(board);
            System.out.println("Stalemate!");

            if (shouldPlayAgain()) {
                // Restart the game
                board = new Board();
                player = Player.X;
                continue;
            } else {
                playing = false;
            }
        }
        
        scanner.close();
    }

    /**
     * Lets the player choose their spot on the board.
     * @param board The board being used.
     * @param player The current player.
     */
    public static void play(Board board, Player player) {
        while (true) {
            // Print the current board so the user can see the options.
            System.out.println(board);
            System.out.print(player.icon(true) + " Pick a spot: ");

            // Get the user's input and then try placing the player there.
            int index = -1;
            
            try {
                var input = scanner.nextLine();
                index = Integer.parseInt(input);
            } catch (Exception e) {
                // Not an integer.
                System.out.println("Invalid value. Try again.");
                continue;
            }

            var didPlay = board.place(player, index);
            if (didPlay) break;
            
            // The user picked an invalid index.
            System.out.println("Invalid value. Try again.");
        }
    }

    /**
     * Gets input from the user on whether to play again.
     * @return
     */
    public static boolean shouldPlayAgain() {
        System.out.print("Play again? <y|n>: ");
        var input = scanner.nextLine();
        final boolean playAgain = input != null && input.trim().toLowerCase().equals("y");
        return playAgain;
    }
}