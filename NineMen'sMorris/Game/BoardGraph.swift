import CoreGraphics

struct Vertice: Identifiable {
    let id: Int8
    let position: CGPoint
    
    var takenBy: Player? = nil
}

struct Edge{
    let verticle1: Vertice
    let verticle2: Vertice
}

struct BoardGraph {
    private(set) var points: [Vertice] = []
    
    init() {
        createVertice()
    }
    
    private mutating func createVertice() {
        points = [
            Vertice(id:  1, position: CGPoint(x: 100, y: 100)),
            Vertice(id:  2, position: CGPoint(x: 100, y: 400)),
            Vertice(id:  3, position: CGPoint(x: 100, y: 700)),
            Vertice(id:  4, position: CGPoint(x: 200, y: 200)),
            Vertice(id:  5, position: CGPoint(x: 200, y: 400)),
            Vertice(id:  6, position: CGPoint(x: 200, y: 600)),
            Vertice(id:  7, position: CGPoint(x: 300, y: 300)),
            Vertice(id:  8, position: CGPoint(x: 300, y: 400)),
            Vertice(id:  9, position: CGPoint(x: 300, y: 500)),
            Vertice(id: 10, position: CGPoint(x: 400, y: 100)),
            Vertice(id: 11, position: CGPoint(x: 400, y: 200)),
            Vertice(id: 12, position: CGPoint(x: 400, y: 300)),
            Vertice(id: 13, position: CGPoint(x: 400, y: 500)),
            Vertice(id: 14, position: CGPoint(x: 400, y: 600)),
            Vertice(id: 15, position: CGPoint(x: 400, y: 700)),
            Vertice(id: 16, position: CGPoint(x: 500, y: 300)),
            Vertice(id: 17, position: CGPoint(x: 500, y: 400)),
            Vertice(id: 18, position: CGPoint(x: 500, y: 500)),
            Vertice(id: 19, position: CGPoint(x: 600, y: 200)),
            Vertice(id: 20, position: CGPoint(x: 600, y: 400)),
            Vertice(id: 21, position: CGPoint(x: 600, y: 600)),
            Vertice(id: 22, position: CGPoint(x: 700, y: 100)),
            Vertice(id: 23, position: CGPoint(x: 700, y: 400)),
            Vertice(id: 24, position: CGPoint(x: 700, y: 700)),
        ]
    }
}
