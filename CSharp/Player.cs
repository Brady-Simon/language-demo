
/// A Tic-Tac-Toe player represented by a number.
public enum Player 
{
    Empty = 0,
    X = 1,
    O = 2,
}

public static class PlayerExtension
{
    /// <summary>Gets the next player to use.</summary>
    public static Player NextPlayer(this Player player)
    {
        return player switch 
        {
            Player.Empty => Player.X,
            Player.X => Player.O,
            Player.O => Player.X,
            // Default value
            _ => Player.X,
        };
    }

    public static string Icon(this Player player)
    {
        switch (player)
        {
            case Player.Empty: return " ";
            case Player.X: return "X";
            case Player.O: return "O";
            // Default value
            default: return " ";
        }
    }
}