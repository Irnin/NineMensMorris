import Foundation


struct GameModel {
    private(set) var gamePhase: GamePhase = .placing
    private(set) var board: BoardGraph = BoardGraph()
    private(set) var currentPlayer: Player = .player1
    
    private(set) var menLeft : [Player: Int8] = [.player1: 9, .player2: 9]
    
    mutating func prepareGame() {
        self.gamePhase = .placing
    }
    
    func getPoint(at pointId: Int8) -> Vertice? {
        return board.points.first(where: {$0.id == pointId})
    }
    
    mutating func placeMen(at pointId: Int8, player: Player) {
        guard let point = self.getPoint(at: pointId) else {
            return
        }
        
        point.placeMen(player)
        menLeft[currentPlayer]! -= 1
    }
    
    mutating func nextPlayer() {
        self.currentPlayer = (self.currentPlayer == .player1) ? .player2 : .player1
    }
    
    mutating func startMovingPhase() {
        gamePhase = .moving
    }
}
