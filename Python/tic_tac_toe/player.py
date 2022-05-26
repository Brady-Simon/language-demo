from enum import Enum

_cyanEscapeCode = "\u001b[36m"
_magentaEscapeCode = "\u001b[35m"
_resetEscapeCode = "\u001b[0m"


class Player(Enum):
    """A Tic-Tac-Toe player represented by a number."""

    EMPTY = 0
    X = 1
    O = 2

    def nextPlayer(self) -> "Player":
        """Alternate between `Player.X` and `Player.O`."""
        return self.X if self == self.O else self.O

    def icon(self, colorize=True) -> str:
        """Gets an icon to use for this player.

        Including `colorize` will add escape codes for a
        colorful output when printed on the command line.
        """
        # Get the base icon to use.
        icon = " "
        if self == self.X:
            icon = "X"
        elif self == self.O:
            icon = "O"

        # Colorize the icon if possible.
        if colorize and self != self.EMPTY:
            if self == self.X:
                icon = _cyanEscapeCode + icon + _resetEscapeCode
            elif self == self.O:
                icon = _magentaEscapeCode + icon + _resetEscapeCode

        return icon


if __name__ == "__main__":
    player = Player.X
    print(player.icon())
