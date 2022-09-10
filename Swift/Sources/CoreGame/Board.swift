/// A TicTacToe board.
public struct Board {
    /// The positions on the board.
    var positions: [Player]

    public init(positions: [Player]) {
        self.positions = positions
    }

    /// The default empty 3x3 board.
    /// 
    /// No return statement is necessary for single-line functions or computed properties.
    public static var empty: Board {
        Board(positions: [Player](repeating: Player.empty, count: 9))
    }

    /// Whether or not the board has no winner and no remaining spaces.
    public var isStalemate: Bool {
        // Still has remaining spaces to play.
        if positions.contains(Player.empty) {
            return false 
        }

        // Winner means the game isn't in a stalemate.
        if isWinner(Player.x) || isWinner(Player.o) {
            return false
        }

        return true
    }

    /// Tries to place the `player` at the `index` and returns if the player was placed.
    /// 
    /// Because `Board` is a struct, this function is marked as `mutating`.
    /// This wouldn't be necessary if `Board` was declared as a `class`,
    /// which would make it pass-by-reference instead of pass-by-value.
    /// - Parameters:
    ///   - player: The player to place at the `index`.
    ///   - index: The index on the board to place the `player`.
    /// - Returns: Whether the `player` was placed on the board.
    public mutating func place(_ player: Player, at index: Int) -> Bool {
        // Don't place the player if the index is out of range.
        guard inBounds(index) else { return false }

        // Existing value must be empty.
        guard positions[index] == .empty else { return false }

        // Place the player
        positions[index] = player
        return true
    }

    /// Whether the `index` is in bounds of the board.
    /// - Parameter index: The index on the board to check.
    /// - Returns: Whether the index falls within the indices of `positions`.
    public func inBounds(_ index: Int) -> Bool {
        positions.indices.contains(index)
    }

    public func isWinner(_ player: Player) -> Bool {
        // All possible winning patterns.
        let winningPatterns = [
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

        var wonGame = false 
        for pattern in winningPatterns {
            let didWin = pattern.allSatisfy { index in 
                positions[index] == player
            }
            if didWin {
                wonGame = true
            }
        }

        return wonGame
    }

    /// Gets the icon on the board at `index`.
    /// - Parameter index: The index on the board to get.
    /// - Returns: The icon that represents the value at the `index`.
    public func iconAt(index: Int) -> String {
        inBounds(index) && positions[index] != .empty
            ? positions[index].icon()
            : String(index)
    }
}

// An extension that makes the board easily printable using `print`.
extension Board: CustomStringConvertible {
    public var description: String {
        // Go through each horizontal pattern on the board.
        let horizontalPatterns = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
        ];

        var lines = [String]()
        for pattern in horizontalPatterns {
            // Get the patterns at their values
            let icons = pattern.map(iconAt(index:))
            let line = icons.joined(separator: " | ")
            lines.append(line)
        }

        // Combine the lines together with newlines
        return lines.joined(separator: "\n")
    }
}
