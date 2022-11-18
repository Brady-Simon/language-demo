/// A Tic-Tac-Toe player.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Player {
    Empty,
    X,
    O,
}

// Some constants for colorizing player icons.
const CYAN_ESCAPE_CODE: &str = "\u{001b}[36m";
const MAGENTA_ESCAPE_CODE: &str = "\u{001b}[35m";
const RESET_ESCAPE_CODE: &str = "\u{001b}[0m";

impl Player {
    /// Alternate between `Player.X` and `Player.O`.
    pub fn next_player(&self) -> Player {
        if *self == Player::X {
            Player::O
        } else {
            Player::X
        }
    }

    /// Gets an icon to use for this [Player]. Including `colorize` will add
    /// escape codes for a colorful output when printed on the command line.
    ///
    /// ### Arguments
    /// * `colorize` - Whether or not to colorize the icon for the terminal.
    pub fn icon(&self, colorize: bool) -> String {
        let icon: String = match self {
            Player::X => String::from("X"),
            Player::O => String::from("O"),
            _ => String::from(" "),
        };

        if colorize && *self != Player::Empty {
            return match self {
                Player::X => CYAN_ESCAPE_CODE.to_string() + icon.as_str() + RESET_ESCAPE_CODE,
                Player::O => MAGENTA_ESCAPE_CODE.to_string() + icon.as_str() + RESET_ESCAPE_CODE,
                _ => icon,
            };
        }

        icon
    }
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn next_player() {
        assert_eq!(Player::X.next_player(), Player::O);
        assert_eq!(Player::O.next_player(), Player::X);
        assert_eq!(Player::Empty.next_player(), Player::X);
    }

    #[test]
    fn icon() {
        assert_eq!(Player::X.icon(false), "X");
        assert_eq!(Player::O.icon(false), "O");
        assert_eq!(Player::Empty.icon(false), " ");
    }

    #[test]
    fn colorized_x_icon_is_cyan() {
        assert!(Player::X.icon(true).starts_with(CYAN_ESCAPE_CODE));
        assert!(Player::X.icon(true).ends_with(RESET_ESCAPE_CODE));
    }

    #[test]
    fn colorized_o_icon_is_magenta() {
        assert!(Player::O.icon(true).starts_with(MAGENTA_ESCAPE_CODE));
        assert!(Player::O.icon(true).ends_with(RESET_ESCAPE_CODE));
    }
}
