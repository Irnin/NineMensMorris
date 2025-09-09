import Foundation

struct GameModel {
    private(set) var gamePhase: GamePhase = .placing
    private(set) var board: BoardGraph = BoardGraph()
    
    mutating func prepareGame() {
        self.gamePhase = .placing
    }
}
