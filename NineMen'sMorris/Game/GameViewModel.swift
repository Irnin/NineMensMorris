import Foundation

extension GameView {
    
    @Observable
    class ViewModel {
        private var game: GameModel = GameModel()
        
        func getBoard() -> CGPoint{
            let tmp = game.board.points[0]
            return tmp.position
        }
        
        func getPoints() -> [Vertice] {
            return game.board.points
        }
    }
}
