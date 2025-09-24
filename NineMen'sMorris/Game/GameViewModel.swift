import Foundation
import os.log

extension GameView {
    
    @Observable
    class ViewModel {
        private var game: GameModel = GameModel()
        
        private let logger = Logger(subsystem: "space.irnin.NineMen'sMorris", category: "game")
        
        func playerAction(at pointId: Int8) {
            
            if(game.attackActive) {
                attackMan(at: pointId)
                
                // Checking was it a final place action
                startMovingPhaseIfPossible()
                return
            }
            
            switch game.gamePhase {
            case .placing:
                placeMan(at: pointId)
            case .moving:
                logger.warning("MOVING NOT IMPLEMENTED")
            }
        }
        
        func placeMan(at pointId: Int8) {
            let currentPlayer = game.currentPlayer
            let currentPlayerName = currentPlayer.description
            logger.trace("Player \(currentPlayerName) placed a man on point \(pointId)")
            
            let point = game.getPoint(at: pointId)
            
            // Prevent from placing a man on a occupated point
            if(point?.takenBy != nil) {
                logger.warning("Point \(pointId) is taken")
                return
            }
            
            // Placing a man on the board
            game.placeMen(at: pointId, player: currentPlayer)
            
            // Checking mill
            if(game.isMill(at: pointId)) {
                logger.info("Player \(currentPlayerName) formed a mill")
                game.allowAttack()
                return
            }
            
            game.nextPlayer()
            startMovingPhaseIfPossible()
        }
        
        func startMovingPhaseIfPossible() {
            if(game.gamePhase != .placing) {
                return
            }
            
            if(menLeft(player: .player1) == 0 && menLeft(player: .player2) == 0) {
                logger.info("All men placed, starting moving phase")
                game.startMovingPhase()
            }
        }
        
        func attackMan(at pointId: Int8) {
            let currentPlayer = game.currentPlayer
            let currentPlayerName = currentPlayer.description
            logger.trace("Player \(currentPlayerName) is attacking at \(pointId)")
            
            let point = game.getPoint(at: pointId)
            
            // Prevent from placing a man on a occupated point
            if(point?.takenBy == currentPlayer) {
                logger.warning("Can not remove your own man")
                return
            }
            
            // Check is this point a mill formation
            if(game.isMill(at: pointId)) {
                logger.warning("Can not remove point that is part of a mill")
               return
            }
            
            // Actual attack
            game.attack(at: pointId)
            game.nextPlayer()
        }
        
        func gamePhase() -> String {
            switch game.gamePhase {
                case .placing:
                    return "Placing"
                    
                case .moving:
                    return "Moving"
                }
        }
        
        func getPoints() -> [Vertice] {
            return game.board.points
        }
        
        func getEdges() -> [Edge] {
            return game.board.edges
        }
        
        func menLeft(player: Player) -> Int8 {
            return game.menLeft[player]!
        }
        
        func canAttack() -> Bool {
            return game.attackActive
        }
    }
}
