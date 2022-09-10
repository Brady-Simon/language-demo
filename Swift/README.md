## Swift

A Tic-Tac-Toe game written using Swift.

The core game logic is in a library target `CoreGame`, and the executable is in `TicTacToe` in `main.swift`.

### Requirements

Check if Swift is installed by running `swift --version`. If it isn't, then follow the setup instructions for your OS [here](https://www.swift.org/getting-started/).

**Windows information**

Windows is an officially supported target for Swift and the setup process is relatively simple. While proprietary Apple frameworks like SwiftUI aren't available on Windows or Linux, Swift can still be used for CLI applications and on the server-side.

### Setup

#### CLI 

1. `cd` into the `Swift/` directory.
2. Compile the application with `swift build`.
3. Run the app using `swift run`.
    - `swift run` will build the application as well, so step 2 is optional.

#### VS Code

1. Download the [Swift extension](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang) by the Swift Server Work Group.
    - This plugin uses the [Swift SourceKit LSP](https://github.com/apple/sourcekit-lsp) to support standard IDE features, but it's still a work-in-progress compared to other language servers you may have experienced with other technologies.
    - For example, the Swift LSP does not currently index your code in the background, so you may need to occasionally run `swift build` to update the build index to keep the index updated.
2. Run the app using the `Swift` VS Code launch action.

### Tests

Unit tests are located in `CoreGameTests.swift` and can be ran using `swift test`.

Tests can also be ran using the VS Code "Testing" window when using the Swift plugin. 

Swift requires that all unit test functions are prefixed with `test` for it to be executed.