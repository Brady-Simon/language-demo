
public class Board
{
    /// <summary>
    /// The values on each of the board.
    /// </summary>
    private Player[] _board;

    public Board(Player[]? board = null)
    {
        _board = board ?? Empty();
    }

    /// <summary>
    /// Returns an empty 3x3 board.
    /// </summary>
    public static Player[] Empty() 
    {
        return new Player[9];
    }

    /// <summary>
    /// Tries to place <paramref name="player"/> at the <paramref name="index"/>.
    /// The value won't be placed if the index is out of bounds
    /// or if a non-default value is already present at that index.
    /// </summary>
    /// <param name="player">The player to place on the board.</param>
    /// <param name="index">The index on the board to place the value.</param>
    /// <returns>True if the value was placed, and false otherwise.</returns>
    public bool Place(Player player, int index)
    {
        // Don't place the piece if the index is out of range.
        if (index < 0 || index >= _board.Length)
        {
            return false;
        }

        // Existing value must not be the default value, 0.
        var existingValue = _board[index];
        if (existingValue != 0)
        {
            return false;
        }

        _board[index] = player;
        return true;
    }

    /// <summary>
    /// Whether or not <paramref name="value"/> matches a winning pattern.
    /// </summary>
    /// <param name="value">The potentially winning value to check.</param>
    /// <returns>Whether or not the value has a winning combination.</returns>
    public bool IsWinner(Player player)
    {
        // All possible winning patterns.
        var winningPatterns = new[]
        {
            // Horizontal patterns
            new[] { 0, 1, 2 },
            new[] { 3, 4, 5 },
            new[] { 6, 7, 8 },
            // Vertical patterns
            new[] { 0, 3, 6 },
            new[] { 1, 4, 7 },
            new[] { 2, 5, 8 },
            // Diagonal patterns
            new[] { 0, 4, 8 },
            new[] { 2, 4, 6 },
        };

        // Go through each pattern and see if the value appears.
        foreach (var pattern in winningPatterns)
        {
            var didWin = pattern.All(patternValue => _board[patternValue] == player);
            if (didWin)
            { 
                return true; 
            }
        }

        // The value wasn't found in any winning patterns.
        return false;
    }

    /// <summary>
    /// Whether or not the board has no winner and no remaining spaces.
    /// </summary>
    public bool IsStalemate 
    { 
        get 
        {
            // Still has remaining spaces to play.
            if (_board.Contains(Player.Empty))
            {
                return false;
            }

            // Winner means the game isn't stalemated.
            if (IsWinner(Player.X) || IsWinner(Player.X))
            {
                return false;
            }

            return true;
        }
    }

    public bool InBounds(int index)
    {
        return index >= 0 && index < _board.Length;
    }

    public string IconAt(int index)
    {
        return InBounds(index) &&  _board[index] != Player.Empty
            ? _board[index].Icon()
            : index.ToString();
    }

    public override string? ToString()
    {
        // Go through each horizontal pattern on the board.
        var horizontalPatterns = new[]
        {
            new[] { 0, 1, 2 },
            new[] { 3, 4, 5 },
            new[] { 6, 7, 8 },
        };

        // Build out each line of the board.
        var lines = new List<string>();
        foreach (var pattern in horizontalPatterns)
        {
            // Get the patterns at their values.
            var icons = pattern.Select(index => IconAt(index));
            var line = string.Join(" | ", icons);
            lines.Add(line);
        }

        // Combine the lines together with newlines.
        var output = String.Join("\n", lines);
        return output;
    }
}