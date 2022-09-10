import XCTest
@testable import CoreGame

/// Tests aspects of the core gameplay functionality.
final class CoreGameTests: XCTestCase {

    // MARK: - Player tests

    func testPlayerRawValues() {
        XCTAssertEqual(Player.x.rawValue, "X")
        XCTAssertEqual(Player.o.rawValue, "O")
        XCTAssertEqual(Player.empty.rawValue, " ")
    }

    /// The next player after "X" should be "O".
    func testNextPlayerAfterX() {
        XCTAssertEqual(Player.x.nextPlayer, Player.o)
    }

    /// The next player after "O" should be "X".
    func testNextPlayerAfterO() {
        XCTAssertEqual(Player.x.nextPlayer, Player.o)
    }

    // MARK: - Board tests

    /// An empty board should only contain empty spaces.
    func testEmptyBoardIsEmpty() {
        XCTAssertNil(Board.empty.positions.first(where: { $0 != .empty }))
    }

    /// Placing a player on an empty index should return true. 
    func testPlacePlayerReturnsTrueWhenEmpty() {
        var board = Board.empty
        let didPlace = board.place(Player.x, at: 5)
        XCTAssertTrue(didPlace)
        XCTAssertEqual(board.positions[5], Player.x)
    }

    /// Placing a player on a non-empty index should return false.
    func testPlacePlayerReturnsFalseWhenFilled() {
        var board = Board(positions: [Player](repeating: .o, count: 9))
        let didPlace = board.place(Player.x, at: 5)
        XCTAssertFalse(didPlace)
        XCTAssertEqual(board.positions[5], Player.o)
    }

    /// An empty board should not be considered a stalemate.
    func testEmptyBoardIsNotStalemate() {
        XCTAssertFalse(Board.empty.isStalemate)
    }

    /// The default empty board size should be 3x3 for a length of 9.
    func testDefaultBoardSize() {
        XCTAssertEqual(Board.empty.positions.count, 9)
    }

    /// Out-of-bound values should return false.
    func testInBoundsReturnsFalseForInvalidValues() {
        let board = Board.empty
        XCTAssertFalse(board.inBounds(-1))
        XCTAssertFalse(board.inBounds(9))
    }

    /// In-bound values should return true.
    func testInBoundsReturnsTrueForValidValues() {
        let board = Board.empty
        XCTAssertTrue(board.inBounds(0))
        XCTAssertTrue(board.inBounds(4))
        XCTAssertTrue(board.inBounds(8))
    }

    /// A winning pattern for the correct player should return
    /// true for the winning player and false otherwise.
    func testIsWinnerReturnsTrueForCorrectWinner() {
        let pieces: [Player] = [
            .o, .x, .o,
            .x, .o, .x,
            .o, .x, .empty,
        ]

        let board = Board(positions: pieces)
        XCTAssertTrue(board.isWinner(.o))
        XCTAssertFalse(board.isWinner(.x))
    }

}
