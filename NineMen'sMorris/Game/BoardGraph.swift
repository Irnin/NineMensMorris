import CoreGraphics
import SwiftUI

@Observable
class Vertex: Identifiable, Hashable {
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
    
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool{
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
    let vertex1: Vertex
    let vertex2: Vertex
    let orientation: Orientation
    
    
    private static func calculateOrientation(_ vertex1: Vertex,_ vertex2: Vertex) -> Orientation{
        let deltaX = vertex1.position.x - vertex2.position.x
        let deltaY = vertex1.position.y - vertex2.position.y
        let tolerance: CGFloat = 0.001
    
        if abs(deltaX) < tolerance {
            return .horizontal
        }
        
        if abs(deltaY) < tolerance {
            return .vertical
        }
        
        if (deltaX < 0 && deltaY < 0) || (deltaX > 0 && deltaY > 0) {
            return .diagonalLeftToRight
        }
        else {
            return .diagonalRightToLeft
        }
    }
    
    init(_ id: Int8, _ vertex1: Vertex, _ vertex2: Vertex, _ orientation: Orientation? = nil) {
        self.id = id
        self.vertex1 = vertex1
        self.vertex2 = vertex2
        
        self.orientation = orientation ?? Self.calculateOrientation(vertex1, vertex2)
    }
}

class BoardGraph {
    private(set) var points: [Vertex] = []
    private(set) var edges: [Edge] = []

    func getPoint(id: Int8) -> Vertex? {
        return points.first {$0.id == id}
    }
    
    func getPointNeibers(for point: Vertex, orientation: Orientation) -> Set<Vertex>{
        
        var neibers: Set<Vertex> = []
        
        var edgesFromPoint = edges.filter({$0.vertex1 == point || $0.vertex2 == point})
            .filter({$0.orientation == orientation})
        
        // Check deeper to find all neibers in a line
        if edgesFromPoint.count == 1 {
            let middlePoint: Vertex = edgesFromPoint[0].vertex1 == point ? edgesFromPoint[0].vertex2 : edgesFromPoint[0].vertex1
            
            edgesFromPoint = edges.filter({$0.vertex1 == middlePoint || $0.vertex2 == middlePoint})
                .filter({$0.orientation == orientation})
        }
        
        neibers.insert(edgesFromPoint[0].vertex1)
        neibers.insert(edgesFromPoint[0].vertex2)
        neibers.insert(edgesFromPoint[1].vertex1)
        neibers.insert(edgesFromPoint[1].vertex2)
        
        return neibers
    }
    
    func getPointNeibers(for point: Vertex) -> Set<Vertex>{
        let verticalNeibers = getPointNeibers(for: point, orientation: .vertical)
        let horizontalNeibers = getPointNeibers(for: point, orientation: .horizontal)
        
        let neibers = verticalNeibers.union(horizontalNeibers)
        
        return neibers
    }
    
    func getPointCloseNeighbors(for point: Vertex) -> Set<Vertex> {
        return Set(edges.filter { $0.vertex1 == point || $0.vertex2 == point }
                       .flatMap { [$0.vertex1, $0.vertex2] })
            .subtracting([point])
    }
    
    init() {
        createVertice()
        createEdge()
    }
    
