
/// A Tic-Tac-Toe player.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Player {
    Empty,
    X,
    O,
}

impl Player {
    
    /// Alternate between `Player.X` and `Player.O`.
    pub(crate) fn next_player(&self) -> Player {
        if self == &Player::X { 
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
    pub(crate) fn icon(&self, colorize: bool) -> String {
        let mut icon: String = match self {
            Player::X => String::from("X"),
            Player::O => String::from("O"),
            _ => String::from(" "),
        };

        if colorize && self != &Player::Empty {
            const CYAN_ESCAPE_CODE: &str = "\u{001b}[36m";
            const MAGENTA_ESCAPE_CODE: &str = "\u{001b}[35m";
            const RESET_ESCAPE_CODE: &str = "\u{001b}[0m";

            icon = match self {
                Player::X => CYAN_ESCAPE_CODE.to_string() + icon.as_str() + RESET_ESCAPE_CODE,
                Player::O => MAGENTA_ESCAPE_CODE.to_string() + icon.as_str() + RESET_ESCAPE_CODE,
                _ => icon,
            }
        }

        return icon;
    }
}