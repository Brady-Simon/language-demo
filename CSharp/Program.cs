// See https://aka.ms/new-console-template for more information
Console.WriteLine("Tic-Tac-Toe!");

var playing = true;
while (playing) 
{
    var board = new Board();
    var player = Player.X;

    while (!board.IsStalemate)
    {
        // Let the player choose their spot.
        Play(board, player);

        // Check if the player won.
        if (board.IsWinner(player))
        {
            Console.WriteLine(board);
            Console.WriteLine($"Player {player.Icon()} won!");

            if (ShouldPlayAgain())
            {
                // Restart the game
                board = new Board();
                player = Player.X;
                continue;
            }
            else 
            {
                playing = false;
                break;
            }
        }

        // Update the player.
        player = player.NextPlayer();
    }

    // Stalemate reached.
    Console.WriteLine(board);
    Console.WriteLine("Stalemate!");
    if (ShouldPlayAgain())
    {
        // Restart the game
        board = new Board();
        player = Player.X;
        continue;
    }
    else 
    {
        playing = false;
        break;
    }
}

/// <summary>
/// Lets <paramref name="player"/> choose 
/// their spot on the <paramref name="board"/>.
/// </summary>
void Play(Board board, Player player)
{
    // Continue looping until the user picks a valid value.
    while (true)
    {
        // Print the current board so the user can see the options.
        Console.WriteLine(board);
        Console.WriteLine($"({player.Icon()}) Pick a spot: ");

        // Get the user's input and then try placing the player there.
        var input = Console.ReadLine();
        var isNumber = int.TryParse(input, out int boardIndex);
        if (isNumber)
        {
            var didPlay = board.Place(player, boardIndex);
            if (didPlay) break;
        }
        
        // The user picked an invalid value.
        Console.WriteLine("Invalid value. Try again.");
    }
} 

/// <summary>
/// Gets input from the user on whether to play again.
/// </summary>
bool ShouldPlayAgain()
{
    Console.Write("Play again? <y|n>: ");
    var input = Console.ReadLine();
    return !(input is null) && input.Trim().ToLower() == "y";
}
