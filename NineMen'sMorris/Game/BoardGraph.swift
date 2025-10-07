import CoreGraphics
import SwiftUI

@Observable
class Vertex: Identifiable, Hashable {
    let id: Int8
    let positionX: Int8
    let positionY: Int8
    
    var takenBy: Player? = nil
    
    init(id: Int8, positionX: Int8, positionY: Int8, takenBy: Player? = nil) {
        self.id = id
        self.positionX = positionX
        self.positionY = positionY
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

class  Edge: Identifiable {
    let id: Int8
    let vertex1: Vertex
    let vertex2: Vertex
    let orientation: Orientation
    
    /// Method is used to determine the orientation of the edge.
    private static func calculateOrientation(_ vertex1: Vertex,_ vertex2: Vertex) -> Orientation{
        let deltaX = Float(vertex1.positionX - vertex2.positionX)
        let deltaY = Float(vertex1.positionY - vertex2.positionY)
    
        if deltaX == 0 {
            return .horizontal
        }
        
        if deltaY == 0 {
            return .vertical
        }
        
        if (deltaX < 0 && deltaY < 0) || (deltaX > 0 && deltaY > 0) {
            return .diagonalRightToLeft
        }
        else {
            return .diagonalLeftToRight
        }
    }
    
    init(_ id: Int8, _ vertex1: Vertex, _ vertex2: Vertex, _ orientation: Orientation? = nil) {
        self.id = id
        self.vertex1 = vertex1
        self.vertex2 = vertex2
        
        self.orientation = orientation ?? Self.calculateOrientation(vertex1, vertex2)
    }
}

@Observable
class BoardGraph {
    private(set) var points: [Vertex] = []
    private(set) var edges: [Edge] = []
    
    private(set) var vertexBorder: Int8 = 0

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
        
        // neibers can not exist in case vertex has no nerber in selected orientation
        if edgesFromPoint.count == 0 {
            return neibers
        }
        
        neibers.insert(edgesFromPoint[0].vertex1)
        neibers.insert(edgesFromPoint[0].vertex2)
        neibers.insert(edgesFromPoint[1].vertex1)
        neibers.insert(edgesFromPoint[1].vertex2)
        
        return neibers
    }
    
    func getPointCloseNeighbors(for point: Vertex) -> Set<Vertex> {
        let result = Set(edges.filter { $0.vertex1 == point || $0.vertex2 == point }
                        .flatMap { [$0.vertex1, $0.vertex2] })
                        .subtracting([point])
        
        return result
    }
    
    init(_ i: Int8 = 9) {
        
        switch(i) {
        case 9:
            create9mensBoard()
        case 3:
            create3mensBoard()
        default:
            fatalError("Not implemented")
        }
    }
    
    private func create9mensBoard() {
        self.vertexBorder = 8
        
        points = [
            Vertex(id:  1, positionX: 1, positionY: 1),
            Vertex(id:  2, positionX: 4, positionY: 1),
            Vertex(id:  3, positionX: 7, positionY: 1),
            Vertex(id:  4, positionX: 2, positionY: 2),
            Vertex(id:  5, positionX: 4, positionY: 2),
            Vertex(id:  6, positionX: 6, positionY: 2),
            Vertex(id:  7, positionX: 3, positionY: 3),
            Vertex(id:  8, positionX: 4, positionY: 3),
            Vertex(id:  9, positionX: 5, positionY: 3),
            Vertex(id: 10, positionX: 1, positionY: 4),
            Vertex(id: 11, positionX: 2, positionY: 4),
            Vertex(id: 12, positionX: 3, positionY: 4),
            Vertex(id: 13, positionX: 5, positionY: 4),
            Vertex(id: 14, positionX: 6, positionY: 4),
            Vertex(id: 15, positionX: 7, positionY: 4),
            Vertex(id: 16, positionX: 3, positionY: 5),
            Vertex(id: 17, positionX: 4, positionY: 5),
            Vertex(id: 18, positionX: 5, positionY: 5),
            Vertex(id: 19, positionX: 2, positionY: 6),
            Vertex(id: 20, positionX: 4, positionY: 6),
            Vertex(id: 21, positionX: 6, positionY: 6),
            Vertex(id: 22, positionX: 1, positionY: 7),
            Vertex(id: 23, positionX: 4, positionY: 7),
            Vertex(id: 24, positionX: 7, positionY: 7)
        ]
        
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
    
    private func create3mensBoard() {
        self.vertexBorder = 4
        
        points = [
            Vertex(id:  1, positionX: 1, positionY: 1),
            Vertex(id:  2, positionX: 2, positionY: 1),
            Vertex(id:  3, positionX: 3, positionY: 1),
            Vertex(id:  4, positionX: 1, positionY: 2),
            Vertex(id:  5, positionX: 2, positionY: 2),
            Vertex(id:  6, positionX: 3, positionY: 2),
            Vertex(id:  7, positionX: 1, positionY: 3),
            Vertex(id:  8, positionX: 2, positionY: 3),
            Vertex(id:  9, positionX: 3, positionY: 3),
        ]
        
        edges = [
            Edge( 1, getPoint(id:  1)!, getPoint(id:  2)!),
            Edge( 2, getPoint(id:  2)!, getPoint(id:  3)!),
            Edge( 3, getPoint(id:  4)!, getPoint(id:  5)!),
            Edge( 4, getPoint(id:  5)!, getPoint(id:  6)!),
            Edge( 5, getPoint(id:  7)!, getPoint(id:  8)!),
            Edge( 6, getPoint(id:  8)!, getPoint(id:  9)!),
            
            Edge( 7, getPoint(id: 1)!, getPoint(id: 4)!),
            Edge( 8, getPoint(id: 4)!, getPoint(id: 7)!),
            Edge( 9, getPoint(id: 2)!, getPoint(id: 5)!),
            Edge(10, getPoint(id: 5)!, getPoint(id: 8)!),
            Edge(11, getPoint(id: 3)!, getPoint(id: 6)!),
            Edge(12, getPoint(id: 6)!, getPoint(id: 9)!),
            
            Edge(13, getPoint(id: 1)!, getPoint(id: 5)!),
            Edge(14, getPoint(id: 5)!, getPoint(id: 9)!),
            Edge(15, getPoint(id: 7)!, getPoint(id: 5)!),
            Edge(16, getPoint(id: 5)!, getPoint(id: 3)!),
        ]
    }
}
