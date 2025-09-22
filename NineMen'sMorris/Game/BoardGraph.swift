import CoreGraphics
import SwiftUI

@Observable
class Vertice: Identifiable, Hashable {
    let id: Int8
    let position: CGPoint
    
    var takenBy: Player? = nil
    
    init(id: Int8, position: CGPoint, takenBy: Player? = nil) {
        self.id = id
        self.position = position
        self.takenBy = takenBy
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func ==(lhs: Vertice, rhs: Vertice) -> Bool{
        return lhs.id == rhs.id
    }
    
    func getColor() -> Color {
        switch takenBy {
        case .player1:
            return .blue
        case .player2:
            return .red
        default:
            return .black
        }
    }
    
    func placeMen(_ player: Player) {
        takenBy = player
    }
}

class Edge: Identifiable {
    let id: Int8
    let verticle1: Vertice
    let verticle2: Vertice
    let orientation: Orientation
    
    init(_ id: Int8, _ verticle1: Vertice, _ verticle2: Vertice, _ orientation: Orientation) {
        self.id = id
        self.verticle1 = verticle1
        self.verticle2 = verticle2
        self.orientation = orientation
    }
}

class BoardGraph {
    private(set) var points: [Vertice] = []
    private(set) var edges: [Edge] = []

    func getPoint(id: Int8) -> Vertice? {
        return points.first {$0.id == id}
    }
    
    func getPointNeibers(for point: Vertice, orientation: Orientation) -> Set<Vertice>{
        
        var neibers: Set<Vertice> = []
        
        var edgesFromPoint = edges.filter({$0.verticle1 == point || $0.verticle2 == point})
            .filter({$0.orientation == orientation})
        
        // Check deeper to find all neibers in a line
        if edgesFromPoint.count == 1 {
            let middlePoint: Vertice = edgesFromPoint[0].verticle1 == point ? edgesFromPoint[0].verticle2 : edgesFromPoint[0].verticle1
            
            edgesFromPoint = edges.filter({$0.verticle1 == middlePoint || $0.verticle2 == middlePoint})
                .filter({$0.orientation == orientation})
        }
        
        neibers.insert(edgesFromPoint[0].verticle1)
        neibers.insert(edgesFromPoint[0].verticle2)
        neibers.insert(edgesFromPoint[1].verticle1)
        neibers.insert(edgesFromPoint[1].verticle2)
        
        return neibers
    }
    
    init() {
        createVertice()
        createEdge()
    }
    
    private func createVertice() {
        points = [
            Vertice(id:  1, position: CGPoint(x: 100, y: 100)),
            Vertice(id:  2, position: CGPoint(x: 400, y: 100)),
            Vertice(id:  3, position: CGPoint(x: 700, y: 100)),
            Vertice(id:  4, position: CGPoint(x: 200, y: 200)),
            Vertice(id:  5, position: CGPoint(x: 400, y: 200)),
            Vertice(id:  6, position: CGPoint(x: 600, y: 200)),
            Vertice(id:  7, position: CGPoint(x: 300, y: 300)),
            Vertice(id:  8, position: CGPoint(x: 400, y: 300)),
            Vertice(id:  9, position: CGPoint(x: 500, y: 300)),
            Vertice(id: 10, position: CGPoint(x: 100, y: 400)),
            Vertice(id: 11, position: CGPoint(x: 200, y: 400)),
            Vertice(id: 12, position: CGPoint(x: 300, y: 400)),
            Vertice(id: 13, position: CGPoint(x: 500, y: 400)),
            Vertice(id: 14, position: CGPoint(x: 600, y: 400)),
            Vertice(id: 15, position: CGPoint(x: 700, y: 400)),
            Vertice(id: 16, position: CGPoint(x: 300, y: 500)),
            Vertice(id: 17, position: CGPoint(x: 400, y: 500)),
            Vertice(id: 18, position: CGPoint(x: 500, y: 500)),
            Vertice(id: 19, position: CGPoint(x: 200, y: 600)),
            Vertice(id: 20, position: CGPoint(x: 400, y: 600)),
            Vertice(id: 21, position: CGPoint(x: 600, y: 600)),
            Vertice(id: 22, position: CGPoint(x: 100, y: 700)),
            Vertice(id: 23, position: CGPoint(x: 400, y: 700)),
            Vertice(id: 24, position: CGPoint(x: 700, y: 700))
        ]
    }
    
    private func createEdge() {
        edges = [
            Edge( 1, getPoint(id:  1)!, getPoint(id:  2)!, .horizontal),
            Edge( 2, getPoint(id:  2)!, getPoint(id:  3)!, .horizontal),
            Edge( 3, getPoint(id:  4)!, getPoint(id:  5)!, .horizontal),
            Edge( 4, getPoint(id:  5)!, getPoint(id:  6)!, .horizontal),
            Edge( 5, getPoint(id:  7)!, getPoint(id:  8)!, .horizontal),
            Edge( 6, getPoint(id:  8)!, getPoint(id:  9)!, .horizontal),
            Edge( 7, getPoint(id: 10)!, getPoint(id: 11)!, .horizontal),
            Edge( 8, getPoint(id: 11)!, getPoint(id: 12)!, .horizontal),
            Edge( 9, getPoint(id: 13)!, getPoint(id: 14)!, .horizontal),
            Edge(10, getPoint(id: 14)!, getPoint(id: 15)!, .horizontal),
            Edge(11, getPoint(id: 16)!, getPoint(id: 17)!, .horizontal),
            Edge(12, getPoint(id: 17)!, getPoint(id: 18)!, .horizontal),
            Edge(13, getPoint(id: 19)!, getPoint(id: 20)!, .horizontal),
            Edge(14, getPoint(id: 20)!, getPoint(id: 21)!, .horizontal),
            Edge(15, getPoint(id: 22)!, getPoint(id: 23)!, .horizontal),
            Edge(16, getPoint(id: 23)!, getPoint(id: 24)!, .horizontal),

            Edge(17, getPoint(id:  1)!, getPoint(id: 10)!, .vertical),
            Edge(18, getPoint(id: 10)!, getPoint(id: 22)!, .vertical),
            Edge(19, getPoint(id:  4)!, getPoint(id: 11)!, .vertical),
            Edge(20, getPoint(id: 11)!, getPoint(id: 19)!, .vertical),
            Edge(21, getPoint(id:  7)!, getPoint(id: 12)!, .vertical),
            Edge(22, getPoint(id: 12)!, getPoint(id: 16)!, .vertical),
            Edge(23, getPoint(id:  2)!, getPoint(id:  5)!, .vertical),
            Edge(24, getPoint(id:  5)!, getPoint(id:  8)!, .vertical),
            Edge(25, getPoint(id: 17)!, getPoint(id: 20)!, .vertical),
            Edge(26, getPoint(id: 20)!, getPoint(id: 23)!, .vertical),
            Edge(27, getPoint(id:  9)!, getPoint(id: 13)!, .vertical),
            Edge(28, getPoint(id: 13)!, getPoint(id: 18)!, .vertical),
            Edge(29, getPoint(id:  6)!, getPoint(id: 14)!, .vertical),
            Edge(30, getPoint(id: 14)!, getPoint(id: 21)!, .vertical),
            Edge(31, getPoint(id:  3)!, getPoint(id: 15)!, .vertical),
            Edge(32, getPoint(id: 15)!, getPoint(id: 24)!, .vertical)
        ]
    }
}
