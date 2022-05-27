mod player;

use crate::player::Player;

fn main() {
    println!("Hello, world!");
    let mut current_player = Player::X;
    let mut icon = current_player.icon(true);
    println!("Current player: {}", icon);

    current_player = current_player.next_player();
    icon = current_player.icon(true);
    println!("Next player: {}", icon);
    
}
