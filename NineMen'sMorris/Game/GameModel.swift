import Foundation
import os.log

struct GameModel {
    private(set) var gamePhase: GamePhase
    private(set) var variant: GameVariant
    private(set) var attackActive: Bool
    private(set) var board: BoardGraph
    private(set) var currentPlayer: Player
    private(set) var selectedPoint: Vertex?
    
    private(set) var menLeft : [Player: Int8] = [:]
    private(set) var menOnBoard : [Player: Int8] = [:]
    
    private let logger = Logger(subsystem: "space.irnin.NineMen'sMorris", category: "game")
    
    init(forVariant variant: GameVariant = .NineMensMorris) {
        
        self.variant = variant
        gamePhase = .placing
        attackActive = false
        currentPlayer = .player1
        selectedPoint = nil
        
        board = BoardGraph(variant.rawValue)
        
        menLeft[.player1] = variant.rawValue
        menLeft[.player2] = variant.rawValue
        menOnBoard[.player1] = 0
        menOnBoard[.player2] = 0
    }
    
    func getPoint(at pointId: Int8) -> Vertex? {
        return board.points.first(where: {$0.id == pointId})
    }
    
    mutating func placeMen(at pointId: Int8, player: Player) {
        guard let point = self.getPoint(at: pointId) else {
            return
        }
        
        point.placeMen(player)
        menLeft[currentPlayer]! -= 1
        menOnBoard[currentPlayer]! += 1
    }
    
    func isThereWinner() -> Player? {
        if menOnBoard[.player1] == 2 {
            return .player2
        }
        else if menOnBoard[.player2] == 2 {
            return .player1
        }
        
        return nil
    }
    
    func isMill(at pointId: Int8) -> Bool {
        let horizontalCheck = isMill(at: pointId, orintation: .horizontal)
        let verticalCheck = isMill(at: pointId, orintation: .vertical)
        let diagonalLeftToRightCheck = isMill(at: pointId, orintation: .diagonalLeftToRight)
        let diagonalRightToLeftCheck = isMill(at: pointId, orintation: .diagonalRightToLeft)
        
        return horizontalCheck || verticalCheck || diagonalLeftToRightCheck || diagonalRightToLeftCheck
    }
    
    func isMill(at pointId: Int8, orintation: Orientation) -> Bool {
        guard let point = self.getPoint(at: pointId) else {
            return false
        }
        
        let neibers = board.getPointNeibers(for: point, orientation: orintation)
        
        var counter: Int8 = 0
        
        for neiber in neibers {
            if neiber.takenBy == point.takenBy {
                counter += 1
            }
        }
        
        return counter == 3 ? true : false
    }
    
    mutating func allowAttack() {
        attackActive = true
    }
    
    mutating func attack(at pointId: Int8) {
        guard let point = self.getPoint(at: pointId) else {
            return
        }
        
        let attackedPlayer = point.takenBy!
        menOnBoard[attackedPlayer]! -= 1
        
        point.takenBy = nil
        attackActive = false
    }
    
    mutating func selectPoint(at pointId: Int8) {
        guard let point = self.getPoint(at: pointId) else {
            return
        }
        
        // Alows to move only player's men
        if point.takenBy != currentPlayer {
            return
        }
        
        selectedPoint = point
    }
    
    mutating func move(at pointId: Int8) -> Bool{
        
        // Taking points
        guard let toPoint = self.getPoint(at: pointId) else {
            return false
        }
        
        guard let fromPoint = selectedPoint else {
            return false
        }
    
        // Checkin is it a possible move
        let availablePoints = board.getPointCloseNeighbors(for: fromPoint)
        
        if !availablePoints.contains(toPoint) || toPoint.takenBy != nil{
            logger.warning("Can not move to \(pointId)")
            return false
        }
        
        // Actual actions
        fromPoint.takenBy = nil
        selectedPoint = nil
        
        toPoint.takenBy = currentPlayer
        return true
    }
    
    mutating func nextPlayer() {
        self.currentPlayer = (self.currentPlayer == .player1) ? .player2 : .player1
    }
    
    mutating func startMovingPhase() {
        gamePhase = .moving
    }
}
