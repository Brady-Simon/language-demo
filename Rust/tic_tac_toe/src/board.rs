use std::fmt::Display;

use crate::player::Player;

pub struct Board {
    /// Keeps track of player positions.
    board: [Player; 9],
}

impl Board {
    /// Creates an empty 3x3 board.
    pub fn new() -> Board {
        Board {
            board: [Player::Empty; 9],
        }
    }

    /// Whether or not this board is in a stalemate state.
    pub fn is_stalemate(&self) -> bool {
        // Still has remaining spaces to play
        if self.board.contains(&Player::Empty) {
            return false;
        }

        // Winner means the game isn't in a stalemate.
        if self.is_winner(Player::X) || self.is_winner(Player::O) {
            return false;
        }

        true
    }

    /// Tries to place `player` at the `index` and returns if player was placed.
    /// Cannot be placed when the index is out of bounds or if a value is
    /// already present.
    pub fn place(&mut self, player: Player, index: usize) -> bool {
        // Don't place the piece if the index is out of range.
        if !self.in_bounds(index) {
            return false;
        }

        // Must be an empty spot to place.
        if let Some(existing_player) = self.board.get(index) {
            if *existing_player != Player::Empty {
                return false;
            }
        }

        // Place the player and return true.
        self.board[index] = player;
        true
    }

    /// Whether or not `index` is a valid index on this board.
    pub fn in_bounds(&self, index: usize) -> bool {
        index < self.board.len()
    }

    /// Whether or not `player` has a winning pattern.
    pub fn is_winner(&self, player: Player) -> bool {
        let winning_patterns = [
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

        for pattern in winning_patterns {
            let mut matches_pattern = true;
            // See if the player matches all of the pattern.
            for index in pattern {
                if self.board[index] != player {
                    matches_pattern = false;
                }
            }

            if matches_pattern {
                return true;
            }
        }

        // The player wasn't found in any winning patterns.
        false
    }

    /// Gets a string icon for the value on the board at `index`.
    pub fn icon_at(&self, index: usize) -> String {
        if self.in_bounds(index) && self.board[index] != Player::Empty {
            self.board[index].icon(true)
        } else {
            index.to_string()
        }
    }
}

// Allows printing the board like `println!("{board}")`
impl Display for Board {
    /// Returns a string illustrating the current board state.
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        // Go through each horizontal pattern on the board.
        let horizontal_patterns = [[0, 1, 2], [3, 4, 5], [6, 7, 8]];

        // Build out each line on the board.
        let mut lines: Vec<String> = Vec::new();
        for pattern in horizontal_patterns {
            // Get the values in each pattern
            let icons = pattern.map(|index| self.icon_at(index));
            let line = icons.join(" | ");
            lines.push(line);
        }

        // Combine the lines together with newlines.
        let output = lines.join("\n");
        write!(f, "{output}")
    }
}
