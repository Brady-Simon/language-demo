import Player from './player';

export default class Board {
  /** The values on each of the board. */
  _board: number[];

  /**
   * Creates a board.
   * @param board The board to use.
   */
  constructor(board?: number[]) {
    this._board = board ?? Board.empty();
  }

  /**
   * Returns an empty 3x3 board.
   * @returns An empty board.
   */
  static empty(): number[] {
    return [...Array(9)].map((_) => Player.Empty.value);
  }

  /**
   * Tries to place `player` at the `index`. The value won't be placed
   * if the index is out of bounds or if a value is already present.
   * @param player The player who is choosing the `index`.
   * @param index The index on the board being selected.
   * @returns Whether or not the player was successfully placed.
   */
  place(player: Player, index: number): boolean {
    // Don't place the piece if the index is out of range.
    if (!this.inBounds(index)) {
      return false;
    }

    // Existing value must not be the default value, 0.
    const existingValue = this._board[index];
    if (existingValue != 0) {
      return false;
    }

    this._board[index] = player.value;
    return true;
  }

  /**
   * Whether or not `player` has a winning pattern.
   * @param player The potentially winning player to check.
   * @returns Whether or not the `player` has a winning combination.
   */
  isWinner(player: Player): boolean {
    // All possible winning patterns.
    const winningPatterns = [
      // Horizontal patterns
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // Vertical patterns
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // Diagonal patterns
      [0, 4, 8],
      [2, 4, 6],
    ];
    // Go through each pattern and see if the value appears.
    var wonGame = false;
    winningPatterns.forEach((pattern) => {
      const didWin = pattern.every(
        (patternValue) => this._board[patternValue] === player.value
      );
      if (didWin) wonGame = true;
    });

    return wonGame;
  }

  /** Whether or not the board has no winner and no remaining spaces. */
  get isStalemate(): boolean {
    // Still has remaining spaces to play.
    if (this._board.includes(Player.Empty.value)) {
      return false;
    }

    // Winner means the game isn't stalemated.
    if (this.isWinner(Player.X) || this.isWinner(Player.X)) {
      return false;
    }

    return true;
  }

  /**
   * Whether or not `index` is a valid index on this board.
   * @param index The index on the board.
   * @returns Whether or not `index` is a valid index in `_board`.
   */
  inBounds(index: number): boolean {
    return index >= 0 && index < this._board.length;
  }

  /**
   * Gets a string icon for the value on the board at `index`.
   * @param index The index on the board to check.
   * @returns A string representing the icon at `index`.
   */
  iconAt(index: number): string {
    return this.inBounds(index) && this._board[index] !== Player.Empty.value
      ? new Player(this._board[index]).icon()
      : index.toString();
  }

  toString() {
    // Go through each horizontal pattern on the board.
    var horizontalPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
    ];

    // Build out each line of the board.
    var lines: string[] = [];
    horizontalPatterns.forEach((pattern) => {
      // Get the patterns at their values.
      const icons = pattern.map((index) => this.iconAt(index));
      const line = icons.join(' | ');
      lines.push(line);
    });

    // Combine the lines together with newlines.
    const output = lines.join('\n');
    return output;
  }
}
