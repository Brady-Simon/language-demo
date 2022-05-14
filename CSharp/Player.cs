
/// A Tic-Tac-Toe player represented by a number.
public enum Player 
{
    Empty = 0,
    X = 1,
    O = 2,
}

public static class PlayerExtension
{
    public const string CyanEscapeCode = "\u001b[36m";
    public const string MagentaEscapeCode = "\u001b[35m";
    public const string ResetEscapeCode = "\u001b[0m";

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

    public static string Icon(this Player player, bool colorize = true)
    {
        var icon = player switch 
        {
            Player.Empty => " ",
            Player.X => "X",
            Player.O => "O",
            // Default value
            _ => " ",
        };

        // Colorize the output if possible.
        if (colorize && player != Player.Empty)
        {
            return player switch 
            {
                Player.X => String.Join("", CyanEscapeCode, icon, ResetEscapeCode),
                Player.O => String.Join("", MagentaEscapeCode, icon, ResetEscapeCode),
                _ => icon,
            };
        }

        return icon;
    }
}