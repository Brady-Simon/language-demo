## Rust

A Tic-Tac-Toe game written using Rust.

### Requirements

#### Language
Check to see if Rust is installed by running `rustc --version` on the command line. If the command isn't recognized, then [download Rust](https://rustup.rs/) and try the command again.

#### Linting
If you're using VS Code, then install the [Rust analyzer extension](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer).

If you want to be able to debug and step through the program in VS Code, then you may have to install [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb).

### Setup

#### CLI 

1. `cd` into the `Rust/` directory.
// TODO: Update
2. Run the app using `python -m tic_tac_toe`.

#### VS Code

1. Run the app using the `Rust` VS Code launch action.

### Overview 

#### Terminology
Here's an overview of some Rust terminology and commands:
- crate: library or executable program
- cargo: the rust package manager
- rustc: the rust compiler

#### Project structure
Here's an overview of the folders and files in this project:
- Cargo.toml
    - A manifest file that contains metadata required by Cargo to compile the package.
    - Written using TOML format ([Tom's Obvious, Minimal Language](https://en.wikipedia.org/wiki/TOML)).
- main.rs
    - The package entrypoint.
- src/
    - The folder that contains the project source code.