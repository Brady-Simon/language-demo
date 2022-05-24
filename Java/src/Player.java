package Java.src;

/**
 * A Tic-Tac-Toe player represented by a number.
 */
public enum Player {
    empty(0),
    X(1),
    O(2);

    public final int value;
    private Player(int value) { this.value = value; } 

    private final String _cyanEscapeCode = "\u001b[36m";
    private final String _magentaEscapeCode = "\u001b[35m";
    private final String _resetEscapeCode = "\u001b[0m";

    /**
     * Gets the next player to use.
     * @return Either X or O, depending on this player.
     */
    public Player nextPlayer() {
        return this == X ? O : X;
    }

    /**
     * Gets an icon to use for this [Player]. Including [colorize] will add
     *  escape codes for a colorful output when printed on the command line.
     * @param colorize Whether or not to include console coloring codes.
     * @return The icon to use for this player.
     */
    public String icon(boolean colorize) {
        // Get the base icon to use.
        String icon;
        switch (this) {
            case X:
                icon = "X";
                break;
            case O:
                icon = "O";
                break;
            default:
                icon = " ";
        }

        // Colorize the icon if possible.
        if (colorize && this != Player.empty) {
            switch (this) {
                case X:
                    icon = _cyanEscapeCode + icon + _resetEscapeCode;
                    break;
                case O:
                    icon = _magentaEscapeCode + icon + _resetEscapeCode;
                    break;
                default:
                    break;
            }
        }

        return icon;
    }
}
