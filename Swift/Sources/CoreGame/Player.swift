/// A Tic-Tac-Toe player represented by their icon.
/// 
/// This player's `rawValue` will be represented by a `String`.
public enum Player: String {
    /// An empty spot.
    case empty = " "
    /// A spot taken by the "X" player.
    case x = "X"
    /// A spot taken by the "O" player.
    case o = "O"

    /// The player that should play next after this player.
    public var nextPlayer: Player {
        // You can use a shorthand notation for enums when the type is known.
        // In this case, Swift knows a `Player` should be returned, so you can
        // type `.x` or `.o` instead of `Player.x` and `Player.o`.
        // 
        // Also, no exlicit `return` is necessary for one-liners.
        self == .x ? .o : .x
    }

    /// Gets an icon to use for this `Player`. 
    /// 
    /// Including `colorize` will add escape codes for a colorful output when 
    /// printed on the command line.
    /// - Parameter colorize: Whether the icon should include terminal colors.
    /// - Returns: The icon to display for this player.
    public func icon(colorize: Bool = true) -> String {
        guard colorize else { return rawValue }
        let cyanEscapeCode = "\u{001b}[36m";
        let magentaEscapeCode = "\u{001b}[35m";
        let resetEscapeCode = "\u{001b}[0m";

        // Swift switches must be exhaustive or include a `default` statement.
        switch self {
            case .empty: return rawValue
            case .x: return cyanEscapeCode + rawValue + resetEscapeCode
            case .o: return magentaEscapeCode + rawValue + resetEscapeCode
        }
    }

}
