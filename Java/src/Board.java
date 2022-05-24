package Java.src;

import java.util.ArrayList;
import java.util.List;

public class Board {
    
    /** The values on each of the board. */
    private List<Player> board;

    public Board() {
        this.board = empty();
    }

    public Board(List<Player> board) {
        this.board = board;
    }

    /**
     * Returns an empty 3x3 board.
     * @return
     */
    public static ArrayList<Player> empty() {
        var list = new ArrayList<Player>();
        for (int i = 0; i < 9; i++) {
            list.add(Player.empty);
        }
        return list;
    }

    /**
     * Tries to place the player at the index. The value won't be placed if
     * the index is out of bounds or if a non-empty value is already present.
     * @param player The player to place on the board.
     * @param index The index on the obard to place the value.
     * @return Whether or not the value was placed.
     */
    public boolean place(Player player, int index) {
        // Don't place the piece if the index is out of range.
        if (index < 0 || index >= board.size()) {
            return false;
        }

        // Existing value must not be the default value, 0.
        var existingValue = board.get(index);
        if (existingValue != Player.empty) {
            return false;
        }

        board.set(index, player);
        return true;
    }

    /**
     * Whether or not the player has a winning pattern.
     * @param player The potentially winning player.
     * @return Whether or not the player has a winning combination.
     */
    public boolean isWinner(Player player) {
        // All possible winning patterns.
        var winningPatterns = new int[][] {
            // Horizontal patterns
            new int[] { 0, 1, 2 },
            new int[] { 3, 4, 5 },
            new int[] { 6, 7, 8 },
            // Vertical patterns
            new int[] { 0, 3, 6 },
            new int[] { 1, 4, 7 },
            new int[] { 2, 5, 8 },
            // Diagonal patterns
            new int[] { 0, 4, 8 },
            new int[] { 2, 4, 6 },
        };

        for (var pattern : winningPatterns) {
            var matchesPattern = true;
            for (var index : pattern) {
                if (board.get(index) != player) {
                    // Not a matching player; continue to next pattern.
                    matchesPattern = false;
                }
            }
            // Player matched all patterns; return true
            if (matchesPattern) {
                return true;
            }
        }

        // The value wasn't found in any winning patterns.
        return false;
    }

    /**
     * Whether or not the board has no winner and no remaining spaces.
     * @return True if there are no more possible moves with no winners.
     */
    public boolean isStalemate() {
        // Still has remaining spaces to play.
        if (board.contains(Player.empty)) {
            return false;
        }

        // Winner means the game isn't in a stalemate.
        if (isWinner(Player.X) || isWinner(Player.O)) {
            return false;
        }

        return true;
    }

    public boolean inBounds(int index) {
        return index >= 0 && index < board.size();
    } 

    public String iconAt(int index) {
        return inBounds(index) && board.get(index) != Player.empty
            ? board.get(index).icon(true)
            : "" + index;
    }

    @Override
    public String toString() {
        // Go through each horizontal pattern on the board.
        var horizontalPatterns = new int[][]
        {
            new int[] { 0, 1, 2 },
            new int[] { 3, 4, 5 },
            new int[] { 6, 7, 8 },
        };

        // Build out each line of the board.
        var lines = new ArrayList<String>();
        for (var pattern : horizontalPatterns)
        {
            // Get the patterns at their values.
            var line = "";
            final String separator = " | ";
            for (var index : pattern) {
                line += iconAt(index);
                if (index != pattern[pattern.length - 1]) {
                    line += separator;
                }
            }
            lines.add(line);
        }

        // Combine the lines together with newlines.
        var output = "";
        for (var line : lines) {
            output += line;
            if (line != lines.get(lines.size() - 1)) {
                output += "\n";
            }
        }

        return output;
    }
}
