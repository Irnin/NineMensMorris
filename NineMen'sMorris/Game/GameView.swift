import SwiftUI

struct GameView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        
        HStack{
            VStack {
                Text("Nine men's morris")
                Text("Game phase \(viewModel.gamePhase())")
                
                Text("Current player: \(viewModel.currentPlayer())")
                Text("Player I men: \(viewModel.menLeft(player: .player1))")
                Text("Player II men: \(viewModel.menLeft(player: .player2))")
                
                Text("Can attack?: \(viewModel.canAttack() ? "Yes" : "No")")
                
                Spacer()
            }
            
            VStack {
                ZStack {
                    Image("oak")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: 800,
                                height: 800
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    GeometryReader { geometry in
                        
                        // Place grid
                        ForEach(viewModel.getEdges(), id: \.id) { edge in
                            let start = edge.vertex1.position
                            let end = edge.vertex2.position
                            
                            Path { path in
                                path.move(to: start)
                                path.addLine(to: end)
                            }
                            .stroke(Color.black, lineWidth: 3)
                        }
                        
                        // Place points on board
                        ForEach(viewModel.getPoints(), id: \.id) { point in
                            Point(point: point, action: {viewModel.playerAction(at: point.id)})
                        }
                    }
                    .frame(width: 800, height: 800)
                    .shadow(radius: 0.5)
                }
            }
        }
    }
}

#Preview {
    GameView()
}
