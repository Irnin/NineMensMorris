import Foundation
import os.log

extension GameView {
    
    @Observable
    class ViewModel {
        private var game: GameModel = GameModel()
        
        private let logger = Logger(subsystem: "space.irnin.NineMen'sMorris", category: "game")
        
        func getPoints() -> [Vertice] {
            return game.board.points
        }
        
        func getEdges() -> [Edge] {
            return game.board.edges
        }
        
        func playerAction(at pointId: Int8) {
            
            switch game.gamePhase {
            case .placing:
                placeMan(at: pointId)
            case .moving:
                logger.warning("MOVING NOT IMPLEMENTED")
            }
        }
        
        func placeMan(at pointId: Int8) {
            let currentPlayer = game.currentPlayer
            logger.trace("Player \(currentPlayer.description) placed a man on point \(pointId)")
            
            let point = game.getPoint(at: pointId)
            
            if(point?.takenBy != nil) {
                logger.warning("Point \(pointId) is taken")
                return
            }
            
            game.placeMen(at: pointId, player: currentPlayer)
            game.nextPlayer()
            
            if(menLeft(player: .player1) == 0 && menLeft(player: .player2) == 0) {
                logger.info("All men placed, starting moving phase")
                game.startMovingPhase()
            }
        }
        
        func gamePhase() -> String {
            switch game.gamePhase {
                case .placing:
                    return "Placing"
                    
                case .moving:
                    return "Moving"
                }
        }
        
        func menLeft(player: Player) -> Int8 {
            return game.menLeft[player]!
        }
    }
}
