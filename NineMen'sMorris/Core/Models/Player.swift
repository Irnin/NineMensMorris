import Foundation

enum Player{
    case player1
    case player2
    
    var description: String {
        switch self {
        case .player1: return "player1"
        case .player2: return "player2"
        }
    }
}