    private func createVertice() {
        points = [
            Vertex(id:  1, position: CGPoint(x: 100, y: 100)),
            Vertex(id:  2, position: CGPoint(x: 400, y: 100)),
            Vertex(id:  3, position: CGPoint(x: 700, y: 100)),
            Vertex(id:  4, position: CGPoint(x: 200, y: 200)),
            Vertex(id:  5, position: CGPoint(x: 400, y: 200)),
            Vertex(id:  6, position: CGPoint(x: 600, y: 200)),
            Vertex(id:  7, position: CGPoint(x: 300, y: 300)),
            Vertex(id:  8, position: CGPoint(x: 400, y: 300)),
            Vertex(id:  9, position: CGPoint(x: 500, y: 300)),
            Vertex(id: 10, position: CGPoint(x: 100, y: 400)),
            Vertex(id: 11, position: CGPoint(x: 200, y: 400)),
            Vertex(id: 12, position: CGPoint(x: 300, y: 400)),
            Vertex(id: 13, position: CGPoint(x: 500, y: 400)),
            Vertex(id: 14, position: CGPoint(x: 600, y: 400)),
            Vertex(id: 15, position: CGPoint(x: 700, y: 400)),
            Vertex(id: 16, position: CGPoint(x: 300, y: 500)),
            Vertex(id: 17, position: CGPoint(x: 400, y: 500)),
            Vertex(id: 18, position: CGPoint(x: 500, y: 500)),
            Vertex(id: 19, position: CGPoint(x: 200, y: 600)),
            Vertex(id: 20, position: CGPoint(x: 400, y: 600)),
            Vertex(id: 21, position: CGPoint(x: 600, y: 600)),
            Vertex(id: 22, position: CGPoint(x: 100, y: 700)),
            Vertex(id: 23, position: CGPoint(x: 400, y: 700)),
            Vertex(id: 24, position: CGPoint(x: 700, y: 700))
        ]
    }
    
    private func createEdge() {
        edges = [
            Edge( 1, getPoint(id:  1)!, getPoint(id:  2)!),
            Edge( 2, getPoint(id:  2)!, getPoint(id:  3)!),
            Edge( 3, getPoint(id:  4)!, getPoint(id:  5)!),
            Edge( 4, getPoint(id:  5)!, getPoint(id:  6)!),
            Edge( 5, getPoint(id:  7)!, getPoint(id:  8)!),
            Edge( 6, getPoint(id:  8)!, getPoint(id:  9)!),
            Edge( 7, getPoint(id: 10)!, getPoint(id: 11)!),
            Edge( 8, getPoint(id: 11)!, getPoint(id: 12)!),
            Edge( 9, getPoint(id: 13)!, getPoint(id: 14)!),
            Edge(10, getPoint(id: 14)!, getPoint(id: 15)!),
            Edge(11, getPoint(id: 16)!, getPoint(id: 17)!),
            Edge(12, getPoint(id: 17)!, getPoint(id: 18)!),
            Edge(13, getPoint(id: 19)!, getPoint(id: 20)!),
            Edge(14, getPoint(id: 20)!, getPoint(id: 21)!),
            Edge(15, getPoint(id: 22)!, getPoint(id: 23)!),
            Edge(16, getPoint(id: 23)!, getPoint(id: 24)!),

            Edge(17, getPoint(id:  1)!, getPoint(id: 10)!),
            Edge(18, getPoint(id: 10)!, getPoint(id: 22)!),
            Edge(19, getPoint(id:  4)!, getPoint(id: 11)!),
            Edge(20, getPoint(id: 11)!, getPoint(id: 19)!),
            Edge(21, getPoint(id:  7)!, getPoint(id: 12)!),
            Edge(22, getPoint(id: 12)!, getPoint(id: 16)!),
            Edge(23, getPoint(id:  2)!, getPoint(id:  5)!),
            Edge(24, getPoint(id:  5)!, getPoint(id:  8)!),
            Edge(25, getPoint(id: 17)!, getPoint(id: 20)!),
            Edge(26, getPoint(id: 20)!, getPoint(id: 23)!),
            Edge(27, getPoint(id:  9)!, getPoint(id: 13)!),
            Edge(28, getPoint(id: 13)!, getPoint(id: 18)!),
            Edge(29, getPoint(id:  6)!, getPoint(id: 14)!),
            Edge(30, getPoint(id: 14)!, getPoint(id: 21)!),
            Edge(31, getPoint(id:  3)!, getPoint(id: 15)!),
            Edge(32, getPoint(id: 15)!, getPoint(id: 24)!)
        ]
    }
}
