export default class Player {
  /** This player's board value. */
  value;

  /**
   * Creates a player with `value`.
   * @param {number} value This player's numerical value.
   */
  constructor(value) {
    this.value = value;
  }

  static Empty = new Player(0);
  static X = new Player(1);
  static O = new Player(2);

  /**
   * Gets the next player to move after this player.
   * @returns {Player} The next player.
   */
  nextPlayer() {
    return this.value === Player.X.value ? Player.O : Player.X;
  }

  /**
   * Gets the icon to use for this player in a terminal window.
   * @param {boolean} colorize Whether or not to colorize the icon.
   * @returns {string} This player's icon.
   */
  icon(colorize = true) {
    // Get the base icon to use.
    var icon;
    switch (this.value) {
      case Player.X.value:
        icon = 'X';
        break;
      case Player.O.value:
        icon = 'O';
        break;
      default:
        icon = ' ';
    }

    // Colorize the icon if possible.
    if (colorize && this.value != Player.Empty.value) {
      var code;
      switch (this.value) {
        case Player.X.value:
          code = cyanEscapeCode;
          break;
        case Player.O.value:
          code = magentaEscapeCode;
          break;
      }

      // Colorize using the proper code.
      if (code) {
        icon = [code, icon, resetEscapeCode].join('');
      }
    }

    return icon;
  }
}

// Escape codes for terminal colorization.
const cyanEscapeCode = '\u001b[36m';
const magentaEscapeCode = '\u001b[35m';
const resetEscapeCode = '\u001b[0m';
