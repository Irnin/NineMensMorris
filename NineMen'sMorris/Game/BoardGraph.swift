import CoreGraphics

struct BoardGraph {
    private(set) var points: [Vertice] = []
    
    struct Vertice: Identifiable {
        let id: Int8
        let position: CGPoint
        
        var takenBy: Player? = nil
    }
    
    struct Edge{
        let verticle1: Vertice
        let verticle2: Vertice
    }
    
    init() {
        createVertice()
    }
    
    private mutating func createVertice() {
        points = [
            Vertice(id: 1, position: CGPoint(x: 50, y: 50)),
        ]
    }
}
