from typing import List
from tic_tac_toe.player import Player


class Board:

    board: List[Player]
    """The board that keeps track of the player locations."""

    def __init__(self, board=None):
        """Creates a board with an optional starting `board`.

        Defaults to a 3x3 board filled with `Player.EMPTY`.
        """
        self.board = board or self.empty()

    @classmethod
    def empty(cls) -> List[Player]:
        """Gets an empty 3x3 board."""
        return [Player.EMPTY] * 9

    @property
    def is_stalemate(self) -> bool:
        """Whether or not the board has no winner and no remaining spaces."""
        # Still has remaining spaces to play.
        if Player.EMPTY in self.board:
            return False

        # Winner means the game isn't in a stalemate.
        if self.is_winner(Player.X) or self.is_winner(Player.O):
            return False

        return True

    def in_bounds(self, index: int) -> bool:
        """Whether or not `index` is a valid index on the board."""
        return index in range(0, 10)

    def place(self, player: Player, index: int) -> bool:
        """Tries to place `player` at the `index`.

        Returns whether the player was placed or not.
        Cannot be placed when the index is out of bounds or
        if a value is already present at that index.
        """
        # Don't place the piece if the index is out of range.
        if not self.in_bounds(index):
            return False

        # The spot must be unoccupied.
        if self.board[index] != Player.EMPTY:
            return False

        self.board[index] = player
        return True

    def is_winner(self, player: Player) -> bool:
        """Whether or not `player` has a winning pattern."""
        # All possible winning patterns
        winningPatterns = [
            # Horizontal patterns
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            # Vertical patterns
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            # Diagonal patterns
            [0, 4, 8],
            [2, 4, 6],
        ]

        for pattern in winningPatterns:
            matchesPattern = True
            # See if the player matches all patterns.
            for index in pattern:
                if self.board[index] != player:
                    # Not a matching player; continue to next pattern
                    matchesPattern = False
                    break

            if matchesPattern:
                return True

        # The player wasn't found in any winning patterns.
        return False

    def icon_at(self, index: int) -> str:
        """Gets a string icon for the player at `index`."""
        isPlayer = self.in_bounds(index) and self.board[index] != Player.EMPTY
        return self.board[index].icon() if isPlayer else str(index)

    def __str__(self) -> str:
        # Go through each horizontal pattern on the board.
        horizontal_patterns = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
        ]

        # Build out each line of the board.
        lines: List[str] = []
        for pattern in horizontal_patterns:
            icons = [self.icon_at(index) for index in pattern]
            line = " | ".join(icons)
            lines.append(line)

        # Combine the lines together with newlines.
        output = "\n".join(lines)
        return output
